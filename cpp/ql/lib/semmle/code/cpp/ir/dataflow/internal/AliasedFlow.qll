private import cpp as Cpp
private import SsaInternals as Ssa
private import codeql.ssa.Ssa as SsaImplCommon
private import DataFlowPrivate
private import DataFlowUtil as Public
private import DataFlowNodes as Nodes
private import semmle.code.cpp.ir.IR
private import semmle.code.cpp.ir.internal.IRCppLanguage

private module SsaInput implements SsaImplCommon::InputSig<Cpp::Location> {
  import SsaInternalsCommon::InputSigCommon

  class SourceVariable = Ssa::SourceVariable;

  /**
   * Holds if `instr` flows to the destination address of a `StoreInstruction`
   * and flows from a read of some definition.
   */
  private predicate fwd(Node1Impl n, int indirectionIndex) {
    nodeHasInstruction1(n, any(VariableAddressInstruction vai), indirectionIndex)
    or
    exists(Node1Impl n0 |
      fwd(n0, indirectionIndex) and
      simpleLocalFlowStep1(n0, n, _)
    )
  }

  /**
   * Holds if `instr` flows to the destination address of a `StoreInstruction`
   */
  private predicate revStore(Node1Impl n, int indirectionIndex, int k) {
    fwd(pragma[only_bind_into](n), pragma[only_bind_into](indirectionIndex)) and
    (
      indirectionIndex > k and
      nodeHasOperand1(n, any(StoreInstruction store).getDestinationAddressOperand(),
        indirectionIndex - k)
      or
      exists(Node1Impl n1 |
        revStore(n1, pragma[only_bind_into](indirectionIndex), k) and
        simpleLocalFlowStep1(n, n1, _)
      )
    )
  }

  private newtype TStoreNode1Impl =
    MkStoreNode1Impl(Node1Impl n, int indirectionIndex, int k) { revStore(n, indirectionIndex, k) }

  /**
   * This predicate holds if
   * ```
   * conversionFlow(instr1.getAUse(), instr2, _, false)
   * ```
   * and both `instr1` and `instr2` are instructions on a path from a read of
   * some definition to the destination address of a `StoreInstruction`.
   */
  private predicate flowStoreStep(TStoreNode1Impl node1, TStoreNode1Impl node2) {
    exists(Node1Impl n1, Node1Impl n2, int indirectionIndex, int k |
      node1 =
        MkStoreNode1Impl(n1, pragma[only_bind_into](indirectionIndex), pragma[only_bind_into](k)) and
      node2 =
        MkStoreNode1Impl(n2, pragma[only_bind_into](indirectionIndex), pragma[only_bind_into](k)) and
      simpleLocalFlowStep1(n1, n2, _)
    )
  }

  private predicate storeSink(TStoreNode1Impl sink) {
    exists(Node1Impl n, int indirectionIndex, int k |
      sink = MkStoreNode1Impl(n, indirectionIndex, k) and
      // Subtract one because a store writes to the _indirection_ of the address operand
      nodeHasOperand1(n, any(StoreInstruction store).getDestinationAddressOperand(),
        indirectionIndex - k)
    )
  }

  private predicate storeSource(TStoreNode1Impl source) {
    exists(Node1Impl n, int indirectionIndex, int k |
      source = MkStoreNode1Impl(n, indirectionIndex, k) and
      nodeHasInstruction1(n, any(VariableAddressInstruction vai), indirectionIndex)
    )
  }

  private predicate flowStorePlusImpl(TStoreNode1Impl node1, TStoreNode1Impl node2) =
    doublyBoundedFastTC(flowStoreStep/2, storeSource/1, storeSink/1)(node1, node2)

  private predicate flowStoreStepTCImpl(TStoreNode1Impl node1, TStoreNode1Impl node2) {
    storeSource(node1) and
    storeSink(node2) and
    (
      flowStorePlusImpl(node1, node2)
      or
      node1 = node2
    )
  }

  private predicate flowStoreStepTC(Node1Impl n1, Node1Impl n2, int indirectionIndex, int k) {
    exists(TStoreNode1Impl node1, TStoreNode1Impl node2 |
      node1 =
        MkStoreNode1Impl(n1, pragma[only_bind_into](indirectionIndex), pragma[only_bind_into](k)) and
      node2 =
        MkStoreNode1Impl(n2, pragma[only_bind_into](indirectionIndex), pragma[only_bind_into](k)) and
      flowStoreStepTCImpl(node1, node2)
    )
  }

