private import codeql.util.Boolean
private import codeql.util.Unit
private import powershell
private import semmle.code.powershell.Cfg
private import semmle.code.powershell.dataflow.Ssa
private import DataFlowPublic
private import DataFlowDispatch
private import SsaImpl as SsaImpl
private import FlowSummaryImpl as FlowSummaryImpl
private import semmle.code.powershell.frameworks.data.ModelsAsData

/** Gets the callable in which this node occurs. */
DataFlowCallable nodeGetEnclosingCallable(Node n) { result = n.(NodeImpl).getEnclosingCallable() }

/** Holds if `p` is a `ParameterNode` of `c` with position `pos`. */
predicate isParameterNode(ParameterNodeImpl p, DataFlowCallable c, ParameterPosition pos) {
  p.isParameterOf(c, pos)
}

/** Holds if `arg` is an `ArgumentNode` of `c` with position `pos`. */
predicate isArgumentNode(ArgumentNode arg, DataFlowCall c, ArgumentPosition pos) {
  arg.argumentOf(c, pos)
}

abstract class NodeImpl extends Node {
  DataFlowCallable getEnclosingCallable() { result = TCfgScope(this.getCfgScope()) }

  /** Do not call: use `getEnclosingCallable()` instead. */
  abstract CfgScope getCfgScope();

  /** Do not call: use `getLocation()` instead. */
  abstract Location getLocationImpl();

  /** Do not call: use `toString()` instead. */
  abstract string toStringImpl();

  /** Holds if this node should be hidden from path explanations. */
  predicate nodeIsHidden() { none() }
}

private class ExprNodeImpl extends ExprNode, NodeImpl {
  override CfgScope getCfgScope() { result = this.getExprNode().getExpr().getEnclosingScope() }

  override Location getLocationImpl() { result = this.getExprNode().getLocation() }

  override string toStringImpl() { result = this.getExprNode().toString() }
}

private class StmtNodeImpl extends StmtNode, NodeImpl {
  override CfgScope getCfgScope() { result = this.getStmtNode().getStmt().getEnclosingScope() }

  override Location getLocationImpl() { result = this.getStmtNode().getLocation() }

  override string toStringImpl() { result = this.getStmtNode().toString() }
}

/** Gets the SSA definition node corresponding to parameter `p`. */
pragma[nomagic]
SsaImpl::DefinitionExt getParameterDef(Parameter p) {
  exists(EntryBasicBlock bb, int i |
    SsaImpl::parameterWrite(bb, i, p) and
    result.definesAt(p, bb, i, _)
  )
}

/** Provides logic related to SSA. */
module SsaFlow {
  private module Impl = SsaImpl::DataFlowIntegration;

  private ParameterNodeImpl toParameterNode(SsaImpl::ParameterExt p) {
    result = TNormalParameterNode(p.asParameter())
  }

  Impl::Node asNode(Node n) {
    n = TSsaNode(result)
    or
    result.(Impl::ExprNode).getExpr() = n.asExpr()
    or
    result.(Impl::ExprNode).getExpr() = n.asStmt()
    or
    result.(Impl::ExprNode).getExpr() =
      [n.(ProcessNode).getProcessBlock(), n.(ProcessPropertyByNameNode).getProcessBlock()]
    or
    result.(Impl::ExprPostUpdateNode).getExpr() = n.(PostUpdateNode).getPreUpdateNode().asExpr()
    or
    n = toParameterNode(result.(Impl::ParameterNode).getParameter())
  }

  predicate localFlowStep(SsaImpl::DefinitionExt def, Node nodeFrom, Node nodeTo, boolean isUseStep) {
    Impl::localFlowStep(def, asNode(nodeFrom), asNode(nodeTo), isUseStep)
  }

  predicate localMustFlowStep(SsaImpl::DefinitionExt def, Node nodeFrom, Node nodeTo) {
    Impl::localMustFlowStep(def, asNode(nodeFrom), asNode(nodeTo))
  }
}

/** Provides predicates related to local data flow. */
module LocalFlow {
  pragma[nomagic]
  predicate localFlowStepCommon(Node nodeFrom, Node nodeTo) {
    nodeFrom.asExpr() = nodeTo.asExpr().(CfgNodes::ExprNodes::ConditionalCfgNode).getABranch()
    or
    nodeFrom.asStmt() = nodeTo.asStmt().(CfgNodes::StmtNodes::AssignStmtCfgNode).getRightHandSide()
    or
    nodeFrom.asExpr() = nodeTo.asStmt().(CfgNodes::StmtNodes::CmdExprCfgNode).getExpr()
    or
    nodeFrom.asExpr() = nodeTo.asExpr().(CfgNodes::ExprNodes::ConvertCfgNode).getBase()
    or
    nodeFrom.asStmt() = nodeTo.asExpr().(CfgNodes::ExprNodes::ParenCfgNode).getBase()
    or
    exists(
      CfgNodes::ExprNodes::ArrayExprCfgNode arrayExpr, EscapeContainer::EscapeContainer container
    |
      nodeTo.asExpr() = arrayExpr and
      container = arrayExpr.getStmtBlock().getAstNode() and
      nodeFrom.(AstNode).getCfgNode() = container.getAnEscapingElement() and
      not container.mayBeMultiReturned(_)
    )
    or
    nodeFrom.(AstNode).getCfgNode() = nodeTo.(PreReturNodeImpl).getReturnedNode()
    or
    exists(CfgNode cfgNode |
      nodeFrom = TPreReturnNodeImpl(cfgNode, true) and
      nodeTo = TImplicitWrapNode(cfgNode, false)
    )
    or
    exists(CfgNode cfgNode |
      nodeFrom = TImplicitWrapNode(cfgNode, false) and
      nodeTo = TReturnNodeImpl(cfgNode.getScope())
    )
    or
    exists(CfgNode cfgNode |
      cfgNode = nodeFrom.(AstNode).getCfgNode() and
      isUniqueReturned(cfgNode) and
      nodeTo.(ReturnNodeImpl).getCfgScope() = cfgNode.getScope()
    )
  }

