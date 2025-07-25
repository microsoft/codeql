/**
 * Provides Rust-specific definitions for use in the data flow library.
 */

private import codeql.util.Void
private import codeql.util.Unit
private import codeql.util.Boolean
private import codeql.dataflow.DataFlow
private import codeql.dataflow.internal.DataFlowImpl
private import rust
private import codeql.rust.elements.Call
private import SsaImpl as SsaImpl
private import codeql.rust.controlflow.internal.Scope as Scope
private import codeql.rust.internal.PathResolution
private import codeql.rust.internal.TypeInference as TypeInference
private import codeql.rust.controlflow.ControlFlowGraph
private import codeql.rust.controlflow.CfgNodes
private import codeql.rust.dataflow.Ssa
private import codeql.rust.dataflow.FlowSummary
private import Node
private import Content
private import FlowSummaryImpl as FlowSummaryImpl


/**
 * A return kind. A return kind describes how a value can be returned from a
 * callable.
 *
 * The only return kind is a "normal" return from a `return` statement or an
 * expression body.
 */
final class ReturnKind extends TNormalReturnKind {
  string toString() { result = "return" }
}

/**
 * A callable. This includes callables from source code, as well as callables
 * defined in library code.
 */
final class DataFlowCallable extends TDataFlowCallable {
  /**
   * Gets the underlying CFG scope, if any.
   */
  CfgScope asCfgScope() { this = TCfgScope(result) }

  /**
   * Gets the underlying library callable, if any.
   */
  SummarizedCallable asSummarizedCallable() { this = TSummarizedCallable(result) }

  /** Gets a textual representation of this callable. */
  string toString() {
    result = [this.asCfgScope().toString(), this.asSummarizedCallable().toString()]
  }

  /** Gets the location of this callable. */
  Location getLocation() { result = this.asCfgScope().getLocation() }

  //** TODO JB1: Move to subclass, monkey patching for #153 */
  int totalorder(){ none() }
  //** TODO JB1: end stubs for #153 */
}

final class DataFlowCall extends TDataFlowCall {
  /** Gets the underlying call in the CFG, if any. */
  CallCfgNode asCallCfgNode() { this = TCall(result) }

  predicate isSummaryCall(
    FlowSummaryImpl::Public::SummarizedCallable c, FlowSummaryImpl::Private::SummaryNode receiver
  ) {
    this = TSummaryCall(c, receiver)
  }

  DataFlowCallable getEnclosingCallable() {
    result.asCfgScope() = this.asCallCfgNode().getExpr().getEnclosingCfgScope()
    or
    this.isSummaryCall(result.asSummarizedCallable(), _)
  }

  string toString() {
    result = this.asCallCfgNode().toString()
    or
    exists(
      FlowSummaryImpl::Public::SummarizedCallable c, FlowSummaryImpl::Private::SummaryNode receiver
    |
      this.isSummaryCall(c, receiver) and
      result = "[summary] call to " + receiver + " in " + c
    )
  }

  Location getLocation() { result = this.asCallCfgNode().getLocation() }

  //** TODO JB1: Move to subclass, monkey patching for #153 */
  DataFlowCallable getARuntimeTarget(){ none() }
  ArgumentNode getAnArgumentNode(){ none() }
  int totalorder(){ none() }
  //** TODO JB1: end stubs for #153 */
}

/**
 * The position of a parameter in a function.
 *
 * In Rust there is a 1-to-1 correspondence between parameter positions and
 * arguments positions, so we use the same underlying type for both.
 */
final class ParameterPosition extends TParameterPosition {
  /** Gets the underlying integer position, if any. */
  int getPosition() { this = TPositionalParameterPosition(result) }

  predicate hasPosition() { exists(this.getPosition()) }

  /** Holds if this position represents the `self` position. */
  predicate isSelf() { this = TSelfParameterPosition() }

  /**
   * Holds if this position represents a reference to a closure itself. Only
   * used for tracking flow through captured variables.
   */
  predicate isClosureSelf() { this = TClosureSelfParameterPosition() }

  /** Gets a textual representation of this position. */
  string toString() {
    result = this.getPosition().toString()
    or
    result = "self" and this.isSelf()
    or
    result = "closure self" and this.isClosureSelf()
  }

  ParamBase getParameterIn(ParamList ps) {
    result = ps.getParam(this.getPosition())
    or
    result = ps.getSelfParam() and this.isSelf()
  }
}

/**
 * The position of an argument in a call.
 *
 * In Rust there is a 1-to-1 correspondence between parameter positions and
 * arguments positions, so we use the same underlying type for both.
 */
final class ArgumentPosition extends ParameterPosition {
  /** Gets the argument of `call` at this position, if any. */
  Expr getArgument(Call call) {
    result = call.getPositionalArgument(this.getPosition())
    or
    result = call.getReceiver() and this.isSelf()
  }
}

/**
 * Holds if `arg` is an argument of `call` at the position `pos`.
 *
 * Note that this does not hold for the receiever expression of a method call
 * as the synthetic `ReceiverNode` is the argument for the `self` parameter.
 */
