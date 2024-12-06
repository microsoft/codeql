private import powershell
private import DataFlowDispatch
private import DataFlowPrivate
private import semmle.code.powershell.typetracking.internal.TypeTrackingImpl
private import semmle.code.powershell.ApiGraphs
private import semmle.code.powershell.Cfg

/**
 * An element, viewed as a node in a data flow graph. Either an expression
 * (`ExprNode`) or a parameter (`ParameterNode`).
 */
class Node extends TNode {
  /** Gets the expression corresponding to this node, if any. */
  CfgNodes::ExprCfgNode asExpr() { result = this.(ExprNode).getExprNode() }

  CfgNodes::StmtCfgNode asStmt() { result = this.(StmtNode).getStmtNode() }

  ScriptBlock asCallable() { result = this.(CallableNode).asCallableAstNode() }

  /** Gets the parameter corresponding to this node, if any. */
  Parameter asParameter() { result = this.(ParameterNode).getParameter() }

  /** Gets a textual representation of this node. */
  final string toString() { result = toString(this) }

  /** Gets the location of this node. */
  final Location getLocation() { result = getLocation(this) }

  /**
   * Gets a data flow node from which data may flow to this node in one local step.
   */
  Node getAPredecessor() { localFlowStep(result, this) }

  /**
   * Gets a local source node from which data may flow to this node in zero or
   * more local data-flow steps.
   */
  LocalSourceNode getALocalSource() { result.flowsTo(this) }

  /**
   * Gets a data flow node to which data may flow from this node in one local step.
   */
  Node getASuccessor() { localFlowStep(this, result) }
}

/** A control-flow node, viewed as a node in a data flow graph. */
abstract private class AbstractAstNode extends Node {
  CfgNodes::AstCfgNode n;

  /** Gets the control-flow node corresponding to this node. */
  CfgNodes::AstCfgNode getCfgNode() { result = n }
}

final class AstNode = AbstractAstNode;

/**
 * An expression, viewed as a node in a data flow graph.
 *
 * Note that because of control-flow splitting, one `Expr` may correspond
 * to multiple `ExprNode`s, just like it may correspond to multiple
 * `ControlFlow::Node`s.
 */
class ExprNode extends AbstractAstNode, TExprNode {
  override CfgNodes::ExprCfgNode n;

  ExprNode() { this = TExprNode(n) }

  /** Gets the expression corresponding to this node. */
  CfgNodes::ExprCfgNode getExprNode() { result = n }
}

/**
 * A statement, viewed as a node in a data flow graph.
 *
 * Note that because of control-flow splitting, one `Stmt` may correspond
 * to multiple `StmtNode`s, just like it may correspond to multiple
 * `ControlFlow::Node`s.
 */
class StmtNode extends AbstractAstNode, TStmtNode {
  override CfgNodes::StmtCfgNode n;

  StmtNode() { this = TStmtNode(n) }

  /** Gets the expression corresponding to this node. */
  CfgNodes::StmtCfgNode getStmtNode() { result = n }
}

/**
 * The value of a parameter at function entry, viewed as a node in a data
 * flow graph.
 */
class ParameterNode extends Node {
  ParameterNode() { exists(getParameterPosition(this, _)) }

  /** Gets the parameter corresponding to this node, if any. */
  final Parameter getParameter() { result = getParameter(this) }
}

/**
 * A data flow node corresponding to a method, block, or lambda expression.
 */
class CallableNode extends Node instanceof ScriptBlockNode {
  private ParameterPosition getParameterPosition(ParameterNodeImpl node) {
    exists(DataFlowCallable c |
      c.asCfgScope() = this.asCallableAstNode() and
      result = getParameterPosition(node, c)
    )
  }

  /** Gets the underlying AST node as a `Callable`. */
  ScriptBlock asCallableAstNode() { result = super.getScriptBlock() }

  /** Gets the `n`th positional parameter. */
  ParameterNode getParameter(int n) {
    this.getParameterPosition(result).isPositional(n, emptyNamedSet())
  }

  /** Gets the number of positional parameters of this callable. */
  final int getNumberOfParameters() { result = count(this.getParameter(_)) }

