private import cpp
private import DataFlowPrivate
private import semmle.code.cpp.ir.IR
private import DataFlowImplCommon as DataFlowImplCommon
private import SsaInternals as Ssa
private import semmle.code.cpp.dataflow.internal.FlowSummaryImpl as FlowSummaryImpl
private import AliasedFlow

/**
 * The IR dataflow graph consists of the following nodes:
 * - `Node1`, which injects most instructions and operands directly into the
 *    dataflow graph, as well as indirections of these instructions and
 *    operands.
 * - `VariableNode`, which is used to model flow through global variables.
 * - `PostUpdateNodeImpl`, which is used to model the state of an object after
 *    an update after a number of loads.
 * - `SsaPhiNode`, which represents phi nodes as computed by the shared SSA
 *    library.
 */
cached
newtype TIRDataFlowNode =
  TNode1(Node1Impl node) { DataFlowImplCommon::forceCachingInSameStage() } or
  TGlobalLikeVariableNode(GlobalLikeVariable var, int indirectionIndex) {
    indirectionIndex =
      [getMinIndirectionsForType(var.getUnspecifiedType()) .. Ssa::getMaxIndirectionsForType(var.getUnspecifiedType())]
  } or
  TSsaIteratorNode(IteratorFlow::IteratorFlowNode n) or
  TBodyLessParameterNodeImpl(Parameter p, int indirectionIndex) {
    // Rule out parameters of catch blocks.
    not exists(p.getCatchBlock()) and
    // We subtract one because `getMaxIndirectionsForType` returns the maximum
    // indirection for a glvalue of a given type, and this doesn't apply to
    // parameters.
    indirectionIndex = [0 .. Ssa::getMaxIndirectionsForType(p.getUnspecifiedType()) - 1] and
    not any(InitializeParameterInstruction init).getParameter() = p
  } or
  TAliasedPhiNode(AliasedPhiNodeImpl n) or
  TFlowSummaryNode(FlowSummaryImpl::Private::SummaryNode sn)