  predicate flowSummaryLocalStep(
    FlowSummaryNode nodeFrom, FlowSummaryNode nodeTo, FlowSummaryImpl::Public::SummarizedCallable c,
    string model
  ) {
    FlowSummaryImpl::Private::Steps::summaryLocalStep(nodeFrom.getSummaryNode(),
      nodeTo.getSummaryNode(), true, model) and
    c = nodeFrom.getSummarizedCallable()
  }

  predicate localMustFlowStep(Node nodeFrom, Node nodeTo) {
    SsaFlow::localMustFlowStep(_, nodeFrom, nodeTo)
    or
    nodeFrom.asStmt() = nodeTo.asStmt().(CfgNodes::StmtNodes::AssignStmtCfgNode).getRightHandSide()
    or
    nodeFrom =
      unique(FlowSummaryNode n1 |
        FlowSummaryImpl::Private::Steps::summaryLocalStep(n1.getSummaryNode(),
          nodeTo.(FlowSummaryNode).getSummaryNode(), true, _)
      )
  }
}

/** Provides logic related to captured variables. */
module VariableCapture {
  // TODO
}

private predicate isProcessPropertyByNameNode(
  PipelineByPropertyNameIteratorVariable iter, ProcessBlock pb
) {
  pb.getEnclosingScope() = iter.getDeclaringScope()
}

/** A collection of cached types and predicates to be evaluated in the same stage. */
cached
private module Cached {
  private import semmle.code.powershell.typetracking.internal.TypeTrackingImpl

  cached
  newtype TNode =
    TExprNode(CfgNodes::ExprCfgNode n) or
    TStmtNode(CfgNodes::StmtCfgNode n) or
    TSsaNode(SsaImpl::DataFlowIntegration::SsaNode node) or
    TNormalParameterNode(Parameter p) or
    TExprPostUpdateNode(CfgNodes::ExprCfgNode n) {
      n instanceof CfgNodes::ExprNodes::ArgumentCfgNode
      or
      n instanceof CfgNodes::ExprNodes::QualifierCfgNode
      or
      exists(CfgNodes::ExprNodes::MemberCfgNode member |
        n = member.getQualifier() and
        not member.isStatic()
      )
      or
      n = any(CfgNodes::ExprNodes::IndexCfgNode index).getBase()
    } or
    TFlowSummaryNode(FlowSummaryImpl::Private::SummaryNode sn) or
    TPreReturnNodeImpl(CfgNodes::AstCfgNode n, Boolean isArray) { isMultiReturned(n) } or
    TImplicitWrapNode(CfgNodes::AstCfgNode n, Boolean shouldWrap) { isMultiReturned(n) } or
    TReturnNodeImpl(CfgScope scope) or
    TProcessNode(ProcessBlock process) or
    TProcessPropertyByNameNode(PipelineByPropertyNameIteratorVariable iter) {
      isProcessPropertyByNameNode(iter, _)
    } or
    TScriptBlockNode(ScriptBlock scriptBlock) or
    TTypePathNode(int n, CfgNode cfg) { isTypePathNode(_, n, cfg) } or
    TForbiddenRecursionGuard() {
      none() and
      // We want to prune irrelevant models before materialising data flow nodes, so types contributed
      // directly from CodeQL must expose their pruning info without depending on data flow nodes.
      (any(ModelInput::TypeModel tm).isTypeUsed("") implies any())
    }

  cached
  Location getLocation(NodeImpl n) { result = n.getLocationImpl() }

  cached
  string toString(NodeImpl n) { result = n.toStringImpl() }

  /**
   * This is the local flow predicate that is used as a building block in global
   * data flow.
   */
  cached
  predicate simpleLocalFlowStep(Node nodeFrom, Node nodeTo, string model) {
    (
      LocalFlow::localFlowStepCommon(nodeFrom, nodeTo)
      or
      exists(SsaImpl::DefinitionExt def, boolean isUseStep |
        SsaFlow::localFlowStep(def, nodeFrom, nodeTo, isUseStep)
      |
        isUseStep = false
        or
        isUseStep = true and
        not FlowSummaryImpl::Private::Steps::prohibitsUseUseFlow(nodeFrom, _)
      )
    ) and
    model = ""
  }

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

  /**
   * This is the local flow predicate that is used in type tracking.
   */
  cached
  predicate localFlowStepTypeTracker(Node nodeFrom, Node nodeTo) {
    LocalFlow::localFlowStepCommon(nodeFrom, nodeTo)
    or
    SsaFlow::localFlowStep(_, nodeFrom, nodeTo, _)
  }

  /** Holds if `n` wraps an SSA definition without ingoing flow. */
  private predicate entrySsaDefinition(SsaDefinitionExtNode n) {
    n.getDefinitionExt() =
      any(SsaImpl::WriteDefinition def | not def.(Ssa::WriteDefinition).assigns(_))
  }

  pragma[nomagic]
  private predicate reachedFromExprOrEntrySsaDef(Node n) {
    localFlowStepTypeTracker(any(Node n0 |
        n0 instanceof ExprNode
        or
        entrySsaDefinition(n0)
      ), n)
    or
    exists(Node mid |
      reachedFromExprOrEntrySsaDef(mid) and
      localFlowStepTypeTracker(mid, n)
    )
  }

  private predicate isStoreTargetNode(Node n) {
    TypeTrackingInput::storeStep(_, n, _)
    or
    TypeTrackingInput::loadStoreStep(_, n, _, _)
    or
    TypeTrackingInput::withContentStepImpl(_, n, _)
    or
    TypeTrackingInput::withoutContentStepImpl(_, n, _)
  }

  private predicate isAutomaticVariable(Node n) {
    n.asExpr().(CfgNodes::ExprNodes::VarReadAccessCfgNode).getVariable().getName() =
      [
        "args", "ConsoleFileName", "EnabledExperimentalFeatures", "Error", "Event", "EventArgs",
        "EventSubscriber", "ExecutionContext", "HOME", "Host", "input", "IsCoreCLR", "IsLinux",
        "IsMacOS", "IsWindows", "LASTEXITCODE", "MyInvocation", "NestedPromptLevel", "PID",
        "PROFILE", "PSBoundParameters", "PSCmdlet", "PSCommandPath", "PSCulture", "PSDebugContext",
        "PSEdition", "PSHOME", "PSItem", "PSScriptRoot", "PSSenderInfo", "PSUICulture",
        "PSVersionTable", "PWD", "Sender", "ShellId", "StackTrace"
      ]
  }