predicate isArgumentForCall(ExprCfgNode arg, CallCfgNode call, ParameterPosition pos) {
  // TODO: Handle index expressions as calls in data flow.
  not call.getCall() instanceof IndexExpr and
  (
    call.getPositionalArgument(pos.getPosition()) = arg
    or
    call.getReceiver() = arg and pos.isSelf() and not call.getCall().receiverImplicitlyBorrowed()
  )
}

/** Provides logic related to SSA. */
module SsaFlow {
  private module SsaFlow = SsaImpl::DataFlowIntegration;

  /** Converts a control flow node into an SSA control flow node. */
  SsaFlow::Node asNode(Node n) {
    n = TSsaNode(result)
    or
    result.(SsaFlow::ExprNode).getExpr() = n.asExpr()
    or
    result.(SsaFlow::ExprPostUpdateNode).getExpr() = n.(PostUpdateNode).getPreUpdateNode().asExpr()
  }

  predicate localFlowStep(
    SsaImpl::SsaInput::SourceVariable v, Node nodeFrom, Node nodeTo, boolean isUseStep
  ) {
    SsaFlow::localFlowStep(v, asNode(nodeFrom), asNode(nodeTo), isUseStep)
  }

  predicate localMustFlowStep(Node nodeFrom, Node nodeTo) {
    SsaFlow::localMustFlowStep(_, asNode(nodeFrom), asNode(nodeTo))
  }
}

/**
 * Gets a node that may execute last in `n`, and which, when it executes last,
 * will be the value of `n`.
 */
private ExprCfgNode getALastEvalNode(ExprCfgNode e) {
  e = any(IfExprCfgNode n | result = [n.getThen(), n.getElse()]) or
  result = e.(LoopExprCfgNode).getLoopBody() or
  result = e.(ReturnExprCfgNode).getExpr() or
  result = e.(BreakExprCfgNode).getExpr() or
  result = e.(BlockExprCfgNode).getTailExpr() or
  result = e.(MacroBlockExprCfgNode).getTailExpr() or
  result = e.(MatchExprCfgNode).getArmExpr(_) or
  result = e.(MacroExprCfgNode).getMacroCall().(MacroCallCfgNode).getExpandedNode() or
  result.(BreakExprCfgNode).getTarget() = e
}

/**
 * Holds if a reverse local flow step should be added from the post-update node
 * for `e` to the post-update node for the result.
 *
 * This is needed to allow for side-effects on compound expressions to propagate
 * to sub components. For example, in
 *
 * ```rust
 * ({ foo(); &mut a}).set_data(taint);
 * ```
 *
 * we add a reverse flow step from `[post] { foo(); &mut a}` to `[post] &mut a`,
 * in order for the side-effect of `set_data` to reach `&mut a`.
 */
ExprCfgNode getPostUpdateReverseStep(ExprCfgNode e, boolean preservesValue) {
  result = getALastEvalNode(e) and
  preservesValue = true
  or
  result = e.(CastExprCfgNode).getExpr() and
  preservesValue = false
}

module LocalFlow {
  predicate flowSummaryLocalStep(Node nodeFrom, Node nodeTo, string model) {
    exists(FlowSummaryImpl::Public::SummarizedCallable c |
      FlowSummaryImpl::Private::Steps::summaryLocalStep(nodeFrom.(FlowSummaryNode).getSummaryNode(),
        nodeTo.(FlowSummaryNode).getSummaryNode(), true, model) and
      c = nodeFrom.(FlowSummaryNode).getSummarizedCallable()
    )
    or
    FlowSummaryImpl::Private::Steps::sourceLocalStep(nodeFrom.(FlowSummaryNode).getSummaryNode(),
      nodeTo, model)
    or
    FlowSummaryImpl::Private::Steps::sinkLocalStep(nodeFrom,
      nodeTo.(FlowSummaryNode).getSummaryNode(), model)
  }