  /** Gets the keyword parameter of the given name. */
  ParameterNode getKeywordParameter(string name) {
    this.getParameterPosition(result).isKeyword(name)
  }

  /**
   * Gets a data flow node whose value is about to be returned by this callable.
   */
  Node getAReturnNode() { result = getAReturnNode(this.asCallableAstNode()) }
}

/**
 * A data-flow node that is a source of local flow.
 */
class LocalSourceNode extends Node {
  LocalSourceNode() { isLocalSourceNode(this) }

  /** Starts tracking this node forward using API graphs. */
  pragma[inline]
  API::Node track() { result = API::Internal::getNodeForForwardTracking(this) }

  /** Holds if this `LocalSourceNode` can flow to `nodeTo` in one or more local flow steps. */
  pragma[inline]
  predicate flowsTo(Node nodeTo) { flowsTo(this, nodeTo) }

  /**
   * Gets a node that this node may flow to using one heap and/or interprocedural step.
   *
   * See `TypeTracker` for more details about how to use this.
   */
  pragma[inline]
  LocalSourceNode track(TypeTracker t2, TypeTracker t) { t = t2.step(this, result) }

  /**
   * Gets a node that may flow into this one using one heap and/or interprocedural step.
   *
   * See `TypeBackTracker` for more details about how to use this.
   */
  pragma[inline]
  LocalSourceNode backtrack(TypeBackTracker t2, TypeBackTracker t) { t = t2.step(result, this) }

  /**
   * Gets a node to which data may flow from this node in zero or
   * more local data-flow steps.
   */
  pragma[inline]
  Node getALocalUse() { flowsTo(this, result) }

  /** Gets a method call where this node flows to the receiver. */
  CallNode getAMethodCall() { Cached::hasMethodCall(this, result, _) }

  /** Gets a call to a method named `name`, where this node flows to the receiver. */
  CallNode getAMethodCall(string name) { Cached::hasMethodCall(this, result, name) }
}

/**
 * A node associated with an object after an operation that might have
 * changed its state.
 *
 * This can be either the argument to a callable after the callable returns
 * (which might have mutated the argument), or the qualifier of a field after
 * an update to the field.
 *
 * Nodes corresponding to AST elements, for example `ExprNode`, usually refer
 * to the value before the update.
 */
class PostUpdateNode extends Node {
  private Node pre;

  PostUpdateNode() { pre = getPreUpdateNode(this) }

  /** Gets the node before the state update. */
  Node getPreUpdateNode() { result = pre }
}

/**
 * A dataflow node that represents a component of a type or module path.
 *
 * For example, `System`, `System.Management`, `System.Management.Automation`,
 * and `System.Management.Automation.PowerShell` in the type
 * name `[System.Management.Automation.PowerShell]`.
 */
class TypePathNode extends Node instanceof TypePathNodeImpl {
  string getComponent() { result = super.getComponent() }

  TypePathNode getConstant(string s) { result = super.getConstant(s) }

  API::Node track() { result = API::mod(super.getType(), super.getIndex()) }
}

cached
private module Cached {
  cached
  predicate hasMethodCall(LocalSourceNode source, CallNode call, string name) {
    source.flowsTo(call.getQualifier()) and
    call.getName() = name
  }

  cached
  CfgScope getCfgScope(NodeImpl node) { result = node.getCfgScope() }

  cached
  ReturnNode getAReturnNode(ScriptBlock scriptBlock) { getCfgScope(result) = scriptBlock }

  cached
  Parameter getParameter(ParameterNodeImpl param) { result = param.getParameter() }

  cached
  ParameterPosition getParameterPosition(ParameterNodeImpl param, DataFlowCallable c) {
    param.isParameterOf(c, result)
  }

  cached
  ParameterPosition getSourceParameterPosition(ParameterNodeImpl param, ScriptBlock c) {
    param.isSourceParameterOf(c, result)
  }

  cached
  Node getPreUpdateNode(PostUpdateNodeImpl node) { result = node.getPreUpdateNode() }