  cached
  predicate isLocalSourceNode(Node n) {
    n instanceof ParameterNode
    or
    isAutomaticVariable(n)
    or
    // Expressions that can't be reached from another entry definition or expression
    (
      n instanceof ExprNode
      or
      exists(CfgNodes::StmtNodes::AssignStmtCfgNode assign | assign.getRightHandSide() = n.asStmt())
      or
      n.asStmt() instanceof CfgNodes::StmtNodes::CmdCfgNode
      or
      exists(CfgNodes::StmtNodes::PipelineCfgNode pipeline | n.asStmt() = pipeline.getAComponent())
    ) and
    not reachedFromExprOrEntrySsaDef(n)
    or
    // Ensure all entry SSA definitions are local sources, except those that correspond
    // to parameters (which are themselves local sources)
    entrySsaDefinition(n) and
    not exists(SsaImpl::ParameterExt p |
      p.isInitializedBy(n.(SsaDefinitionExtNode).getDefinitionExt())
    )
    or
    isStoreTargetNode(n)
    or
    TypeTrackingInput::loadStep(_, n, _)
  }

  cached
  newtype TContentSet =
    TSingletonContent(Content c) or
    TAnyElementContent() or
    TKnownOrUnknownElementContent(Content::KnownElementContent c)

  private predicate trackKnownValue(ConstantValue cv) {
    exists(cv.asString())
    or
    cv.asInt() = [0 .. 10]
  }

  cached
  newtype TContent =
    TFieldContent(string name) {
      name = any(PropertyMember member).getName()
      or
      name = any(MemberExpr me).getMemberName()
    } or
    TKnownElementContent(ConstantValue cv) { trackKnownValue(cv) } or
    TUnknownElementContent()

  cached
  newtype TContentApprox =
    TNonElementContentApprox(Content c) { not c instanceof Content::ElementContent } or
    TUnknownElementContentApprox() or
    TKnownIntegerElementContentApprox() or
    TKnownElementContentApprox(string approx) { approx = approxKnownElementIndex(_) }

  cached
  newtype TDataFlowType = TUnknownDataFlowType()
}

class TElementContent = TKnownElementContent or TUnknownElementContent;

/** Gets a string for approximating known element indices. */
private string approxKnownElementIndex(ConstantValue cv) {
  not exists(cv.asInt()) and
  exists(string s | s = cv.serialize() |
    s.length() < 2 and
    result = s
    or
    result = s.prefix(2)
  )
}

import Cached

/** Holds if `n` should be hidden from path explanations. */
predicate nodeIsHidden(Node n) { n.(NodeImpl).nodeIsHidden() }

/**
 * Holds if `n` should never be skipped over in the `PathGraph` and in path
 * explanations.
 */
predicate neverSkipInPathGraph(Node n) { isReturned(n.(AstNode).getCfgNode()) }

/** An SSA node. */
abstract class SsaNode extends NodeImpl, TSsaNode {
  SsaImpl::DataFlowIntegration::SsaNode node;
  SsaImpl::DefinitionExt def;

  SsaNode() {
    this = TSsaNode(node) and
    def = node.getDefinitionExt()
  }

  SsaImpl::DefinitionExt getDefinitionExt() { result = def }

  /** Holds if this node should be hidden from path explanations. */
  abstract predicate isHidden();

  override Location getLocationImpl() { result = node.getLocation() }

  override string toStringImpl() { result = node.toString() }
}

/** An (extended) SSA definition, viewed as a node in a data flow graph. */
class SsaDefinitionExtNode extends SsaNode {
  override SsaImpl::DataFlowIntegration::SsaDefinitionExtNode node;

  /** Gets the underlying variable. */
  Variable getVariable() { result = def.getSourceVariable() }

  override predicate isHidden() {
    not def instanceof Ssa::WriteDefinition
    or
    def = getParameterDef(_)
  }

  override CfgScope getCfgScope() { result = def.getBasicBlock().getScope() }
}

class SsaDefinitionNodeImpl extends SsaDefinitionExtNode {
  Ssa::Definition ssaDef;

  SsaDefinitionNodeImpl() { ssaDef = def }

  override Location getLocationImpl() { result = ssaDef.getLocation() }

  override string toStringImpl() { result = ssaDef.toString() }
}

class SsaInputNode extends SsaNode {
  override SsaImpl::DataFlowIntegration::SsaInputNode node;

  override predicate isHidden() { any() }

  override CfgScope getCfgScope() { result = node.getDefinitionExt().getBasicBlock().getScope() }
}

private string getANamedArgument(CfgNodes::CallCfgNode c) { exists(c.getNamedArgument(result)) }

private module NamedSetModule =
  QlBuiltins::InternSets<CfgNodes::CallCfgNode, string, getANamedArgument/1>;

private newtype NamedSet0 =
  TEmptyNamedSet() or
  TNonEmptyNamedSet(NamedSetModule::Set ns)

/** A (possiby empty) set of argument names. */
class NamedSet extends NamedSet0 {
  /** Gets the non-empty set of names, if any. */
  NamedSetModule::Set asNonEmpty() { this = TNonEmptyNamedSet(result) }

  /** Holds if this is the empty set. */
  predicate isEmpty() { this = TEmptyNamedSet() }

  /** Gets a name in this set. */
  string getAName() { this.asNonEmpty().contains(result) }

  /** Gets the textual representation of this set. */
  string toString() {
    result = "{" + strictconcat(this.getAName(), ", ") + "}"
    or
    this.isEmpty() and
    result = "{}"
  }