  pragma[nomagic]
  predicate localFlowStepCommon(Node nodeFrom, Node nodeTo) {
    nodeFrom.getCfgNode() = getALastEvalNode(nodeTo.getCfgNode())
    or
    // An edge from the right-hand side of a let statement to the left-hand side.
    exists(LetStmtCfgNode s |
      nodeFrom.getCfgNode() = s.getInitializer() and
      nodeTo.getCfgNode() = s.getPat()
    )
    or
    exists(IdentPatCfgNode p |
      not p.isRef() and
      nodeFrom.getCfgNode() = p and
      nodeTo.getCfgNode() = p.getName()
    )
    or
    exists(SelfParamCfgNode self |
      nodeFrom.getCfgNode() = self and
      nodeTo.getCfgNode() = self.getName()
    )
    or
    // An edge from a pattern/expression to its corresponding SSA definition.
    nodeFrom.(AstCfgFlowNode).getCfgNode() =
      nodeTo.(SsaNode).asDefinition().(Ssa::WriteDefinition).getControlFlowNode()
    or
    nodeFrom.(SourceParameterNode).getParameter().(ParamCfgNode).getPat() = nodeTo.asPat()
    or
    exists(AssignmentExprCfgNode a |
      a.getRhs() = nodeFrom.getCfgNode() and
      a.getLhs() = nodeTo.getCfgNode()
    )
    or
    exists(MatchExprCfgNode match |
      nodeFrom.asExpr() = match.getScrutinee() and
      nodeTo.asPat() = match.getArmPat(_)
    )
    or
    nodeFrom.asPat().(OrPatCfgNode).getAPat() = nodeTo.asPat()
    or
    // Simple value step from receiver expression to receiver node, in case
    // there is no implicit deref or borrow operation.
    nodeFrom.asExpr() = nodeTo.(ReceiverNode).getReceiver()
    or
    // The dual step of the above, for the post-update nodes.
    nodeFrom.(PostUpdateNode).getPreUpdateNode().(ReceiverNode).getReceiver() =
      nodeTo.(PostUpdateNode).getPreUpdateNode().asExpr()
    or
    nodeTo.(PostUpdateNode).getPreUpdateNode().asExpr() =
      getPostUpdateReverseStep(nodeFrom.(PostUpdateNode).getPreUpdateNode().asExpr(), true)
  }
}

class LambdaCallKind = Unit;

/** Holds if `creation` is an expression that creates a lambda of kind `kind`. */
predicate lambdaCreationExpr(Expr creation, LambdaCallKind kind) {
  (
    creation instanceof ClosureExpr
    or
    creation instanceof Scope::AsyncBlockScope
  ) and
  exists(kind)
}

/**
 * Holds if `call` is a lambda call of kind `kind` where `receiver` is the
 * invoked expression.
 */
predicate lambdaCallExpr(CallExprCfgNode call, LambdaCallKind kind, ExprCfgNode receiver) {
  receiver = call.getFunction() and
  // All calls to complex expressions and local variable accesses are lambda call.
  exists(Expr f | f = receiver.getExpr() |
    f instanceof PathExpr implies f = any(Variable v).getAnAccess()
  ) and
  exists(kind)
}

// Defines a set of aliases needed for the `RustDataFlow` module
private module Aliases {
  class DataFlowCallableAlias = DataFlowCallable;

  class ReturnKindAlias = ReturnKind;

  class DataFlowCallAlias = DataFlowCall;

  class ParameterPositionAlias = ParameterPosition;

  class ArgumentPositionAlias = ArgumentPosition;

  class ContentAlias = Content;

  class ContentSetAlias = ContentSet;

  class LambdaCallKindAlias = LambdaCallKind;
}

module RustDataFlow implements InputSig<Location> {
  private import Aliases
  private import codeql.rust.dataflow.DataFlow
  private import Node as Node
  private import codeql.rust.frameworks.stdlib.Stdlib

  /**
   * An element, viewed as a node in a data flow graph. Either an expression
   * (`ExprNode`) or a parameter (`ParameterNode`).
   */
  class Node = DataFlow::Node;

  final class ParameterNode = Node::ParameterNode;

  final class ArgumentNode = Node::ArgumentNode;

  final class ReturnNode = Node::ReturnNode;

  final class OutNode = Node::OutNode;

  class PostUpdateNode = DataFlow::PostUpdateNode;

  final class CastNode = Node::CastNode;

  /** Holds if `p` is a parameter of `c` at the position `pos`. */
  predicate isParameterNode(ParameterNode p, DataFlowCallable c, ParameterPosition pos) {
    p.isParameterOf(c, pos)
  }

  /** Holds if `n` is an argument of `c` at the position `pos`. */
  predicate isArgumentNode(ArgumentNode n, DataFlowCall call, ArgumentPosition pos) {
    n.isArgumentOf(call, pos)
  }

  DataFlowCallable nodeGetEnclosingCallable(Node node) {
    result = node.(Node::Node).getEnclosingCallable()
  }

  DataFlowType getNodeType(Node node) { any() }

  predicate nodeIsHidden(Node node) {
    node instanceof SsaNode or
    node.(FlowSummaryNode).getSummaryNode().isHidden() or
    node instanceof CaptureNode or
    node instanceof ClosureParameterNode or
    node instanceof ReceiverNode or
    node instanceof ReceiverPostUpdateNode
  }

  predicate neverSkipInPathGraph(Node node) {
    node.(Node::Node).getCfgNode() = any(LetStmtCfgNode s).getPat()
    or
    node.(Node::Node).getCfgNode() = any(AssignmentExprCfgNode a).getLhs()
    or
    exists(MatchExprCfgNode match |
      node.asExpr() = match.getScrutinee() or
      node.asExpr() = match.getArmPat(_)
    )
    or
    FlowSummaryImpl::Private::Steps::sourceLocalStep(_, node, _)
    or
    FlowSummaryImpl::Private::Steps::sinkLocalStep(node, _, _)
  }

  class DataFlowExpr = ExprCfgNode;