  /**
   * Holds if `instr` flows to the destination address of a `StoreInstruction`
   */
  private predicate revLoad(Node1Impl n, int indirectionIndex) {
    fwd(pragma[only_bind_into](n), pragma[only_bind_into](indirectionIndex)) and
    (
      nodeHasOperand1(n, _, indirectionIndex)
      or
      exists(Node1Impl n1 |
        revLoad(n1, pragma[only_bind_into](indirectionIndex)) and
        simpleLocalFlowStep1(n, n1, _)
      )
    )
  }

  private newtype TLoadNode1Impl =
    MkLoadNode1Impl(Node1Impl n, int indirectionIndex) { revLoad(n, indirectionIndex) }

  private predicate flowLoadStep(TLoadNode1Impl node1, TLoadNode1Impl node2) {
    exists(Node1Impl n1, Node1Impl n2, int indirectionIndex |
      node1 = MkLoadNode1Impl(n1, pragma[only_bind_into](indirectionIndex)) and
      node2 = MkLoadNode1Impl(n2, pragma[only_bind_into](indirectionIndex)) and
      simpleLocalFlowStep1(n1, n2, _)
    )
  }

  private predicate loadSink(TLoadNode1Impl sink) {
    exists(Node1Impl n, int indirectionIndex |
      sink = MkLoadNode1Impl(n, indirectionIndex) and
      nodeHasOperand1(n, _, indirectionIndex)
    )
  }

  private predicate loadSource(TLoadNode1Impl source) {
    exists(Node1Impl n, int indirectionIndex |
      source = MkLoadNode1Impl(n, indirectionIndex) and
      nodeHasInstruction1(n, any(VariableAddressInstruction vai), indirectionIndex)
    )
  }

  private predicate flowLoadPlusImpl(TLoadNode1Impl node1, TLoadNode1Impl node2) =
    doublyBoundedFastTC(flowLoadStep/2, loadSource/1, loadSink/1)(node1, node2)

  private predicate flowLoadStepTCImpl(TLoadNode1Impl node1, TLoadNode1Impl node2) {
    loadSource(node1) and
    loadSink(node2) and
    (
      flowLoadPlusImpl(node1, node2)
      or
      node1 = node2
    )
  }

  private predicate flowLoadStepTC(Node1Impl n1, Node1Impl n2, int indirectionIndex) {
    exists(TLoadNode1Impl node1, TLoadNode1Impl node2 |
      node1 = MkLoadNode1Impl(n1, pragma[only_bind_into](indirectionIndex)) and
      node2 = MkLoadNode1Impl(n2, pragma[only_bind_into](indirectionIndex)) and
      flowLoadStepTCImpl(node1, node2)
    )
  }

  /**
   * Holds if the `i`'th instruction in `bb` writes to `v` through an alias.
   * `certain` is `true` if write is guaranteed to overwrite the entire
   * allocation.
   */
  additional predicate variableWrite(
    BasicBlock bb, int i, SourceVariable sv, boolean certain, Node1Impl store
  ) {
    certain = true and
    exists(
      Node1Impl vai, VariableAddressInstruction vaiInstr, StoreInstruction storeInstr, int index,
      Node1Impl dest, int k, Ssa::DefImpl def, int lower
    |
      flowStoreStepTC(vai, dest, index, k) and
      nodeHasInstruction1(vai, vaiInstr, index) and
      nodeHasOperand1(dest, storeInstr.getDestinationAddressOperand(), index - k) and
      sv.getIRVariable() = vaiInstr.getIRVariable() and
      lower =
        pragma[only_bind_out](getMinIndirectionsForType(storeInstr
              .getDestinationAddress()
              .getResultType())) and
      sv.getIndirection() = index + lower and
      nodeHasInstruction1(store, storeInstr, index - k) and
      def.getNode() = store and
      def.hasIndexInBlock(bb, i)
    )
  }

  predicate variableWrite(BasicBlock bb, int i, SourceVariable sv, boolean certain) {
    variableWrite(bb, i, sv, certain, _)
  }

  additional predicate variableRead(
    BasicBlock bb, int i, SourceVariable sv, boolean certain, Node1Impl load
  ) {
    certain = true and
    exists(Node1Impl vai, int index, VariableAddressInstruction vaiInstr, Ssa::UseImpl use |
      flowLoadStepTC(vai, load, index) and
      nodeHasInstruction1(vai, vaiInstr, index) and
      sv.getIRVariable() = vaiInstr.getIRVariable() and
      sv.getIndirection() = index and
      use.getNode() = load and
      use.hasIndexInBlock(bb, i)
    )
  }