  /**
   * Gets a `CfgNodes::CallCfgNode` that provides a named parameter for every name in `this`.
   *
   * NOTE: The `CfgNodes::CallCfgNode` may also provide more names.
   */
  CfgNodes::CallCfgNode getABindingCall() {
    forex(string name | name = this.getAName() | exists(result.getNamedArgument(name)))
    or
    this.isEmpty() and
    exists(result)
  }

  /**
   * Gets a `Cmd` that provides exactly the named parameters represented by
   * this set.
   */
  CfgNodes::CallCfgNode getAnExactBindingCall() {
    forex(string name | name = this.getAName() | exists(result.getNamedArgument(name))) and
    forex(string name | exists(result.getNamedArgument(name)) | name = this.getAName())
    or
    this.isEmpty() and
    not exists(result.getNamedArgument(_))
  }

  /** Gets a function that has a parameter for each name in this set. */
  Function getAFunction() {
    forex(string name | name = this.getAName() | result.getAParameter().hasName(name))
    or
    this.isEmpty() and
    exists(result)
  }
}

NamedSet emptyNamedSet() { result.isEmpty() }

private module ParameterNodes {
  abstract class ParameterNodeImpl extends NodeImpl {
    abstract Parameter getParameter();

    abstract predicate isParameterOf(DataFlowCallable c, ParameterPosition pos);

    final predicate isSourceParameterOf(CfgScope c, ParameterPosition pos) {
      exists(DataFlowCallable callable |
        this.isParameterOf(callable, pos) and
        c = callable.asCfgScope()
      )
    }
  }

  /**
   * The value of a normal parameter at function entry, viewed as a node in a data
   * flow graph.
   */
  class NormalParameterNode extends ParameterNodeImpl, TNormalParameterNode {
    Parameter parameter;

    NormalParameterNode() { this = TNormalParameterNode(parameter) }

    override Parameter getParameter() { result = parameter }

    override predicate isParameterOf(DataFlowCallable c, ParameterPosition pos) {
      parameter.getDeclaringScope() = c.asCfgScope() and
      (
        pos.isThis() and
        parameter.isThis()
        or
        pos.isKeyword(parameter.getName())
        or
        // Given a function f with parameters x, y we map
        // x to the positions:
        // 1. keyword(x)
        // 2. position(0, {y})
        // 3. position(0, {})
        // Likewise, y is mapped to the positions:
        // 1. keyword(y)
        // 2. position(0, {x})
        // 3. position(1, {})
        // The interpretation of `position(i, S)` is the position of the i'th unnamed parameter when the
        // keywords in S are specified.
        exists(int i, int j, string name, NamedSet ns, Function f |
          pos.isPositional(j, ns) and
          parameter.getIndexExcludingPipelines() = i and
          f = parameter.getFunction() and
          f = ns.getAFunction() and
          name = parameter.getName() and
          not name = ns.getAName() and
          j =
            i -
              count(int k, Parameter p |
                k < i and
                p = f.getParameterExcludingPiplines(k) and
                p.getName() = ns.getAName()
              )
        )
        or
        (parameter.isPipeline() or parameter.isPipelineByPropertyName()) and
        pos.isPipeline()
      )
    }

    override CfgScope getCfgScope() {
      result.getAParameter() = parameter or result.getThisParameter() = parameter
    }

    override Location getLocationImpl() { result = parameter.getLocation() }

    override string toStringImpl() { result = parameter.toString() }
  }

  class PipelineByPropertyNameParameterNode extends NormalParameterNode {
    PipelineByPropertyNameParameterNode() { this.getParameter().isPipelineByPropertyName() }

    string getPropretyName() { result = this.getParameter().getName() }
  }

  /** A parameter for a library callable with a flow summary. */
  class SummaryParameterNode extends ParameterNodeImpl, FlowSummaryNode {
    private ParameterPosition pos_;

    SummaryParameterNode() {
      FlowSummaryImpl::Private::summaryParameterNode(this.getSummaryNode(), pos_)
    }

    override Parameter getParameter() { none() }

    override predicate isParameterOf(DataFlowCallable c, ParameterPosition pos) {
      this.getSummarizedCallable() = c.asLibraryCallable() and pos = pos_
    }
  }
}

import ParameterNodes

/** A data-flow node used to model flow summaries. */
class FlowSummaryNode extends NodeImpl, TFlowSummaryNode {
  FlowSummaryImpl::Private::SummaryNode getSummaryNode() { this = TFlowSummaryNode(result) }

  /** Gets the summarized callable that this node belongs to. */
  FlowSummaryImpl::Public::SummarizedCallable getSummarizedCallable() {
    result = this.getSummaryNode().getSummarizedCallable()
  }

  override CfgScope getCfgScope() { none() }

  override DataFlowCallable getEnclosingCallable() {
    result.asLibraryCallable() = this.getSummarizedCallable()
  }

  override EmptyLocation getLocationImpl() { any() }

  override string toStringImpl() { result = this.getSummaryNode().toString() }
}

/** A data-flow node that represents a call argument. */
abstract class ArgumentNode extends Node {
  /** Holds if this argument occurs at the given position in the given call. */
  abstract predicate argumentOf(DataFlowCall call, ArgumentPosition pos);

  abstract predicate sourceArgumentOf(CfgNodes::CallCfgNode call, ArgumentPosition pos);

  /** Gets the call in which this node is an argument. */
  final DataFlowCall getCall() { this.argumentOf(result, _) }
}

module ArgumentNodes {
  class ExplicitArgumentNode extends ArgumentNode {
    CfgNodes::ExprNodes::ArgumentCfgNode arg;

    ExplicitArgumentNode() { this.asExpr() = arg }

    override predicate argumentOf(DataFlowCall call, ArgumentPosition pos) {
      this.sourceArgumentOf(call.asCall(), pos)
    }

    override predicate sourceArgumentOf(CfgNodes::CallCfgNode call, ArgumentPosition pos) {
      arg.getCall() = call and
      (
        pos.isKeyword(arg.getName())
        or
        exists(NamedSet ns, int i |
          i = arg.getPosition() and
          ns.getAnExactBindingCall() = call and
          pos.isPositional(i, ns)
        )
        or
        arg.isQualifier() and
        pos.isThis()
      )
    }
  }