  /** Gets the node corresponding to `e`. */
  Node exprNode(DataFlowExpr e) { result.asExpr() = e }

  final class DataFlowCall = DataFlowCallAlias;

  final class DataFlowCallable = DataFlowCallableAlias;

  final class ReturnKind = ReturnKindAlias;

  /** Gets a viable implementation of the target of the given `Call`. */
  DataFlowCallable viableCallable(DataFlowCall call) {
    exists(Callable target | target = call.asCallCfgNode().getCall().getStaticTarget() |
      target = result.asCfgScope()
      or
      target = result.asSummarizedCallable()
    )
  }

  /**
   * Gets a node that can read the value returned from `call` with return kind
   * `kind`.
   */
  OutNode getAnOutNode(DataFlowCall call, ReturnKind kind) { call = result.getCall(kind) }

  // NOTE: For now we use the type `Unit` and do not benefit from type
  // information in the data flow analysis.
  final class DataFlowType extends Unit {
    string toString() { result = "" }
  }

  predicate compatibleTypes(DataFlowType t1, DataFlowType t2) { any() }

  predicate typeStrongerThan(DataFlowType t1, DataFlowType t2) { none() }

  class Content = ContentAlias;

  class ContentSet = ContentSetAlias;

  class LambdaCallKind = LambdaCallKindAlias;

  predicate forceHighPrecision(Content c) { none() }

  final class ContentApprox = Content; // TODO: Implement if needed

  ContentApprox getContentApprox(Content c) { result = c }

  class ParameterPosition = ParameterPositionAlias;

  class ArgumentPosition = ArgumentPositionAlias;

  /**
   * Holds if the parameter position `ppos` matches the argument position
   * `apos`.
   */
  predicate parameterMatch(ParameterPosition ppos, ArgumentPosition apos) { ppos = apos }

  /**
   * Holds if there is a simple local flow step from `node1` to `node2`. These
   * are the value-preserving intra-callable flow steps.
   */
  predicate simpleLocalFlowStep(Node nodeFrom, Node nodeTo, string model) {
    (
      LocalFlow::localFlowStepCommon(nodeFrom, nodeTo)
      or
      exists(SsaImpl::SsaInput::SourceVariable v, boolean isUseStep |
        SsaFlow::localFlowStep(v, nodeFrom, nodeTo, isUseStep) and
        not v instanceof VariableCapture::CapturedVariable
      |
        isUseStep = false
        or
        isUseStep = true and
        not FlowSummaryImpl::Private::Steps::prohibitsUseUseFlow(nodeFrom, _)
      )
      or
      VariableCapture::localFlowStep(nodeFrom, nodeTo)
    ) and
    model = ""
    or
    LocalFlow::flowSummaryLocalStep(nodeFrom, nodeTo, model)
    or
    // Add flow through optional barriers. This step is then blocked by the barrier for queries that choose to use the barrier.
    FlowSummaryImpl::Private::Steps::summaryReadStep(nodeFrom
          .(Node::FlowSummaryNode)
          .getSummaryNode(), TOptionalBarrier(_), nodeTo.(Node::FlowSummaryNode).getSummaryNode()) and
    model = ""
  }

  /**
   * Holds if data can flow from `node1` to `node2` through a non-local step
   * that does not follow a call edge. For example, a step through a global
   * variable.
   */
  predicate jumpStep(Node node1, Node node2) {
    FlowSummaryImpl::Private::Steps::summaryJumpStep(node1.(FlowSummaryNode).getSummaryNode(),
      node2.(FlowSummaryNode).getSummaryNode())
  }

  pragma[nomagic]
  private predicate implicitDerefToReceiver(Node node1, ReceiverNode node2, ReferenceContent c) {
    TypeInference::receiverHasImplicitDeref(node1.asExpr().getExpr()) and
    node1.asExpr() = node2.getReceiver() and
    exists(c)
  }

  pragma[nomagic]
  private predicate implicitBorrowToReceiver(Node node1, ReceiverNode node2, ReferenceContent c) {
    TypeInference::receiverHasImplicitBorrow(node1.asExpr().getExpr()) and
    node1.asExpr() = node2.getReceiver() and
    exists(c)
  }

  pragma[nomagic]
  private predicate referenceExprToExpr(Node node1, Node node2, ReferenceContent c) {
    node1.asExpr() = node2.asExpr().(RefExprCfgNode).getExpr() and
    exists(c)
  }