  cached
  predicate forceCachingInSameStage() { any() }
}

private import Cached

/** Gets a node corresponding to expression `e`. */
ExprNode exprNode(CfgNodes::ExprCfgNode e) { result.getExprNode() = e }

/** Gets a node corresponding to statement `s`. */
StmtNode stmtNode(CfgNodes::StmtCfgNode e) { result.getStmtNode() = e }

/**
 * Gets the node corresponding to the value of parameter `p` at function entry.
 */
ParameterNode parameterNode(Parameter p) { result.getParameter() = p }

/**
 * Holds if data flows from `nodeFrom` to `nodeTo` in exactly one local
 * (intra-procedural) step.
 */
predicate localFlowStep = localFlowStepImpl/2;

/**
 * Holds if data flows from `source` to `sink` in zero or more local
 * (intra-procedural) steps.
 */
pragma[inline]
predicate localFlow(Node source, Node sink) { localFlowStep*(source, sink) }

/**
 * Holds if data can flow from `e1` to `e2` in zero or more
 * local (intra-procedural) steps.
 */
pragma[inline]
predicate localExprFlow(CfgNodes::ExprCfgNode e1, CfgNodes::ExprCfgNode e2) {
  localFlow(exprNode(e1), exprNode(e2))
}

/** A reference contained in an object. */
class Content extends TContent {
  /** Gets a textual representation of this content. */
  string toString() { none() }

  /** Gets the location of this content. */
  Location getLocation() { none() }
}

/** Provides different sub classes of `Content`. */
module Content {
  /** An element in a collection, for example an element in an array or in a hash. */
  class ElementContent extends Content, TElementContent { }

  /** An element in a collection at a known index. */
  class KnownElementContent extends ElementContent, TKnownElementContent {
    private ConstantValue cv;

    KnownElementContent() { this = TKnownElementContent(cv) }

    /** Gets the index in the collection. */
    ConstantValue getIndex() { result = cv }

    override string toString() { result = "element " + cv }
  }

  /** An element in a collection at an unknown index. */
  class UnknownElementContent extends ElementContent, TUnknownElementContent {
    override string toString() { result = "element" }
  }

  /** A field of an object. */
  class FieldContent extends Content, TFieldContent {
    private string name;

    FieldContent() { this = TFieldContent(name) }

    /** Gets the name of the field. */
    string getName() { result = name }

    override string toString() { result = name }
  }

  /** Gets the element content corresponding to constant value `cv`. */
  ElementContent getElementContent(ConstantValue cv) {
    result = TKnownElementContent(cv)
    or
    not exists(TKnownElementContent(cv)) and
    result = TUnknownElementContent()
  }

  /**
   * Gets the constant value of `e`, which corresponds to a valid known
   * element index. Unlike calling simply `e.getConstantValue()`, this
   * excludes negative array indices.
   */
  ConstantValue getKnownElementIndex(Expr e) {
    result = getElementContent(e.getValue()).(KnownElementContent).getIndex()
  }
}

/**
 * An entity that represents a set of `Content`s.
 *
 * The set may be interpreted differently depending on whether it is
 * stored into (`getAStoreContent`) or read from (`getAReadContent`).
 */
class ContentSet extends TContentSet {
  /** Holds if this content set is the singleton `{c}`. */
  predicate isSingleton(Content c) { this = TSingletonContent(c) }

  /** Holds if this content set represents all `ElementContent`s. */
  predicate isAnyElement() { this = TAnyElementContent() }

  /**
   * Holds if this content set represents a specific known element index, or an
   * unknown element index.
   */
  predicate isKnownOrUnknownElement(Content::KnownElementContent c) {
    this = TKnownOrUnknownElementContent(c)
  }

  /** Gets a textual representation of this content set. */
  string toString() {
    exists(Content c |
      this.isSingleton(c) and
      result = c.toString()
    )
    or
    this.isAnyElement() and
    result = "any element"
    or
    exists(Content::KnownElementContent c |
      this.isKnownOrUnknownElement(c) and
      result = c + " or unknown"
    )
  }