  private predicate isPipelineInput(
    CfgNodes::StmtNodes::CmdBaseCfgNode input, CfgNodes::StmtNodes::CmdBaseCfgNode consumer
  ) {
    exists(CfgNodes::StmtNodes::PipelineCfgNode pipeline, int i |
      input = pipeline.getComponent(i) and
      consumer = pipeline.getComponent(i + 1)
    )
  }

  class PipelineArgumentNode extends ArgumentNode, StmtNode {
    CfgNodes::StmtNodes::CmdBaseCfgNode consumer;

    PipelineArgumentNode() { isPipelineInput(this.getStmtNode(), consumer) }

    override predicate argumentOf(DataFlowCall call, ArgumentPosition pos) {
      this.sourceArgumentOf(call.asCall(), pos)
    }

    override predicate sourceArgumentOf(CfgNodes::CallCfgNode call, ArgumentPosition pos) {
      call = consumer and
      pos.isPipeline()
    }
  }

  private class SummaryArgumentNode extends FlowSummaryNode, ArgumentNode {
    private FlowSummaryImpl::Private::SummaryNode receiver;
    private ArgumentPosition pos_;

    SummaryArgumentNode() {
      FlowSummaryImpl::Private::summaryArgumentNode(receiver, this.getSummaryNode(), pos_)
    }

    override predicate argumentOf(DataFlowCall call, ArgumentPosition pos) {
      call.(SummaryCall).getReceiver() = receiver and pos = pos_
    }

    override predicate sourceArgumentOf(CfgNodes::CallCfgNode call, ArgumentPosition pos) { none() }
  }
}

import ArgumentNodes

/** A data-flow node that represents a value returned by a callable. */
abstract class ReturnNode extends Node {
  /** Gets the kind of this return node. */
  abstract ReturnKind getKind();
}

private module EscapeContainer {
  private import semmle.code.powershell.internal.AstEscape::Private

  private module ReturnContainerInterpreter implements InterpretAstInputSig {
    class T = CfgNodes::AstCfgNode;

    T interpret(Ast a) {
      result.(CfgNodes::ExprCfgNode).getExpr() = a
      or
      result.(CfgNodes::StmtCfgNode).getStmt() = a.(Cmd)
    }
  }

  class EscapeContainer extends AstEscape<ReturnContainerInterpreter>::Element {
    /** Holds if `n` may be returned multiples times. */
    predicate mayBeMultiReturned(CfgNode n) {
      n = this.getANode() and
      n.getASuccessor+() = n
      or
      this.getAChild().(EscapeContainer).mayBeMultiReturned(n)
    }
  }

  private class SummaryReturnNode extends FlowSummaryNode, ReturnNode {
    private ReturnKind rk;

    SummaryReturnNode() { FlowSummaryImpl::Private::summaryReturnNode(this.getSummaryNode(), rk) }

    override ReturnKind getKind() { result = rk }
  }
}

private module ReturnNodes {
  private import EscapeContainer

  private predicate isReturnedImpl(CfgNodes::AstCfgNode n, EscapeContainer container) {
    container = n.getScope() and
    n = container.getAnEscapingElement()
  }

  /**
   * Holds if `n` may be returned, and there are possibly
   * more than one return value from the function.
   */
  predicate isMultiReturned(CfgNodes::AstCfgNode n) {
    exists(EscapeContainer container | isReturnedImpl(n, container) |
      strictcount(container.getAnEscapingElement()) > 1
      or
      container.mayBeMultiReturned(n)
    )
  }

  /**
   * Holds if `n` may be returned.
   */
  predicate isReturned(CfgNodes::AstCfgNode n) { isReturnedImpl(n, _) }

  /**
   * Holds if `n` may be returned, and this is the only value that may be
   * returned from the function.
   */
  predicate isUniqueReturned(CfgNodes::AstCfgNode n) { isReturned(n) and not isMultiReturned(n) }

  class NormalReturnNode extends ReturnNode instanceof ReturnNodeImpl {
    final override NormalReturnKind getKind() { any() }
  }
}

import ReturnNodes

/** A data-flow node that represents the output of a call. */
abstract class OutNode extends Node {
  /** Gets the underlying call, where this node is a corresponding output of kind `kind`. */
  abstract DataFlowCall getCall(ReturnKind kind);
}

private module OutNodes {
  /** A data-flow node that reads a value returned directly by a callable */
  class CallOutNode extends OutNode instanceof CallNode {
    override DataFlowCall getCall(ReturnKind kind) {
      result.asCall() = super.getCallNode() and
      kind instanceof NormalReturnKind
    }
  }

  private class SummaryOutNode extends FlowSummaryNode, OutNode {
    private SummaryCall call;
    private ReturnKind kind_;

    SummaryOutNode() {
      FlowSummaryImpl::Private::summaryOutNode(call.getReceiver(), this.getSummaryNode(), kind_)
    }

    override DataFlowCall getCall(ReturnKind kind) { result = call and kind = kind_ }
  }
}

import OutNodes

predicate jumpStep(Node pred, Node succ) {
  FlowSummaryImpl::Private::Steps::summaryJumpStep(pred.(FlowSummaryNode).getSummaryNode(),
    succ.(FlowSummaryNode).getSummaryNode())
}

/**
 * Holds if data can flow from `node1` to `node2` via an assignment to
 * content `c`.
 */