  pragma[nomagic]
  additional predicate readContentStep(Node node1, Content c, Node node2) {
    exists(TupleStructPatCfgNode pat, int pos |
      pat = node1.asPat() and
      node2.asPat() = pat.getField(pos) and
      c = TTupleFieldContent(pat.getTupleStructPat().getTupleField(pos))
    )
    or
    exists(TuplePatCfgNode pat, int pos |
      pos = c.(TuplePositionContent).getPosition() and
      node1.asPat() = pat and
      node2.asPat() = pat.getField(pos)
    )
    or
    exists(StructPatCfgNode pat, string field |
      pat = node1.asPat() and
      c = TStructFieldContent(pat.getStructPat().getStructField(field)) and
      node2.asPat() = pat.getFieldPat(field)
    )
    or
    c instanceof ReferenceContent and
    node1.asPat().(RefPatCfgNode).getPat() = node2.asPat()
    or
    exists(FieldExprCfgNode access |
      node1.asExpr() = access.getContainer() and
      node2.asExpr() = access and
      access = c.(FieldContent).getAnAccess()
    )
    or
    exists(IndexExprCfgNode arr |
      c instanceof ElementContent and
      node1.asExpr() = arr.getBase() and
      node2.asExpr() = arr
    )
    or
    exists(ForExprCfgNode for |
      c instanceof ElementContent and
      node1.asExpr() = for.getIterable() and
      node2.asPat() = for.getPat()
    )
    or
    exists(SlicePatCfgNode pat |
      c instanceof ElementContent and
      node1.asPat() = pat and
      node2.asPat() = pat.getAPat()
    )
    or
    exists(TryExprCfgNode try |
      node1.asExpr() = try.getExpr() and
      node2.asExpr() = try and
      c.(TupleFieldContent)
          .isVariantField([any(OptionEnum o).getSome(), any(ResultEnum r).getOk()], 0)
    )
    or
    exists(PrefixExprCfgNode deref |
      c instanceof ReferenceContent and
      deref.getOperatorName() = "*" and
      node1.asExpr() = deref.getExpr() and
      node2.asExpr() = deref
    )
    or
    // Read from function return
    exists(DataFlowCall call |
      lambdaCall(call, _, node1) and
      call = node2.(OutNode).getCall(TNormalReturnKind()) and
      c instanceof FunctionCallReturnContent
    )
    or
    exists(AwaitExprCfgNode await |
      c instanceof FutureContent and
      node1.asExpr() = await.getExpr() and
      node2.asExpr() = await
    )
    or
    referenceExprToExpr(node2.(PostUpdateNode).getPreUpdateNode(),
      node1.(PostUpdateNode).getPreUpdateNode(), c)
    or
    // Step from receiver expression to receiver node, in case of an implicit
    // dereference.
    implicitDerefToReceiver(node1, node2, c)
    or
    // A read step dual to the store step for implicit borrows.
    implicitBorrowToReceiver(node2.(PostUpdateNode).getPreUpdateNode(),
      node1.(PostUpdateNode).getPreUpdateNode(), c)
    or
    VariableCapture::readStep(node1, c, node2)
  }

  /**
   * Holds if data can flow from `node1` to `node2` via a read of `c`.  Thus,
   * `node1` references an object with a content `c.getAReadContent()` whose
   * value ends up in `node2`.
   */
  predicate readStep(Node node1, ContentSet cs, Node node2) {
    exists(Content c |
      c = cs.(SingletonContentSet).getContent() and
      readContentStep(node1, c, node2)
    )
    or
    FlowSummaryImpl::Private::Steps::summaryReadStep(node1.(FlowSummaryNode).getSummaryNode(), cs,
      node2.(FlowSummaryNode).getSummaryNode()) and
    not isSpecialContentSet(cs)
  }

  /**
   * Holds if `cs` is used to encode a special operation as a content component, but should not
   * be treated as an ordinary content component.
   */
  private predicate isSpecialContentSet(ContentSet cs) {
    cs instanceof TOptionalStep or
    cs instanceof TOptionalBarrier
  }

  pragma[nomagic]
  private predicate fieldAssignment(Node node1, Node node2, FieldContent c) {
    exists(AssignmentExprCfgNode assignment, FieldExprCfgNode access |
      assignment.getLhs() = access and
      node1.asExpr() = assignment.getRhs() and
      node2.asExpr() = access.getContainer() and
      access = c.getAnAccess()
    )
  }

  pragma[nomagic]
  private predicate referenceAssignment(Node node1, Node node2, ReferenceContent c) {
    exists(AssignmentExprCfgNode assignment, PrefixExprCfgNode deref |
      assignment.getLhs() = deref and
      deref.getOperatorName() = "*" and
      node1.asExpr() = assignment.getRhs() and
      node2.asExpr() = deref.getExpr() and
      exists(c)
    )
  }