  Content getAStoreContent() {
    this.isSingleton(result)
    or
    // For reverse stores, `a[unknown][0] = x`, it is important that the read-step
    // from `a` to `a[unknown]` (which can read any element), gets translated into
    // a reverse store step that store only into `?`
    this.isAnyElement() and
    result = TUnknownElementContent()
    or
    // For reverse stores, `a[1][0] = x`, it is important that the read-step
    // from `a` to `a[1]` (which can read both elements stored at exactly index `1`
    // and elements stored at unknown index), gets translated into a reverse store
    // step that store only into `1`
    this.isKnownOrUnknownElement(result)
  }

  pragma[nomagic]
  private Content getAnElementReadContent() {
    exists(Content::KnownElementContent c | this.isKnownOrUnknownElement(c) |
      result = c or
      result = TUnknownElementContent()
    )
  }

  /** Gets a content that may be read from when reading from this set. */
  Content getAReadContent() {
    this.isSingleton(result)
    or
    this.isAnyElement() and
    result instanceof Content::ElementContent
    or
    result = this.getAnElementReadContent()
  }
}

/**
 * Holds if the guard `g` validates the expression `e` upon evaluating to `branch`.
 *
 * The expression `e` is expected to be a syntactic part of the guard `g`.
 * For example, the guard `g` might be a call `isSafe(x)` and the expression `e`
 * the argument `x`.
 */
signature predicate guardChecksSig(CfgNodes::AstCfgNode g, CfgNode e, boolean branch);

/**
 * Provides a set of barrier nodes for a guard that validates an expression.
 *
 * This is expected to be used in `isBarrier`/`isSanitizer` definitions
 * in data flow and taint tracking.
 */
module BarrierGuard<guardChecksSig/3 guardChecks> {
  /** Gets a node that is safely guarded by the given guard check. */
  Node getABarrierNode() {
    none() // TODO
  }
}

/**
 * A dataflow node that represents the creation of an object.
 *
 * For example, `[Foo]::new()` or `New-Object Foo`.
 */
class ObjectCreationNode extends Node {
  CfgNodes::ObjectCreationCfgNode objectCreation;

  ObjectCreationNode() {
    this.asExpr() = objectCreation
    or
    this.asStmt() = objectCreation
  }

  final CfgNodes::ObjectCreationCfgNode getObjectCreationNode() { result = objectCreation }

  string getConstructedTypeName() { result = this.getObjectCreationNode().getConstructedTypeName() }
}

/** A call, viewed as a node in a data flow graph. */
class CallNode extends AstNode {
  CfgNodes::CallCfgNode call;

  CallNode() { call = this.getCfgNode() }

  CfgNodes::CallCfgNode getCallNode() { result = call }

  string getName() { result = call.getName() }

  Node getQualifier() { result.asExpr() = call.getQualifier() }

  /** Gets the i'th argument to this call. */
  Node getArgument(int i) { result.asExpr() = call.getArgument(i) }

  /** Gets the i'th positional argument to this call. */
  Node getPositionalArgument(int i) { result.asExpr() = call.getPositionalArgument(i) }

  /** Gets the argument with the name `name`, if any. */
  Node getNamedArgument(string name) { result.asExpr() = call.getNamedArgument(name) }

  /**
   * Gets any argument of this call.
   *
   * Note that this predicate doesn't get the pipeline argument, if any.
   */
  Node getAnArgument() { result.asExpr() = call.getAnArgument() }

  int getNumberOfArguments() { result = call.getNumberOfArguments() }
}

/** A call to operator `&`, viewed as a node in a data flow graph. */
class CallOperatorNode extends CallNode {
  override CfgNodes::StmtNodes::CallOperatorCfgNode call;

  Node getCommand() { result.asExpr() = call.getCommand() }
}

/** A use of a type name, viewed as a node in a data flow graph. */
class TypeNameNode extends ExprNode {
  override CfgNodes::ExprNodes::TypeNameCfgNode n;

  final override CfgNodes::ExprNodes::TypeNameCfgNode getExprNode() { result = n }

  string getTypeName() { result = n.getTypeName() }
}