  predicate variableRead(BasicBlock bb, int i, SourceVariable sv, boolean certain) {
    variableRead(bb, i, sv, certain, _)
  }
}

private module AliasedSsa = SsaImplCommon::Make<Cpp::Location, SsaInput>;

private newtype TAliasedNode =
  TNode1(Node1Impl n) or
  TPhiNode(AliasedSsa::DefinitionExt phi) {
    phi instanceof AliasedSsa::PhiNode or
    phi instanceof AliasedSsa::PhiReadNode
  }

abstract private class AliasedNode extends TAliasedNode {
  abstract string toString();

  Instruction asInstruction() { none() }

  abstract Cpp::Function getFunction();

  abstract predicate isGLValue();

  abstract Cpp::Type getType();

  abstract Cpp::Location getLocation();
}

class AliasedNodeImpl = AliasedNode;

private class Node1 extends AliasedNode, TNode1 {
  Node1Impl n;

  Node1() { this = TNode1(n) }

  Node1Impl getImpl() { result = n }

  final override string toString() { result = n.toString() }

  final override Instruction asInstruction() { result = n.asInstruction() }

  final override Cpp::Function getFunction() { result = n.getFunction() }

  final override predicate isGLValue() { n.isGLValue() }

  final override Cpp::Type getType() { result = n.getType() }

  final override Cpp::Location getLocation() { result = n.getLocation() }
}

private class PhiNode extends AliasedNode, TPhiNode {
  AliasedSsa::DefinitionExt phi;

  PhiNode() { this = TPhiNode(phi) }

  final override string toString() { result = phi.toString() }

  AliasedSsa::DefinitionExt getPhi() { result = phi }

  final override Cpp::Function getFunction() { result = phi.getBasicBlock().getEnclosingFunction() }

  final override predicate isGLValue() { phi.getSourceVariable().isGLValue() }

  final override Cpp::Type getType() { result = phi.getSourceVariable().getType() }

  final override Cpp::Location getLocation() { result = phi.getLocation() }
}

class AliasedPhiNodeImpl = PhiNode;

private predicate step(SsaInput::SourceVariable sv, IRBlock bb1, int i1, AliasedNode node2) {
  exists(AliasedSsa::DefinitionExt def, Node1Impl load, IRBlock bb2, int i2 |
    AliasedSsa::adjacentDefReadExt(def, sv, bb1, i1, bb2, i2) and
    SsaInput::variableRead(bb2, i2, sv, _, load) and
    TNode1(load) = node2
  )
}

private predicate access(SsaInput::SourceVariable sv, IRBlock bb, int i, AliasedNode node1) {
  exists(Node1Impl n | node1 = TNode1(n) |
    SsaInput::variableWrite(bb, i, sv, _, n)
    or
    SsaInput::variableRead(bb, i, sv, _, n)
  )
  or
  node1.(PhiNode).getPhi().definesAt(sv, bb, i, _)
}

private predicate stepToPhi(SsaInput::SourceVariable sv, IRBlock bb, int i, PhiNode node) {
  exists(AliasedSsa::DefinitionExt phi |
    AliasedSsa::lastRefRedefExt(_, sv, bb, i, phi) and
    node.getPhi() = phi
  )
}

predicate into(Public::Node node1, TPhiNode node2) {
  exists(Node1Impl n |
    node1 = Nodes::TNode1(n) and
    aliasedFlow(TNode1(n), node2)
  )
}

predicate step1(Public::Node node1, Public::Node node2) {
  exists(Node1Impl n1, Node1Impl n2 |
    node1 = Nodes::TNode1(n1) and
    node2 = Nodes::TNode1(n2) and
    aliasedFlow(TNode1(n1), TNode1(n2))
  )
}

predicate step2(TPhiNode node1, TPhiNode node2) { aliasedFlow(node1, node2) }

predicate out(TPhiNode node1, Public::Node node2) {
  exists(Node1Impl n |
    node2 = Nodes::TNode1(n) and
    aliasedFlow(node1, TNode1(n))
  )
}

private predicate aliasedFlow(AliasedNode node1, AliasedNode node2) {
  node1 != node2 and
  (
    exists(IRBlock bb, int i, SsaInput::SourceVariable sv |
      access(sv, bb, i, node1) and
      step(sv, bb, i, node2)
    )
    or
    exists(IRBlock bb, int i, SsaInput::SourceVariable sv |
      access(sv, bb, i, node1) and
      stepToPhi(sv, bb, i, node2)
    )
  )
}