  pragma[nomagic]
  additional predicate storeContentStep(Node node1, Content c, Node node2) {
    exists(CallExprCfgNode call, int pos |
      node1.asExpr() = call.getArgument(pragma[only_bind_into](pos)) and
      node2.asExpr() = call and
      c = TTupleFieldContent(call.getCallExpr().getTupleField(pragma[only_bind_into](pos)))
    )
    or
    exists(StructExprCfgNode re, string field |
      c = TStructFieldContent(re.getStructExpr().getStructField(field)) and
      node1.asExpr() = re.getFieldExpr(field) and
      node2.asExpr() = re
    )
    or
    exists(TupleExprCfgNode tuple |
      node1.asExpr() = tuple.getField(c.(TuplePositionContent).getPosition()) and
      node2.asExpr() = tuple
    )
    or
    c instanceof ElementContent and
    node1.asExpr() =
      [
        node2.asExpr().(ArrayRepeatExprCfgNode).getRepeatOperand(),
        node2.asExpr().(ArrayListExprCfgNode).getAnExpr()
      ]
    or
    // Store from a `ref` identifier pattern into the contained name.
    exists(IdentPatCfgNode p |
      c instanceof ReferenceContent and
      p.isRef() and
      node1.asPat() = p and
      node2.(NameNode).asName() = p.getName()
    )
    or
    fieldAssignment(node1, node2.(PostUpdateNode).getPreUpdateNode(), c)
    or
    referenceAssignment(node1, node2.(PostUpdateNode).getPreUpdateNode(), c)
    or
    exists(AssignmentExprCfgNode assignment, IndexExprCfgNode index |
      c instanceof ElementContent and
      assignment.getLhs() = index and
      node1.asExpr() = assignment.getRhs() and
      node2.(PostUpdateNode).getPreUpdateNode().asExpr() = index.getBase()
    )
    or
    referenceExprToExpr(node1, node2, c)
    or
    // Store in function argument
    exists(DataFlowCall call, int i |
      isArgumentNode(node1, call, TPositionalParameterPosition(i)) and
      lambdaCall(call, _, node2.(PostUpdateNode).getPreUpdateNode()) and
      c.(FunctionCallArgumentContent).getPosition() = i
    )
    or
    VariableCapture::storeStep(node1, c, node2)
    or
    // Step from receiver expression to receiver node, in case of an implicit
    // borrow.
    implicitBorrowToReceiver(node1, node2, c)
  }

  /**
   * Holds if data can flow from `node1` to `node2` via a store into `c`.  Thus,
   * `node2` references an object with a content `c.getAStoreContent()` that
   * contains the value of `node1`.
   */
  predicate storeStep(Node node1, ContentSet cs, Node node2) {
    storeContentStep(node1, cs.(SingletonContentSet).getContent(), node2)
    or
    FlowSummaryImpl::Private::Steps::summaryStoreStep(node1.(FlowSummaryNode).getSummaryNode(), cs,
      node2.(FlowSummaryNode).getSummaryNode()) and
    not isSpecialContentSet(cs)
  }

  /**
   * Holds if values stored inside content `c` are cleared at node `n`. For example,
   * any value stored inside `f` is cleared at the pre-update node associated with `x`
   * in `x.f = newValue`.
   */
  predicate clearsContent(Node n, ContentSet cs) {
    fieldAssignment(_, n, cs.(SingletonContentSet).getContent())
    or
    referenceAssignment(_, n, cs.(SingletonContentSet).getContent())
    or
    FlowSummaryImpl::Private::Steps::summaryClearsContent(n.(FlowSummaryNode).getSummaryNode(), cs)
    or
    VariableCapture::clearsContent(n, cs.(SingletonContentSet).getContent())
  }

  /**
   * Holds if the value that is being tracked is expected to be stored inside content `c`
   * at node `n`.
   */
  predicate expectsContent(Node n, ContentSet cs) {
    FlowSummaryImpl::Private::Steps::summaryExpectsContent(n.(FlowSummaryNode).getSummaryNode(), cs)
  }

  class NodeRegion instanceof Void {
    string toString() { result = "NodeRegion" }

    predicate contains(Node n) { none() }

    //** TODO JB1: Move to subclass, monkey patching for #153 */
    int totalOrder(){ none() }
    //** TODO JB1: end stubs for #153 */
  }

  /**
   * Holds if the nodes in `nr` are unreachable when the call context is `call`.
   */
  predicate isUnreachableInCall(NodeRegion nr, DataFlowCall call) { none() }

  /**
   * Holds if flow is allowed to pass from parameter `p` and back to itself as a
   * side-effect, resulting in a summary from `p` to itself.
   *
   * One example would be to allow flow like `p.foo = p.bar;`, which is disallowed
   * by default as a heuristic.
   */
  predicate allowParameterReturnInSelf(ParameterNode p) {
    exists(DataFlowCallable c, ParameterPosition pos |
      p.isParameterOf(c, pos) and
      FlowSummaryImpl::Private::summaryAllowParameterReturnInSelf(c.asSummarizedCallable(), pos)
    )
    or
    VariableCapture::Flow::heuristicAllowInstanceParameterReturnInSelf(p.(ClosureParameterNode)
          .getCfgScope())
  }

  /**
   * Holds if the value of `node2` is given by `node1`.
   *
   * This predicate is combined with type information in the following way: If
   * the data flow library is able to compute an improved type for `node1` then
   * it will also conclude that this type applies to `node2`. Vice versa, if
   * `node2` must be visited along a flow path, then any type known for `node2`
   * must also apply to `node1`.
   */
  predicate localMustFlowStep(Node node1, Node node2) {
    SsaFlow::localMustFlowStep(node1, node2)
    or
    FlowSummaryImpl::Private::Steps::summaryLocalMustFlowStep(node1
          .(FlowSummaryNode)
          .getSummaryNode(), node2.(FlowSummaryNode).getSummaryNode())
  }