predicate storeStep(Node node1, ContentSet c, Node node2) {
  exists(CfgNodes::ExprNodes::MemberCfgWriteAccessNode var, Content::FieldContent fc |
    node2.(PostUpdateNode).getPreUpdateNode().asExpr() = var.getQualifier() and
    node1.asStmt() = var.getAssignStmt().getRightHandSide() and
    fc.getName() = var.getMemberName() and
    c.isSingleton(fc)
  )
  or
  exists(CfgNodes::ExprNodes::IndexCfgWriteNode var, CfgNodes::ExprCfgNode e |
    node2.(PostUpdateNode).getPreUpdateNode().asExpr() = var.getBase() and
    node1.asStmt() = var.getAssignStmt().getRightHandSide() and
    e = var.getIndex()
  |
    exists(Content::KnownElementContent ec |
      c.isKnownOrUnknownElement(ec) and
      e.getValue() = ec.getIndex()
    )
    or
    not exists(e.getValue().asInt()) and
    c.isAnyElement()
  )
  or
  exists(Content::KnownElementContent ec, int index |
    node2.asExpr().(CfgNodes::ExprNodes::ArrayLiteralCfgNode).getElement(index) = node1.asExpr() and
    c.isKnownOrUnknownElement(ec) and
    index = ec.getIndex().asInt()
  )
  or
  exists(CfgNodes::ExprCfgNode key |
    node2.asExpr().(CfgNodes::ExprNodes::HashTableCfgNode).getElement(key) = node1.asStmt()
  |
    exists(Content::KnownElementContent ec |
      c.isKnownOrUnknownElement(ec) and
      ec.getIndex() = key.getValue()
    )
    or
    not exists(key.getValue()) and
    c.isAnyElement()
  )
  or
  c.isAnyElement() and
  exists(
    CfgNodes::ExprNodes::ArrayExprCfgNode arrayExpr, EscapeContainer::EscapeContainer container
  |
    node2.asExpr() = arrayExpr and
    container = arrayExpr.getStmtBlock().getAstNode() and
    node1.(AstNode).getCfgNode() = container.getAnEscapingElement() and
    container.mayBeMultiReturned(_)
  )
  or
  c.isAnyElement() and
  exists(CfgNode cfgNode |
    node1 = TPreReturnNodeImpl(cfgNode, false) and
    node2.(ReturnNodeImpl).getCfgScope() = cfgNode.getScope()
  )
  or
  c.isAnyElement() and
  exists(CfgNode cfgNode |
    node1 = TImplicitWrapNode(cfgNode, true) and
    node2.(ReturnNodeImpl).getCfgScope() = cfgNode.getScope()
  )
  or
  FlowSummaryImpl::Private::Steps::summaryStoreStep(node1.(FlowSummaryNode).getSummaryNode(), c,
    node2.(FlowSummaryNode).getSummaryNode())
}

/**
 * Holds if there is a read step of content `c` from `node1` to `node2`.
 */
predicate readStep(Node node1, ContentSet c, Node node2) {
  exists(CfgNodes::ExprNodes::MemberCfgReadAccessNode var, Content::FieldContent fc |
    node2.asExpr() = var and
    node1.asExpr() = var.getQualifier() and
    fc.getName() = var.getMemberName() and
    c.isSingleton(fc)
  )
  or
  exists(CfgNodes::ExprNodes::IndexCfgReadNode var, CfgNodes::ExprCfgNode e |
    node2.asExpr() = var and
    node1.asExpr() = var.getBase() and
    e = var.getIndex()
  |
    exists(Content::KnownElementContent ec |
      c.isKnownOrUnknownElement(ec) and
      e.getValue() = ec.getIndex()
    )
    or
    not exists(e.getValue()) and
    c.isAnyElement()
  )
  or
  exists(CfgNode cfgNode |
    node1 = TPreReturnNodeImpl(cfgNode, true) and
    node2 = TImplicitWrapNode(cfgNode, true) and
    c.isSingleton(any(Content::KnownElementContent ec | exists(ec.getIndex().asInt())))
  )
  or
  c.isAnyElement() and
  exists(SsaImpl::DefinitionExt def, ProcessNode processNode, LocalScopeVariable iterator |
    processNode = node1 and iterator = def.getSourceVariable()
  |
    processNode.getIteratorVariable() = iterator and
    SsaImpl::firstRead(def, node2.asExpr())
    or
    processNode.getPropertyNameIteratorVariable() = iterator and
    node2 = TProcessPropertyByNameNode(def.getSourceVariable())
  )
  or
  exists(
    Content::KnownElementContent ec, PipelineByPropertyNameParameter p, SsaImpl::DefinitionExt def
  |
    c.isSingleton(ec) and
    p.getIteratorVariable() = node1.(ProcessPropertyByNameNode).getVariable() and
    p.getName() = ec.getIndex().asString() and
    def.getSourceVariable() = p.getIteratorVariable() and
    SsaImpl::firstRead(def, node2.asExpr())
  )
  or
  exists(Content::KnownElementContent ec, SsaImpl::DefinitionExt def |
    c.isSingleton(ec) and
    node1.(PipelineByPropertyNameParameterNode).getPropretyName() = ec.getIndex().asString() and
    def.getSourceVariable() = node1.(PipelineByPropertyNameParameterNode).getParameter() and
    SsaImpl::firstRead(def, node2.asExpr())
  )
  or
  FlowSummaryImpl::Private::Steps::summaryReadStep(node1.(FlowSummaryNode).getSummaryNode(), c,
    node2.(FlowSummaryNode).getSummaryNode())
}

/**
 * Holds if values stored inside content `c` are cleared at node `n`. For example,
 * any value stored inside `f` is cleared at the pre-update node associated with `x`
 * in `x.f = newValue`.
 */
predicate clearsContent(Node n, ContentSet c) {
  FlowSummaryImpl::Private::Steps::summaryClearsContent(n.(FlowSummaryNode).getSummaryNode(), c)
  or
  c.isSingleton(any(Content::FieldContent fc)) and
  n = any(PostUpdateNode pun | storeStep(_, c, pun)).getPreUpdateNode()
  or
  n = TPreReturnNodeImpl(_, false) and
  c.isAnyElement()
}

/**
 * Holds if the value that is being tracked is expected to be stored inside content `c`
 * at node `n`.
 */
predicate expectsContent(Node n, ContentSet c) {
  FlowSummaryImpl::Private::Steps::summaryExpectsContent(n.(FlowSummaryNode).getSummaryNode(), c)
  or
  n = TPreReturnNodeImpl(_, true) and
  c.isKnownOrUnknownElement(any(Content::KnownElementContent ec | exists(ec.getIndex().asInt())))
  or
  n = TImplicitWrapNode(_, false) and
  c.isSingleton(any(Content::UnknownElementContent ec))
  or
  n instanceof ProcessNode and
  c.isAnyElement()
}