  /** Holds if `creation` is an expression that creates a lambda of kind `kind` for `c`. */
  predicate lambdaCreation(Node creation, LambdaCallKind kind, DataFlowCallable c) {
    exists(Expr e |
      e = creation.asExpr().getExpr() and lambdaCreationExpr(e, kind) and e = c.asCfgScope()
    )
  }

  /**
   * Holds if `call` is a lambda call of kind `kind` where `receiver` is the
   * invoked expression.
   */
  predicate lambdaCall(DataFlowCall call, LambdaCallKind kind, Node receiver) {
    (
      receiver.asExpr() = call.asCallCfgNode().(CallExprCfgNode).getFunction() and
      // All calls to complex expressions and local variable accesses are lambda call.
      exists(Expr f | f = receiver.asExpr().getExpr() |
        f instanceof PathExpr implies f = any(Variable v).getAnAccess()
      )
      or
      call.isSummaryCall(_, receiver.(FlowSummaryNode).getSummaryNode())
    ) and
    exists(kind)
  }

  /** Extra data flow steps needed for lambda flow analysis. */
  predicate additionalLambdaFlowStep(Node nodeFrom, Node nodeTo, boolean preservesValue) { none() }

  predicate knownSourceModel(Node source, string model) {
    source.(FlowSummaryNode).isSource(_, model)
  }

  predicate knownSinkModel(Node sink, string model) { sink.(FlowSummaryNode).isSink(_, model) }

  class DataFlowSecondLevelScope = Void;
}

/** Provides logic related to captured variables. */
module VariableCapture {
  private import codeql.rust.internal.CachedStages
  private import codeql.dataflow.VariableCapture as SharedVariableCapture

  private predicate closureFlowStep(ExprCfgNode e1, ExprCfgNode e2) {
    Stages::DataFlowStage::ref() and
    e1 = getALastEvalNode(e2)
    or
    exists(Ssa::Definition def |
      def.getARead() = e2 and
      def.getAnUltimateDefinition().(Ssa::WriteDefinition).assigns(e1)
    )
  }

  private module CaptureInput implements SharedVariableCapture::InputSig<Location> {
    private import rust as Ast
    private import codeql.rust.controlflow.BasicBlocks as BasicBlocks
    private import codeql.rust.elements.Variable as Variable

    class BasicBlock extends BasicBlocks::BasicBlock {
      Callable getEnclosingCallable() { result = this.getScope() }
    }

    class ControlFlowNode = CfgNode;

    BasicBlock getImmediateBasicBlockDominator(BasicBlock bb) {
      result = bb.getImmediateDominator()
    }

    BasicBlock getABasicBlockSuccessor(BasicBlock bb) { result = bb.getASuccessor() }

    class CapturedVariable extends Variable {
      CapturedVariable() { this.isCaptured() }

      Callable getCallable() { result = this.getEnclosingCfgScope() }
    }

    final class CapturedParameter extends CapturedVariable {
      ParamBase p;

      CapturedParameter() { p = this.getParameter() }

      SourceParameterNode getParameterNode() { result.getParameter().getParamBase() = p }
    }

    class Expr extends CfgNode {
      predicate hasCfgNode(BasicBlock bb, int i) { this = bb.getNode(i) }
    }

    class VariableWrite extends Expr {
      ExprCfgNode source;
      CapturedVariable v;

      VariableWrite() {
        exists(AssignmentExprCfgNode assign, Variable::VariableWriteAccess write |
          this = assign and
          v = write.getVariable() and
          assign.getLhs().getExpr() = write and
          assign.getRhs() = source
        )
        or
        exists(LetStmtCfgNode ls |
          this = ls and
          v.getPat() = ls.getPat().getPat() and
          ls.getInitializer() = source
        )
      }

      CapturedVariable getVariable() { result = v }

      ExprCfgNode getSource() { result = source }
    }

    class VariableRead extends Expr instanceof ExprCfgNode {
      CapturedVariable v;

      VariableRead() {
        exists(VariableReadAccess read | this.getExpr() = read and v = read.getVariable())
      }

      CapturedVariable getVariable() { result = v }
    }

    class ClosureExpr extends Expr instanceof ExprCfgNode {
      ClosureExpr() { lambdaCreationExpr(super.getExpr(), _) }

      predicate hasBody(Callable body) { body = super.getExpr() }

      predicate hasAliasedAccess(Expr f) { closureFlowStep+(this, f) and not closureFlowStep(f, _) }
    }

    class Callable extends CfgScope {
      predicate isConstructor() { none() }
    }
  }

  class CapturedVariable = CaptureInput::CapturedVariable;

  module Flow = SharedVariableCapture::Flow<Location, CaptureInput>;

  private Flow::ClosureNode asClosureNode(Node n) {
    result = n.(CaptureNode).getSynthesizedCaptureNode()
    or
    result.(Flow::ExprNode).getExpr() = n.asExpr()
    or
    result.(Flow::VariableWriteSourceNode).getVariableWrite().getSource() = n.asExpr()
    or
    result.(Flow::ExprPostUpdateNode).getExpr() = n.(PostUpdateNode).getPreUpdateNode().asExpr()
    or
    result.(Flow::ParameterNode).getParameter().getParameterNode() = n
    or
    result.(Flow::ThisParameterNode).getCallable() = n.(ClosureParameterNode).getCfgScope()
  }

  predicate storeStep(Node node1, CapturedVariableContent c, Node node2) {
    Flow::storeStep(asClosureNode(node1), c.getVariable(), asClosureNode(node2))
  }

  predicate readStep(Node node1, CapturedVariableContent c, Node node2) {
    Flow::readStep(asClosureNode(node1), c.getVariable(), asClosureNode(node2))
  }

  predicate localFlowStep(Node node1, Node node2) {
    Flow::localFlowStep(asClosureNode(node1), asClosureNode(node2))
  }

  predicate clearsContent(Node node, CapturedVariableContent c) {
    Flow::clearsContent(asClosureNode(node), c.getVariable())
  }
}

import MakeImpl<Location, RustDataFlow>

/** A collection of cached types and predicates to be evaluated in the same stage. */
cached
private module Cached {
  private import codeql.rust.internal.CachedStages

  cached
  newtype TDataFlowCall =
    TCall(CallCfgNode c) {
      Stages::DataFlowStage::ref() and
      // TODO: Handle index expressions as calls in data flow.
      not c.getCall() instanceof IndexExpr
    } or
    TSummaryCall(
      FlowSummaryImpl::Public::SummarizedCallable c, FlowSummaryImpl::Private::SummaryNode receiver
    ) {
      FlowSummaryImpl::Private::summaryCallbackRange(c, receiver)
    }

  cached
  newtype TDataFlowCallable =
    TCfgScope(CfgScope scope) or
    TSummarizedCallable(SummarizedCallable c)

  /** This is the local flow predicate that is exposed. */
  cached
  predicate localFlowStepImpl(Node nodeFrom, Node nodeTo) {
    LocalFlow::localFlowStepCommon(nodeFrom, nodeTo)
    or
    SsaFlow::localFlowStep(_, nodeFrom, nodeTo, _)
    or
    // Simple flow through library code is included in the exposed local
    // step relation, even though flow is technically inter-procedural
    FlowSummaryImpl::Private::Steps::summaryThroughStepValue(nodeFrom, nodeTo, _)
  }

  cached
  newtype TParameterPosition =
    TPositionalParameterPosition(int i) {
      i in [0 .. max([any(ParamList l).getNumberOfParams(), any(ArgList l).getNumberOfArgs()]) - 1]
      or
      FlowSummaryImpl::ParsePositions::isParsedArgumentPosition(_, i)
      or
      FlowSummaryImpl::ParsePositions::isParsedParameterPosition(_, i)
    } or
    TClosureSelfParameterPosition() or
    TSelfParameterPosition()

  cached
  newtype TReturnKind = TNormalReturnKind()

  cached
  newtype TContentSet =
    TSingletonContentSet(Content c) or
    TOptionalStep(string name) {
      name = any(FlowSummaryImpl::Private::AccessPathToken tok).getAnArgument("OptionalStep")
    } or
    TOptionalBarrier(string name) {
      name = any(FlowSummaryImpl::Private::AccessPathToken tok).getAnArgument("OptionalBarrier")
    }

  /** Holds if `n` is a flow source of kind `kind`. */
  cached
  predicate sourceNode(Node n, string kind) { n.(FlowSummaryNode).isSource(kind, _) }

  /** Holds if `n` is a flow sink of kind `kind`. */
  cached
  predicate sinkNode(Node n, string kind) { n.(FlowSummaryNode).isSink(kind, _) }

  /**
   * A step in a flow summary defined using `OptionalStep[name]`. An `OptionalStep` is "opt-in", which means
   * that by default the step is not present in the flow summary and needs to be explicitly enabled by defining
   * an additional flow step.
   */
  cached
  predicate optionalStep(Node node1, string name, Node node2) {
    FlowSummaryImpl::Private::Steps::summaryReadStep(node1.(FlowSummaryNode).getSummaryNode(),
      TOptionalStep(name), node2.(FlowSummaryNode).getSummaryNode())
  }

  /**
   * A step in a flow summary defined using `OptionalBarrier[name]`. An `OptionalBarrier` is "opt-out", by default
   * data can flow freely through the step. Flow through the step can be explicity blocked by defining its node as a barrier.
   */
  cached
  predicate optionalBarrier(Node node, string name) {
    FlowSummaryImpl::Private::Steps::summaryReadStep(_, TOptionalBarrier(name),
      node.(FlowSummaryNode).getSummaryNode())
  }
}

import Cached