class DataFlowType extends TDataFlowType {
  string toString() { result = "" }
}

predicate typeStrongerThan(DataFlowType t1, DataFlowType t2) {
  t1 != TUnknownDataFlowType() and
  t2 = TUnknownDataFlowType()
}

predicate localMustFlowStep(Node node1, Node node2) { none() }

/** Gets the type of `n` used for type pruning. */
DataFlowType getNodeType(Node n) {
  result = TUnknownDataFlowType() and // TODO
  exists(n)
}

pragma[inline]
private predicate compatibleTypesNonSymRefl(DataFlowType t1, DataFlowType t2) {
  t1 != TUnknownDataFlowType() and
  t2 = TUnknownDataFlowType()
}

/**
 * Holds if `t1` and `t2` are compatible, that is, whether data can flow from
 * a node of type `t1` to a node of type `t2`.
 */
predicate compatibleTypes(DataFlowType t1, DataFlowType t2) {
  t1 = t2
  or
  compatibleTypesNonSymRefl(t1, t2)
  or
  compatibleTypesNonSymRefl(t2, t1)
}

abstract class PostUpdateNodeImpl extends Node {
  /** Gets the node before the state update. */
  abstract Node getPreUpdateNode();
}

private module PostUpdateNodes {
  class ExprPostUpdateNode extends PostUpdateNodeImpl, NodeImpl, TExprPostUpdateNode {
    private CfgNodes::ExprCfgNode e;

    ExprPostUpdateNode() { this = TExprPostUpdateNode(e) }

    override ExprNode getPreUpdateNode() { e = result.getExprNode() }

    override CfgScope getCfgScope() { result = e.getExpr().getEnclosingScope() }

    override Location getLocationImpl() { result = e.getLocation() }

    override string toStringImpl() { result = "[post] " + e.toString() }
  }

  private class SummaryPostUpdateNode extends FlowSummaryNode, PostUpdateNodeImpl {
    private FlowSummaryNode pre;

    SummaryPostUpdateNode() {
      FlowSummaryImpl::Private::summaryPostUpdateNode(this.getSummaryNode(), pre.getSummaryNode())
    }

    override Node getPreUpdateNode() { result = pre }
  }
}

private import PostUpdateNodes

/**
 * A node that performs implicit array unwrapping when an expression
 * (or statement) is being returned from a function.
 */
private class ImplicitWrapNode extends TImplicitWrapNode, NodeImpl {
  private CfgNodes::AstCfgNode n;
  private boolean shouldWrap;

  ImplicitWrapNode() { this = TImplicitWrapNode(n, shouldWrap) }

  CfgNodes::AstCfgNode getReturnedNode() { result = n }

  predicate shouldWrap() { shouldWrap = true }

  override CfgScope getCfgScope() { result = n.getScope() }

  override Location getLocationImpl() { result = n.getLocation() }

  override string toStringImpl() { result = "implicit unwrapping of " + n.toString() }

  override predicate nodeIsHidden() { any() }
}

/**
 * A node that represents the return value before any array-unwrapping
 * has been performed.
 */
private class PreReturNodeImpl extends TPreReturnNodeImpl, NodeImpl {
  private CfgNodes::AstCfgNode n;
  private boolean isArray;

  PreReturNodeImpl() { this = TPreReturnNodeImpl(n, isArray) }

  CfgNodes::AstCfgNode getReturnedNode() { result = n }

  override CfgScope getCfgScope() { result = n.getScope() }

  override Location getLocationImpl() { result = n.getLocation() }

  override string toStringImpl() { result = "pre-return value for " + n.toString() }

  override predicate nodeIsHidden() { any() }
}

/** The node that represents the return value of a function. */
private class ReturnNodeImpl extends TReturnNodeImpl, NodeImpl {
  CfgScope scope;

  ReturnNodeImpl() { this = TReturnNodeImpl(scope) }

  override CfgScope getCfgScope() { result = scope }

  override Location getLocationImpl() { result = scope.getLocation() }

  override string toStringImpl() { result = "return value for " + scope.toString() }

  override predicate nodeIsHidden() { any() }
}

private class ProcessNode extends TProcessNode, NodeImpl {
  ProcessBlock process;

  ProcessNode() { this = TProcessNode(process) }

  override CfgScope getCfgScope() { result = process.getEnclosingScope() }

  override Location getLocationImpl() { result = process.getLocation() }

  override string toStringImpl() { result = "process node for " + process.toString() }

  override predicate nodeIsHidden() { any() }

  PipelineIteratorVariable getIteratorVariable() { result.getProcessBlock() = process }

  PipelineByPropertyNameIteratorVariable getPropertyNameIteratorVariable() {
    result.getProcessBlock() = process
  }

  CfgNodes::ProcessBlockCfgNode getProcessBlock() { result.getAstNode() = process }
}

private class ProcessPropertyByNameNode extends TProcessPropertyByNameNode, NodeImpl {
  private PipelineByPropertyNameIteratorVariable iter;

  ProcessPropertyByNameNode() { this = TProcessPropertyByNameNode(iter) }

  PipelineByPropertyNameIteratorVariable getVariable() { result = iter }

  override CfgScope getCfgScope() { result = iter.getDeclaringScope() }

  override Location getLocationImpl() { result = iter.getLocation() }

  override string toStringImpl() { result = "process node for " + iter.toString() }

  override predicate nodeIsHidden() { any() }

  CfgNodes::ProcessBlockCfgNode getProcessBlock() {
    isProcessPropertyByNameNode(iter, result.getAstNode())
  }
}

class ScriptBlockNode extends TScriptBlockNode, NodeImpl {
  private ScriptBlock scriptBlock;

  ScriptBlockNode() { this = TScriptBlockNode(scriptBlock) }

  ScriptBlock getScriptBlock() { result = scriptBlock }

  override CfgScope getCfgScope() { result = scriptBlock }

  override Location getLocationImpl() { result = scriptBlock.getLocation() }

  override string toStringImpl() { result = scriptBlock.toString() }

  override predicate nodeIsHidden() { any() }
}

private predicate isTypePathNode(string type, int n, CfgNode cfg) {
  exists(CfgNodes::ExprNodes::TypeNameCfgNode typeName, string s |
    cfg = typeName and
    type = typeName.getTypeName() and
    s = type.splitAt(".", n)
  )
  or
  exists(CfgNodes::StmtNodes::CmdCfgNode cmd, string s |
    cfg = cmd.getCommand() and
    type = cmd.getNamespaceQualifier() and
    s = type.splitAt(".", n)
  )
  or
  exists(CfgNodes::DotNetObjectCreationCfgNode objCreation, string s |
    cfg = objCreation and
    type = objCreation.getConstructedTypeName() and
    s = type.splitAt(".", n)
  )
}

/**
 * A dataflow node that represents a component of a type or module path.
 *
 * For example, `System`, `System.Management`, `System.Management.Automation`,
 * and `System.Management.Automation.PowerShell` in the type
 * name `[System.Management.Automation.PowerShell]`.
 */
class TypePathNodeImpl extends TTypePathNode, NodeImpl {
  int n;
  CfgNode cfg;

  TypePathNodeImpl() { this = TTypePathNode(n, cfg) }

  string getType() { isTypePathNode(result, n, cfg) }

  predicate isComplete() { not exists(this.getNext()) }

  int getIndex() { result = n }

  pragma[nomagic]
  string getComponent() { result = this.getType().splitAt(".", n) }

  override CfgScope getCfgScope() { result = cfg.getScope() }

  override Location getLocationImpl() { result = cfg.getLocation() }

  override string toStringImpl() {
    not exists(this.getPrev()) and
    result = this.getComponent()
    or
    result = this.getPrev() + "." + this.getComponent()
  }

  override predicate nodeIsHidden() { any() }

  TypePathNodeImpl getNext() { result = TTypePathNode(n + 1, cfg) }

  TypePathNodeImpl getPrev() { result.getNext() = this }

  /**
   * Gets a successor that matches the constant `s`.
   * Note: `s` is normalized.
   */
  pragma[nomagic]
  TypePathNodeImpl getConstant(string s) {
    s = result.getComponent().toLowerCase() and
    result = this.getNext()
  }
}

/** A node that performs a type cast. */
class CastNode extends Node {
  CastNode() { none() }
}

class DataFlowExpr = CfgNodes::ExprCfgNode;

/**
 * Holds if access paths with `c` at their head always should be tracked at high
 * precision. This disables adaptive access path precision for such access paths.
 */
predicate forceHighPrecision(Content c) { c instanceof Content::ElementContent }

class NodeRegion instanceof Unit {
  string toString() { result = "NodeRegion" }

  predicate contains(Node n) { none() }

  /** Gets a best-effort total ordering. */
  int totalOrder() { result = 1 }
}

/**
 * Holds if the nodes in `nr` are unreachable when the call context is `call`.
 */
predicate isUnreachableInCall(NodeRegion nr, DataFlowCall call) { none() }

newtype LambdaCallKind = TLambdaCallKind()

private class CmdName extends StringConstExpr {
  CmdName() { this = any(Cmd c).getCmdName() }

  string getName() { result = this.getValue().getValue() }
}

/** Holds if `creation` is an expression that creates a lambda of kind `kind` for `c`. */
predicate lambdaCreation(Node creation, LambdaCallKind kind, DataFlowCallable c) {
  creation.asExpr().getExpr().(CmdName).getName() = c.asCfgScope().getEnclosingFunction().getName() and
  exists(kind)
}

/**
 * Holds if `call` is a (from-source or from-summary) lambda call of kind `kind`
 * where `receiver` is the lambda expression.
 */
predicate lambdaCall(DataFlowCall call, LambdaCallKind kind, Node receiver) {
  call.asCall().getCommand() = receiver.asExpr() and exists(kind)
}

/** Extra data-flow steps needed for lambda flow analysis. */
predicate additionalLambdaFlowStep(Node nodeFrom, Node nodeTo, boolean preservesValue) { none() }

predicate knownSourceModel(Node source, string model) {
  source = ModelOutput::getASourceNode(_, model).asSource()
}

predicate knownSinkModel(Node sink, string model) {
  sink = ModelOutput::getASinkNode(_, model).asSink()
}

class DataFlowSecondLevelScope = Unit;

/**
 * Holds if flow is allowed to pass from parameter `p` and back to itself as a
 * side-effect, resulting in a summary from `p` to itself.
 *
 * One example would be to allow flow like `p.foo = p.bar;`, which is disallowed
 * by default as a heuristic.
 */
predicate allowParameterReturnInSelf(ParameterNodeImpl p) {
  exists(DataFlowCallable c, ParameterPosition pos |
    p.isParameterOf(c, pos) and
    FlowSummaryImpl::Private::summaryAllowParameterReturnInSelf(c.asLibraryCallable(), pos)
  )
}

/** An approximated `Content`. */
class ContentApprox extends TContentApprox {
  string toString() {
    exists(Content c |
      this = TNonElementContentApprox(c) and
      result = c.toString()
    )
  }
}

/** Gets an approximated value for content `c`. */
ContentApprox getContentApprox(Content c) {
  c instanceof Content::UnknownElementContent and
  result = TUnknownElementContentApprox()
  or
  exists(c.(Content::KnownElementContent).getIndex().asInt()) and
  result = TKnownIntegerElementContentApprox()
  or
  result =
    TKnownElementContentApprox(approxKnownElementIndex(c.(Content::KnownElementContent).getIndex()))
  or
  result = TNonElementContentApprox(c)
}

/**
 * A unit class for adding additional jump steps.
 *
 * Extend this class to add additional jump steps.
 */
class AdditionalJumpStep extends Unit {
  /**
   * Holds if data can flow from `pred` to `succ` in a way that discards call contexts.
   */
  abstract predicate step(Node pred, Node succ);
}
