/**
 * Provides an implementation of _API graphs_, which allow efficient modelling of how a given
 * value is used by the code base or how values produced by the code base are consumed by a library.
 *
 * See `API::Node` for more details.
 */

private import powershell
private import semmle.code.powershell.dataflow.DataFlow
private import semmle.code.powershell.typetracking.ApiGraphShared
private import semmle.code.powershell.typetracking.internal.TypeTrackingImpl
private import semmle.code.powershell.controlflow.Cfg
private import frameworks.data.internal.ApiGraphModels
private import frameworks.data.internal.ApiGraphModelsExtensions as Extensions
private import frameworks.data.internal.ApiGraphModelsSpecific as Specific
private import semmle.code.powershell.dataflow.internal.DataFlowPrivate as DataFlowPrivate
private import semmle.code.powershell.dataflow.internal.DataFlowDispatch as DataFlowDispatch

/**
 * Provides classes and predicates for working with APIs used in a database.
 */
module API {
  /**
   * A node in the API graph, that is, a value that can be tracked interprocedurally.
   *
   * The API graph is a graph for tracking values of certain types in a way that accounts for inheritance
   * and interprocedural data flow.
   *
   * API graphs are typically used to identify "API calls", that is, calls to an external function
   * whose implementation is not necessarily part of the current codebase.
   *
   * ### Basic usage
   *
   * The most basic use of API graphs is typically as follows:
   * 1. Start with `API::getTopLevelMember` for the relevant library.
   * 2. Follow up with a chain of accessors such as `getMethod` describing how to get to the relevant API function.
   * 3. Map the resulting API graph nodes to data-flow nodes, using `asSource`, `asSink`, or `asCall`.
   *
   * ### Data flow
   *
   * The members predicates on this class generally take inheritance and data flow into account.
   *
   * ### Backward data flow
   *
   * When inspecting the arguments of a call, the data flow direction is backwards.
   *
   * ### Inheritance
   *
   * When a class or module object is tracked, inheritance is taken into account.
   *
   * ### Backward data flow and classes
   *
   * When inspecting the arguments of a call, and the value flowing into that argument is a user-defined class (or an instance thereof),
   * uses of `getMethod` will find method definitions in that class (including inherited ones) rather than finding method calls.
   *
   * When modeling an external library that is known to call a specific method on a parameter, this makes
   * it possible to find the corresponding method definition in user code.
   *
   * ### Strict left-to-right evaluation
   *
   * Most member predicates on this class are intended to be chained, and are always evaluated from left to right, which means
   * the caller should restrict the initial set of values.
   *
   * For example, in the following snippet, we always find the uses of `Foo` before finding calls to `bar`:
   * ```ql
   * API::getTopLevelMember("Foo").getMethod("bar")
   * ```
   * In particular, the implementation will never look for calls to `bar` and work backward from there.
   *
   * Beware of the footgun that is to use API graphs with an unrestricted receiver:
   * ```ql
   * API::Node barCall(API::Node base) {
   *   result = base.getMethod("bar") // Do not do this!
   * }
   * ```
   * The above predicate does not restrict the receiver, and will thus perform an interprocedural data flow
   * search starting at every node in the graph, which is very expensive.
   */
  class Node extends Impl::TApiNode {
    /**
     * Gets a data-flow node where this value may flow interprocedurally.
     *
     * This is similar to `asSource()` but additionally includes nodes that are transitively reachable by data flow.
     * See `asSource()` for examples.
     */
    bindingset[this]
    pragma[inline_late]
    DataFlow::Node getAValueReachableFromSource() {
      result = getAValueReachableFromSourceInline(this)
    }

    /**
     * Gets a data-flow node where this value enters the current codebase.
     */
    bindingset[this]
    pragma[inline_late]
    DataFlow::LocalSourceNode asSource() { result = asSourceInline(this) }

    /** Gets a data-flow node where this value potentially flows into an external library. */
    bindingset[this]
    pragma[inline_late]
    DataFlow::Node asSink() { result = asSinkInline(this) }

    /** Gets a callable that can reach this sink. */
    bindingset[this]
    pragma[inline_late]
    DataFlow::CallableNode asCallable() { Impl::asCallable(this.getAnEpsilonSuccessor(), result) }

    /**
     * Get a data-flow node that transitively flows to this value, provided that this value corresponds
     * to a sink.
     *
     * This is similar to `asSink()` but additionally includes nodes that transitively reach a sink by data flow.
     * See `asSink()` for examples.
     */
    bindingset[this]
    pragma[inline_late]
    DataFlow::Node getAValueReachingSink() { result = getAValueReachingSinkInline(this) }

    /** Gets the call referred to by this API node. */
    bindingset[this]
    pragma[inline_late]
    DataFlow::CallNode asCall() { this = Impl::MkMethodAccessNode(result) }

    pragma[inline]
    Node getMember(string m) {
      // This predicate is currently not 'inline_late' because 'm' can be an input or output
      Impl::memberEdge(this.getAnEpsilonSuccessor(), m, result)
    }

    /**
     * Gets a node that may refer to an instance of the module or class represented by this API node.
     */
    bindingset[this]
    pragma[inline_late]
    Node getInstance() { Impl::instanceEdge(this.getAnEpsilonSuccessor(), result) }

    /**
     * Gets a call to `method` with this value as the receiver, or the definition of `method` on
     * an object that can reach this sink.
     */
    pragma[inline]
    Node getMethod(string method) {
      // TODO: Consider 'getMethodTarget(method)' for looking up method definitions?
      // This predicate is currently not 'inline_late' because 'method' can be an input or output
      Impl::methodEdge(this.getAnEpsilonSuccessor(), method, result)
    }

    /**
     * Gets the result of this call, or the return value of this callable.
     */
    bindingset[this]
    pragma[inline_late]
    Node getReturn() { Impl::returnEdge(this.getAnEpsilonSuccessor(), result) }

    /**
     * Gets the result of this call when there is a named argument with the
     * name `name`, or the return value of this callable.
     */
    bindingset[this]
    pragma[inline_late]
    Node getReturnWithArg(string name) {
      Impl::returnEdgeWithArg(this.getAnEpsilonSuccessor(), name, result)
    }

    /**
     * Gets the result of a call to `method` with this value as the receiver, or the return value of `method` defined on
     * an object that can reach this sink.
     *
     * This is a shorthand for `getMethod(method).getReturn()`.
     */
    pragma[inline]
    Node getReturn(string method) {
      // This predicate is currently not 'inline_late' because 'method' can be an input or output
      result = this.getMethod(method).getReturn()
    }

    /**
     * Gets the `n`th positional argument to this call.
     */
    pragma[inline]
    Node getArgument(int n) {
      // This predicate is currently not 'inline_late' because 'n' can be an input or output
      Impl::positionalArgumentEdge(this, n, result)
    }

    /**
     * Gets the given keyword argument to this call.
     */
    pragma[inline]
    Node getKeywordArgument(string name) {
      // This predicate is currently not 'inline_late' because 'name' can be an input or output
      Impl::keywordArgumentEdge(this, name, result)
    }

    /**
     * Gets the `n`th positional parameter of this callable, or the `n`th  positional argument to this call.
     *
     * Note: for historical reasons, this predicate may refer to an argument of a call, but this may change in the future.
     * When referring to an argument, it is recommended to use `getArgument(n)` instead.
     */
    pragma[inline]
    Node getParameter(int n) {
      // This predicate is currently not 'inline_late' because 'n' can be an input or output
      Impl::positionalParameterOrArgumentEdge(this.getAnEpsilonSuccessor(), n, result)
    }

    /**
     * Gets the argument passed in argument position `pos` at this call.
     */
    pragma[inline]
    Node getArgumentAtPosition(DataFlowDispatch::ArgumentPosition pos) {
      // This predicate is currently not 'inline_late' because 'pos' can be an input or output
      Impl::argumentEdge(pragma[only_bind_out](this), pos, result) // note: no need for epsilon step since 'this' must be a call
    }

    /**
     * Gets the parameter at position `pos` of this callable.
     */
    pragma[inline]
    Node getParameterAtPosition(DataFlowDispatch::ParameterPosition pos) {
      // This predicate is currently not 'inline_late' because 'pos' can be an input or output
      Impl::parameterEdge(this.getAnEpsilonSuccessor(), pos, result)
    }

    /**
     * Gets a representative for the `content` of this value.
     *
     * When possible, it is preferrable to use one of the specialized variants of this predicate, such as `getAnElement`.
     *
     * Concretely, this gets sources where `content` is read from this value, and as well as sinks where
     * `content` is stored onto this value or onto an object that can reach this sink.
     */
    pragma[inline]
    Node getContent(DataFlow::Content content) {
      // This predicate is currently not 'inline_late' because 'content' can be an input or output
      Impl::contentEdge(this.getAnEpsilonSuccessor(), content, result)
    }

    /**
     * Gets a representative for the `contents` of this value.
     *
     * See `getContent()` for more details.
     */
    bindingset[this, contents]
    pragma[inline_late]
    Node getContents(DataFlow::ContentSet contents) {
      // We always use getAStoreContent when generating content edges, and we always use getAReadContent when querying the graph.
      result = this.getContent(contents.getAReadContent())
    }

    /**
     * Gets a representative for an arbitrary element of this collection.
     */
    bindingset[this]
    pragma[inline_late]
    Node getAnElement() { Impl::elementEdge(this.getAnEpsilonSuccessor(), result) }

    /**
     * Gets the data-flow node that gives rise to this node, if any.
     */
    DataFlow::Node getInducingNode() {
      this = Impl::MkMethodAccessNode(result) or
      this = Impl::MkBackwardNode(result, _) or
      this = Impl::MkForwardNode(result, _) or
      this = Impl::MkSinkNode(result)
    }

    /** Gets the location of this node. */
    Location getLocation() {
      result = this.getInducingNode().getLocation()
      or
      this instanceof RootNode and
      result instanceof EmptyLocation
      or
      not this instanceof RootNode and
      not exists(this.getInducingNode()) and
      result instanceof EmptyLocation
    }

    /**
     * Gets a textual representation of this element.
     */
    string toString() { none() }

    pragma[inline]
    private Node getAnEpsilonSuccessor() { result = getAnEpsilonSuccessorInline(this) }
  }

  /** The root node of an API graph. */
  private class RootNode extends Node, Impl::MkRoot {
    override string toString() { result = "Root()" }
  }

  /** A node representing a given type-tracking state when tracking forwards. */
  private class ForwardNode extends Node, Impl::MkForwardNode {
    private DataFlow::LocalSourceNode node;
    private TypeTracker tracker;

    ForwardNode() { this = Impl::MkForwardNode(node, tracker) }

    override string toString() {
      if tracker.start()
      then result = "ForwardNode(" + node + ")"
      else result = "ForwardNode(" + node + ", " + tracker + ")"
    }
  }

  /** A node representing a given type-tracking state when tracking backwards. */
  private class BackwardNode extends Node, Impl::MkBackwardNode {
    private DataFlow::LocalSourceNode node;
    private TypeTracker tracker;

    BackwardNode() { this = Impl::MkBackwardNode(node, tracker) }

    override string toString() {
      if tracker.start()
      then result = "BackwardNode(" + node + ")"
      else result = "BackwardNode(" + node + ", " + tracker + ")"
    }
  }

  /** A node corresponding to the method being invoked at a method call. */
  class MethodAccessNode extends Node, Impl::MkMethodAccessNode {
    override string toString() { result = "MethodAccessNode(" + this.asCall() + ")" }
  }

  /**
   * A node corresponding to an argument, right-hand side of a store, or return value from a callable.
   *
   * Such a node may serve as the starting-point of backtracking, and has epsilon edges going to
   * the backward nodes corresponding to `getALocalSource`.
   */
  private class SinkNode extends Node, Impl::MkSinkNode {
    override string toString() { result = "SinkNode(" + this.getInducingNode() + ")" }
  }

  bindingset[namespace]
  private string maybePrefixSystem(string namespace) {
    if namespace.matches("system.%") then result = namespace else result = "system." + namespace
  }

  bindingset[name, namespace]
  private string getANameFullName(string name, string namespace) {
    exists(string fullName |
      Specific::parseRelevantType(fullName, result, _) and
      result.matches(maybePrefixSystem(namespace) + "." + name + "%")
    )
  }

  private predicate needsExplicitTypeNameNode(
    CfgNodes::ExprNodes::TypeNameExprCfgNode typeName, string fullName, int index
  ) {
    exists(string name, string namespace |
      name = typeName.getLowerCaseName() and
      namespace = typeName.getNamespace() and
      fullName = getANameFullName(name, namespace) and
      index = [0 .. strictcount(fullName.indexOf(".")) - 1]
    )
  }

  private predicate needsImplicitTypeNameNode(string fullName, int index) {
    index = [0 .. strictcount(fullName.indexOf("."))] and
    exists(string implicitImportedFullName |
      implicitImportedFullName.matches("microsoft.powershell.%") and
      isRelevantType(implicitImportedFullName) and
      Specific::parseRelevantType(implicitImportedFullName, fullName, _)
    )
  }

  abstract private class AbstractTypeNameNode extends Node {
    string fullName;
    int index;

    bindingset[fullName, index]
    AbstractTypeNameNode() { any() }

    override string toString() { result = "TypeNameNode(" + this.getTypeName() + ")" }

    private string getComponent(int i) { result = fullName.splitAt(".", i) }

    int getNumberOfComponents() { result = strictcount(int i | exists(this.getComponent(i))) }

    string getComponent() { result = this.getComponent(index) }

    string getTypeName() {
      result =
        strictconcat(int i, string s | s = this.getComponent(i) and i <= index | s, "." order by i)
    }

    abstract Node getSuccessor(string name);

    Node memberEdge(string name) { none() }

    Node methodEdge(string name) { none() }

    final predicate isImplicit() { not this.isExplicit(_) }

    predicate isExplicit(CfgNodes::ExprNodes::TypeNameExprCfgNode typeName) { none() }
  }

  final class TypeNameNode = AbstractTypeNameNode;

  private class ExplicitTypeNameNode extends AbstractTypeNameNode, Impl::MkExplicitTypeNameNode {
    ExplicitTypeNameNode() { this = Impl::MkExplicitTypeNameNode(fullName, index) }

    final override Node getSuccessor(string name) {
      exists(ExplicitTypeNameNode succ |
        succ = Impl::MkExplicitTypeNameNode(fullName, index + 1) and
        name = succ.getComponent() and
        result = succ
      )
      or
      exists(CfgNodes::ExprNodes::TypeNameExprCfgNode typeName |
        needsExplicitTypeNameNode(typeName, fullName, index) and
        not exists(Impl::MkExplicitTypeNameNode(fullName, index + 1)) and
        name = fullName.splitAt(".", index + 1) and
        result = getForwardStartNode(DataFlow::exprNode(typeName))
      )
    }

    final override predicate isExplicit(CfgNodes::ExprNodes::TypeNameExprCfgNode typeName) {
      needsExplicitTypeNameNode(typeName, fullName, _)
    }
  }

  private string getAnAlias(string cmdlet) {
    cmdlet = "add-content" and result = ["ac"]
    or
    cmdlet = "clear-content" and result = ["clc"]
    or
    cmdlet = "clear-item" and result = ["cli"]
    or
    cmdlet = "clear-itemproperty" and result = ["clp"]
    or
    cmdlet = "convert-path" and result = ["cvpa"]
    or
    cmdlet = "copy-item" and result = ["copy", "cp", "cpi"]
    or
    cmdlet = "copy-itemproperty" and result = ["cpp"]
    or
    cmdlet = "get-childitem" and result = ["dir", "gci", "ls"]
    or
    cmdlet = "get-clipboard" and result = ["gcb"]
    or
    cmdlet = "get-computerinfo" and result = ["gin"]
    or
    cmdlet = "get-content" and result = ["cat", "gc", "type"]
    or
    cmdlet = "get-item" and result = ["gi"]
    or
    cmdlet = "get-itemproperty" and result = ["gp"]
    or
    cmdlet = "get-itempropertyvalue" and result = ["gpv"]
    or
    cmdlet = "get-location" and result = ["gl", "pwd"]
    or
    cmdlet = "get-process" and result = ["gps", "ps"]
    or
    cmdlet = "get-psdrive" and result = ["gdr"]
    or
    cmdlet = "get-service" and result = ["gsv"]
    or
    cmdlet = "get-timezone" and result = ["gtz"]
    or
    cmdlet = "invoke-item" and result = ["ii"]
    or
    cmdlet = "move-item" and result = ["mi", "move", "mv"]
    or
    cmdlet = "move-itemproperty" and result = ["mp"]
    or
    cmdlet = "new-item" and result = ["ni"]
    or
    cmdlet = "new-psdrive" and result = ["mount", "ndr"]
    or
    cmdlet = "pop-location" and result = ["popd"]
    or
    cmdlet = "push-location" and result = ["pushd"]
    or
    cmdlet = "remove-item" and result = ["del", "erase", "rd", "ri", "rm", "rmdir"]
    or
    cmdlet = "remove-itemproperty" and result = ["rp"]
    or
    cmdlet = "remove-psdrive" and result = ["rdr"]
    or
    cmdlet = "rename-item" and result = ["ren", "rni"]
    or
    cmdlet = "rename-itemproperty" and result = ["rnp"]
    or
    cmdlet = "resolve-path" and result = ["rvpa"]
    or
    cmdlet = "set-clipboard" and result = ["scb"]
    or
    cmdlet = "set-item" and result = ["si"]
    or
    cmdlet = "set-itemproperty" and result = ["sp"]
    or
    cmdlet = "set-location" and result = ["cd", "chdir", "sl"]
    or
    cmdlet = "set-timezone" and result = ["stz"]
    or
    cmdlet = "start-process" and result = ["saps", "start"]
    or
    cmdlet = "start-service" and result = ["sasv"]
    or
    cmdlet = "stop-process" and result = ["kill", "spps"]
    or
    cmdlet = "stop-service" and result = ["spsv"]
    or
    cmdlet = "compress-psresource" and result = ["cmres"]
    or
    cmdlet = "find-psresource" and result = ["fdres"]
    or
    cmdlet = "get-installedpsresource" and result = ["get-psresource"]
    or
    cmdlet = "install-psresource" and result = ["isres"]
    or
    cmdlet = "publish-psresource" and result = ["pbres"]
    or
    cmdlet = "update-psresource" and result = ["udres"]
    or
    cmdlet = "clear-variable" and result = ["clv"]
    or
    cmdlet = "compare-object" and result = ["compare", "diff"]
    or
    cmdlet = "disable-psbreakpoint" and result = ["dbp"]
    or
    cmdlet = "enable-psbreakpoint" and result = ["ebp"]
    or
    cmdlet = "export-alias" and result = ["epal"]
    or
    cmdlet = "export-csv" and result = ["epcsv"]
    or
    cmdlet = "format-custom" and result = ["fc"]
    or
    cmdlet = "format-hex" and result = ["fhx"]
    or
    cmdlet = "format-list" and result = ["fl"]
    or
    cmdlet = "format-table" and result = ["ft"]
    or
    cmdlet = "format-wide" and result = ["fw"]
    or
    cmdlet = "get-alias" and result = ["gal"]
    or
    cmdlet = "get-error" and result = ["gerr"]
    or
    cmdlet = "get-member" and result = ["gm"]
    or
    cmdlet = "get-psbreakpoint" and result = ["gbp"]
    or
    cmdlet = "get-pscallstack" and result = ["gcs"]
    or
    cmdlet = "get-unique" and result = ["gu"]
    or
    cmdlet = "get-variable" and result = ["gv"]
    or
    cmdlet = "group-object" and result = ["group"]
    or
    cmdlet = "import-alias" and result = ["ipal"]
    or
    cmdlet = "import-csv" and result = ["ipcsv"]
    or
    cmdlet = "invoke-expression" and result = ["iex"]
    or
    cmdlet = "invoke-restmethod" and result = ["irm"]
    or
    cmdlet = "invoke-webrequest" and result = ["iwr"]
    or
    cmdlet = "measure-object" and result = ["measure"]
    or
    cmdlet = "new-alias" and result = ["nal"]
    or
    cmdlet = "new-variable" and result = ["nv"]
    or
    cmdlet = "out-gridview" and result = ["ogv"]
    or
    cmdlet = "remove-psbreakpoint" and result = ["rbp"]
    or
    cmdlet = "remove-variable" and result = ["rv"]
    or
    cmdlet = "select-object" and result = ["select"]
    or
    cmdlet = "select-string" and result = ["sls"]
    or
    cmdlet = "set-alias" and result = ["sal"]
    or
    cmdlet = "set-psbreakpoint" and result = ["sbp"]
    or
    cmdlet = "set-variable" and result = ["set", "sv"]
    or
    cmdlet = "show-command" and result = ["shcm"]
    or
    cmdlet = "sort-object" and result = ["sort"]
    or
    cmdlet = "start-sleep" and result = ["sleep"]
    or
    cmdlet = "tee-object" and result = ["tee"]
    or
    cmdlet = "write-output" and result = ["echo", "write"]
    or
    cmdlet = "add-localgroupmember" and result = ["algm"]
    or
    cmdlet = "disable-localuser" and result = ["dlu"]
    or
    cmdlet = "enable-localuser" and result = ["elu"]
    or
    cmdlet = "get-localgroup" and result = ["glg"]
    or
    cmdlet = "get-localgroupmember" and result = ["glgm"]
    or
    cmdlet = "get-localuser" and result = ["glu"]
    or
    cmdlet = "new-localgroup" and result = ["nlg"]
    or
    cmdlet = "new-localuser" and result = ["nlu"]
    or
    cmdlet = "remove-localgroup" and result = ["rlg"]
    or
    cmdlet = "remove-localgroupmember" and result = ["rlgm"]
    or
    cmdlet = "remove-localuser" and result = ["rlu"]
    or
    cmdlet = "rename-localgroup" and result = ["rnlg"]
    or
    cmdlet = "rename-localuser" and result = ["rnlu"]
    or
    cmdlet = "set-localgroup" and result = ["slg"]
    or
    cmdlet = "set-localuser" and result = ["slu"]
  }

  predicate implicitCmdlet(string mod, string cmdlet) {
    exists(string cmdlet0 |
      mod = "cimcmdlets" and
      cmdlet0 =
        [
          "remove-ciminstance",
          "import-binarymilog",
          "get-cimclass",
          "new-ciminstance",
          "cimcmdlets",
          "get-cimsession",
          "new-cimsession",
          "get-cimassociatedinstance",
          "export-binarymilog",
          "new-cimsessionoption",
          "set-ciminstance",
          "invoke-cimmethod",
          "get-ciminstance",
          "remove-cimsession",
          "register-cimindicationevent"
        ]
      or
      mod = "ise" and
      cmdlet0 =
        [
          "new-isesnippet",
          "import-isesnippet",
          "get-isesnippet",
          "ise"
        ]
      or
      mod = "microsoft.powershell.archive" and
      cmdlet0 =
        [
          "microsoft.powershell.archive",
          "expand-archive",
          "compress-archive"
        ]
      or
      mod = "microsoft.powershell.core" and
      cmdlet0 =
        [
          "test-pssessionconfigurationfile",
          "export-modulemember",
          "get-pssubsystem",
          "where-object",
          "new-pssessionconfigurationfile",
          "get-pssnapin",
          "tabexpansion2",
          "clear-history",
          "get-history",
          "remove-pssession",
          "debug-job",
          "register-pssessionconfiguration",
          "new-modulemanifest",
          "disable-pssessionconfiguration",
          "invoke-command",
          "get-pshostprocessinfo",
          "get-pssessionconfiguration",
          "wait-job",
          "enable-experimentalfeature",
          "add-pssnapin",
          "new-psrolecapabilityfile",
          "new-pssessionoption",
          "receive-job",
          "disconnect-pssession",
          "set-pssessionconfiguration",
          "add-history",
          "remove-pssnapin",
          "export-console",
          "get-help",
          "suspend-job",
          "switch-process",
          "remove-job",
          "receive-pssession",
          "save-help",
          "connect-pssession",
          "get-experimentalfeature",
          "import-module",
          "remove-module",
          "get-pssessioncapability",
          "new-module",
          "set-psdebug",
          "enable-psremoting",
          "get-job",
          "out-null",
          "get-pssession",
          "start-job",
          "exit-pssession",
          "register-argumentcompleter",
          "invoke-history",
          "new-pstransportoption",
          "new-pssession",
          "disable-experimentalfeature",
          "enable-pssessionconfiguration",
          "foreach-object",
          "disable-psremoting",
          "enter-pssession",
          "set-strictmode",
          "stop-job",
          "get-verb",
          "update-help",
          "resume-job",
          "microsoft.powershell.core",
          "get-module",
          "clear-host",
          "enter-pshostprocess",
          "get-command",
          "test-modulemanifest",
          "unregister-pssessionconfiguration",
          "exit-pshostprocess",
          "out-default",
          "out-host"
        ]
      or
      mod = "microsoft.powershell.diagnostics" and
      cmdlet0 =
        [
          "get-counter",
          "export-counter",
          "get-winevent",
          "new-winevent",
          "microsoft.powershell.diagnostics",
          "import-counter"
        ]
      or
      mod = "microsoft.powershell.host" and
      cmdlet0 =
        [
          "start-transcript",
          "stop-transcript"
        ]
      or
      mod = "microsoft.powershell.localaccounts" and
      cmdlet0 =
        [
          "new-localgroup",
          "rename-localuser",
          "new-localuser",
          "add-localgroupmember",
          "set-localgroup",
          "enable-localuser",
          "disable-localuser",
          "get-localgroup",
          "remove-localgroup",
          "set-localuser",
          "remove-localgroupmember",
          "remove-localuser",
          "get-localgroupmember",
          "get-localuser",
          "rename-localgroup",
        ]
      or
      mod = "microsoft.powershell.management" and
      cmdlet0 =
        [
          "reset-computermachinepassword",
          "rename-itemproperty",
          "set-itemproperty",
          "get-itemproperty",
          "remove-item",
          "set-service",
          "restore-computer",
          "test-path",
          "copy-itemproperty",
          "get-wmiobject",
          "show-controlpanelitem",
          "test-computersecurechannel",
          "clear-eventlog",
          "remove-psdrive",
          "get-itempropertyvalue",
          "convert-path",
          "remove-wmiobject",
          "show-eventlog",
          "resolve-path",
          "get-location",
          "stop-computer",
          "move-item",
          "invoke-wmimethod",
          "add-content",
          "split-path",
          "undo-transaction",
          "set-location",
          "get-childitem",
          "start-transaction",
          "suspend-service",
          "set-timezone",
          "wait-process",
          "stop-service",
          "new-webserviceproxy",
          "get-content",
          "set-wmiinstance",
          "stop-process",
          "clear-content",
          "checkpoint-computer",
          "complete-transaction",
          "get-eventlog",
          "debug-process",
          "clear-recyclebin",
          "start-process",
          "copy-item",
          "write-eventlog",
          "set-content",
          "new-itemproperty",
          "restart-service",
          "get-controlpanelitem",
          "move-itemproperty",
          "get-transaction",
          "new-eventlog",
          "get-hotfix",
          "add-computer",
          "push-location",
          "start-service",
          "join-path",
          "test-connection",
          "set-clipboard",
          "get-timezone",
          "get-service",
          "restart-computer",
          "clear-itemproperty",
          "resume-service",
          "new-psdrive",
          "get-psprovider",
          "get-psdrive",
          "limit-eventlog",
          "rename-computer",
          "get-computerrestorepoint",
          "pop-location",
          "rename-item",
          "remove-itemproperty",
          "enable-computerrestore",
          "register-wmievent",
          "get-computerinfo",
          "remove-service",
          "disable-computerrestore",
          "set-item",
          "remove-computer",
          "invoke-item",
          "use-transaction",
          "get-process",
          "get-item",
          "new-item",
          "get-clipboard",
          "remove-eventlog",
          "clear-item",
          "new-service"
        ]
      or
      mod = "microsoft.powershell.odatautils" and
      cmdlet0 = ["export-odataendpointproxy"]
      or
      mod = "microsoft.powershell.operation.validation" and
      cmdlet0 =
        [
          "get-operationvalidation",
          "invoke-operationvalidation"
        ]
      or
      mod = "microsoft.powershell.security" and
      cmdlet0 =
        [
          "get-pfxcertificate",
          "set-authenticodesignature",
          "get-acl",
          "get-credential",
          "get-executionpolicy",
          "protect-cmsmessage",
          "set-acl",
          "get-authenticodesignature",
          "get-cmsmessage",
          "new-filecatalog",
          "unprotect-cmsmessage",
          "set-executionpolicy",
          "convertto-securestring",
          "test-filecatalog",
          "convertfrom-securestring"
        ]
      or
      mod = "microsoft.powershell.utility" and
      cmdlet0 =
        [
          "convertfrom-string",
          "remove-typedata",
          "set-markdownoption",
          "import-powershelldatafile",
          "get-markdownoption",
          "tee-object",
          "get-event",
          "write-debug",
          "import-pssession",
          "select-string",
          "register-engineevent",
          "convertfrom-stringdata",
          "select-object",
          "write-progress",
          "set-tracesource",
          "group-object",
          "get-error",
          "update-typedata",
          "get-uptime",
          "new-event",
          "write-error",
          "add-member",
          "get-filehash",
          "import-alias",
          "get-pscallstack",
          "disable-runspacedebug",
          "unblock-file",
          "new-temporaryfile",
          "debug-runspace",
          "convertto-xml",
          "get-verb",
          "disable-psbreakpoint",
          "format-wide",
          "export-csv",
          "convertto-csv",
          "new-timespan",
          "show-markdown",
          "add-type",
          "import-clixml",
          "get-runspacedebug",
          "get-host",
          "get-typedata",
          "update-list",
          "clear-variable",
          "get-securerandom",
          "convertfrom-clixml",
          "get-member",
          "invoke-restmethod",
          "convertfrom-markdown",
          "show-command",
          "unregister-event",
          "export-alias",
          "convertfrom-csv",
          "send-mailmessage",
          "export-formatdata",
          "out-string",
          "format-custom",
          "write-information",
          "new-alias",
          "import-localizeddata",
          "remove-event",
          "write-warning",
          "out-file",
          "write-output",
          "write-host",
          "convertfrom-sddlstring",
          "register-objectevent",
          "update-formatdata",
          "invoke-webrequest",
          "compare-object",
          "convertto-html",
          "write-verbose",
          "format-hex",
          "get-eventsubscriber",
          "read-host",
          "measure-command",
          "start-sleep",
          "get-runspace",
          "out-gridview",
          "convertto-clixml",
          "wait-event",
          "export-pssession",
          "remove-variable",
          "get-variable",
          "remove-alias",
          "get-random",
          "set-variable",
          "set-alias",
          "get-uiculture",
          "get-alias",
          "get-date",
          "format-table",
          "get-unique",
          "set-psbreakpoint",
          "out-printer",
          "import-csv",
          "enable-psbreakpoint",
          "convert-string",
          "select-xml",
          "test-json",
          "measure-object",
          "get-psbreakpoint",
          "sort-object",
          "new-object",
          "invoke-expression",
          "wait-debugger",
          "remove-psbreakpoint",
          "new-variable",
          "get-formatdata",
          "trace-command",
          "get-culture",
          "get-tracesource",
          "new-guid",
          "enable-runspacedebug",
          "join-string",
          "export-clixml",
          "convertfrom-json",
          "format-list",
          "set-date",
          "convertto-json"
        ]
      or
      mod = "microsoft.wsman.management" and
      cmdlet0 =
        [
          "connect-wsman",
          "disconnect-wsman",
          "remove-wsmaninstance",
          "new-wsmaninstance",
          "set-wsmaninstance",
          "test-wsman",
          "get-wsmancredssp",
          "get-wsmaninstance",
          "disable-wsmancredssp",
          "new-wsmansessionoption",
          "invoke-wsmanaction",
          "set-wsmanquickconfig",
          "enable-wsmancredssp"
        ]
      or
      mod = "psdiagnostics" and
      cmdlet0 =
        [
          "enable-pstrace",
          "disable-wsmantrace",
          "enable-wsmantrace",
          "disable-pstrace",
          "set-logproperties",
          "enable-pswsmancombinedtrace",
          "get-logproperties",
          "disable-pswsmancombinedtrace",
          "start-trace",
          "stop-trace"
        ]
      or
      mod = "psreadline" and
      cmdlet0 =
        [
          "get-psreadlineoption",
          "set-psreadlinekeyhandler",
          "get-psreadlinekeyhandler",
          "remove-psreadlinekeyhandler",
          "psconsolehostreadline",
          "set-psreadlineoption"
        ]
      or
      mod = "psscheduledjob" and
      cmdlet0 =
        [
          "set-jobtrigger",
          "add-jobtrigger",
          "enable-jobtrigger",
          "disable-scheduledjob",
          "enable-scheduledjob",
          "new-scheduledjoboption",
          "unregister-scheduledjob",
          "remove-jobtrigger",
          "get-scheduledjoboption",
          "new-jobtrigger",
          "disable-jobtrigger",
          "set-scheduledjob",
          "get-jobtrigger",
          "set-scheduledjoboption",
          "register-scheduledjob",
          "get-scheduledjob"
        ]
      or
      mod = "psworkflow" and
      cmdlet0 =
        [
          "new-psworkflowsession",
          "new-psworkflowexecutionoption"
        ]
      or
      mod = "psworkflowutility" and
      cmdlet0 = "invoke-asworkflow"
      or
      mod = "threadjob" and
      cmdlet0 = "start-threadjob"
    |
      cmdlet = [cmdlet0, getAnAlias(cmdlet0)]
    )
  }

  private class ImplicitTypeNameNode extends AbstractTypeNameNode, Impl::MkImplicitTypeNameNode {
    ImplicitTypeNameNode() { this = Impl::MkImplicitTypeNameNode(fullName, index) }

    final override Node getSuccessor(string name) {
      exists(ImplicitTypeNameNode succ |
        succ = Impl::MkImplicitTypeNameNode(fullName, index + 1) and
        name = succ.getComponent() and
        result = succ
      )
    }

    final override Node memberEdge(string name) { result = this.methodEdge(name) }

    final override Node methodEdge(string name) {
      exists(DataFlow::CallNode call |
        not exists(this.getSuccessor(_)) and
        result = Impl::MkMethodAccessNode(call) and
        name = call.getLowerCaseName() and
        implicitCmdlet(fullName, name)
      )
    }
  }

  /**
   * An API entry point.
   *
   * By default, API graph nodes are only created for nodes that come from an external
   * library or escape into an external library. The points where values are cross the boundary
   * between codebases are called "entry points".
   *
   * Anything in the global scope is considered to be an entry point, but
   * additional entry points may be added by extending this class.
   */
  abstract class EntryPoint extends string {
    // Note: this class can be deprecated in Ruby, but is still referenced by shared code in ApiGraphModels.qll,
    // where it can't be removed since other languages are still dependent on the EntryPoint class.
    bindingset[this]
    EntryPoint() { any() }

    /** Gets a data-flow node corresponding to a use-node for this entry point. */
    DataFlow::LocalSourceNode getASource() { none() }

    /** Gets a data-flow node corresponding to a def-node for this entry point. */
    DataFlow::Node getASink() { none() }

    /** Gets a call corresponding to a method access node for this entry point. */
    DataFlow::CallNode getACall() { none() }

    /** Gets an API-node for this entry point. */
    API::Node getANode() { Impl::entryPointEdge(this, result) }
  }

  // Ensure all entry points are imported from ApiGraphs.qll
  private module ImportEntryPoints {
    private import semmle.code.powershell.frameworks.data.ModelsAsData
  }

  /** Gets the root node. */
  Node root() { result instanceof RootNode }

  pragma[inline]
  Node getTopLevelMember(string name) { Impl::topLevelMember(name, result) }

  /**
   * Gets an unqualified call at the top-level with the given method name.
   */
  pragma[inline]
  MethodAccessNode getTopLevelCall(string name) { Impl::toplevelCall(name, result) }

  pragma[nomagic]
  private predicate isReachable(DataFlow::LocalSourceNode node, TypeTracker t) {
    t.start() and exists(node)
    or
    exists(DataFlow::LocalSourceNode prev, TypeTracker t2 |
      isReachable(prev, t2) and
      node = prev.track(t2, t)
    )
  }

  private module SharedArg implements ApiGraphSharedSig {
    class ApiNode = Node;

    ApiNode getForwardNode(DataFlow::LocalSourceNode node, TypeTracker t) {
      result = Impl::MkForwardNode(node, t)
    }

    ApiNode getBackwardNode(DataFlow::LocalSourceNode node, TypeTracker t) {
      result = Impl::MkBackwardNode(node, t)
    }

    ApiNode getSinkNode(DataFlow::Node node) { result = Impl::MkSinkNode(node) }

    pragma[nomagic]
    predicate specificEpsilonEdge(ApiNode pred, ApiNode succ) { none() }
  }

  /** INTERNAL USE ONLY. */
  module Internal {
    private module MkShared = ApiGraphShared<SharedArg>;

    import MkShared
  }

  private import Internal
  import Internal::Public

  cached
  private module Impl {
    cached
    newtype TApiNode =
      /** The root of the API graph. */
      MkRoot() or
      /** The method accessed at `call`, synthetically treated as a separate object. */
      MkMethodAccessNode(DataFlow::CallNode call) or
      MkExplicitTypeNameNode(string fullName, int index) {
        needsExplicitTypeNameNode(_, fullName, index)
      } or
      MkImplicitTypeNameNode(string fullName, int index) {
        needsImplicitTypeNameNode(fullName, index)
      } or
      MkForwardNode(DataFlow::LocalSourceNode node, TypeTracker t) { isReachable(node, t) } or
      /** Intermediate node for following backward data flow. */
      MkBackwardNode(DataFlow::LocalSourceNode node, TypeTracker t) { isReachable(node, t) } or
      MkSinkNode(DataFlow::Node node) { needsSinkNode(node) }

    private predicate needsSinkNode(DataFlow::Node node) {
      node instanceof DataFlowPrivate::ArgumentNode
      or
      TypeTrackingInput::storeStep(node, _, _)
      or
      node = any(DataFlow::CallableNode callable).getAReturnNode()
      or
      node = any(EntryPoint e).getASink()
    }

    private import frameworks.data.ModelsAsData

    cached
    predicate topLevelMember(string name, Node node) { memberEdge(root(), name, node) }

    cached
    predicate toplevelCall(string name, Node node) {
      exists(DataFlow::CallNode call |
        call.asExpr().getExpr().getEnclosingScope() instanceof TopLevelScriptBlock and
        call.getLowerCaseName() = name and
        node = MkMethodAccessNode(call)
      )
    }

    cached
    predicate memberEdge(Node pred, string name, Node succ) {
      pred = API::root() and
      (
        succ.(TypeNameNode).getTypeName() = name
        or
        exists(DataFlow::AutomaticVariableNode automatic |
          automatic.getLowerCaseName() = name and
          succ = getForwardStartNode(automatic)
        )
      )
      or
      exists(TypeNameNode typeName | pred = typeName |
        typeName.getSuccessor(name) = succ
        or
        typeName.memberEdge(name) = succ
      )
      or
      exists(DataFlow::Node qualifier | pred = getForwardEndNode(getALocalSourceStrict(qualifier)) |
        exists(CfgNodes::ExprNodes::MemberExprReadAccessCfgNode read |
          read.getQualifier() = qualifier.asExpr() and
          read.getLowerCaseMemberName() = name and
          succ = getForwardStartNode(DataFlow::exprNode(read))
        )
        or
        exists(DataFlow::CallNode call |
          call.getLowerCaseName() = name and
          call.getQualifier() = qualifier and
          succ = MkMethodAccessNode(call)
        )
      )
    }

    cached
    predicate methodEdge(Node pred, string name, Node succ) {
      exists(DataFlow::CallNode call |
        succ = MkMethodAccessNode(call) and
        name = call.getLowerCaseName() and
        pred = getForwardEndNode(getALocalSourceStrict(call.getQualifier()))
      )
      or
      pred.(TypeNameNode).methodEdge(name) = succ
      or
      pred = API::root() and
      exists(DataFlow::CallNode call |
        not exists(call.getQualifier()) and
        succ = MkMethodAccessNode(call) and
        name = call.getLowerCaseName()
      )
    }

    cached
    predicate asCallable(Node apiNode, DataFlow::CallableNode callable) {
      apiNode = getBackwardStartNode(callable)
    }

    cached
    predicate contentEdge(Node pred, DataFlow::Content content, Node succ) {
      exists(DataFlow::Node object, DataFlow::Node value, DataFlow::ContentSet c |
        TypeTrackingInput::loadStep(object, value, c) and
        content = c.getAStoreContent() and
        // `x -> x.foo` with content "foo"
        pred = getForwardOrBackwardEndNode(getALocalSourceStrict(object)) and
        succ = getForwardStartNode(value)
        or
        // Based on `object.c = value` generate `object -> value` with content `c`
        TypeTrackingInput::storeStep(value, object, c) and
        content = c.getAStoreContent() and
        pred = getForwardOrBackwardEndNode(getALocalSourceStrict(object)) and
        succ = MkSinkNode(value)
      )
    }

    cached
    predicate elementEdge(Node pred, Node succ) {
      contentEdge(pred, any(DataFlow::ContentSet set | set.isAnyElement()).getAReadContent(), succ)
    }

    cached
    predicate parameterEdge(Node pred, DataFlowDispatch::ParameterPosition paramPos, Node succ) {
      exists(DataFlowPrivate::ParameterNodeImpl parameter, DataFlow::CallableNode callable |
        parameter.isSourceParameterOf(callable.asCallableAstNode(), paramPos) and
        pred = getBackwardEndNode(callable) and
        succ = getForwardStartNode(parameter)
      )
    }

    cached
    predicate argumentEdge(Node pred, DataFlowDispatch::ArgumentPosition argPos, Node succ) {
      exists(DataFlow::CallNode call, DataFlowPrivate::ArgumentNode argument |
        argument.sourceArgumentOf(call.asExpr(), argPos) and
        pred = MkMethodAccessNode(call) and
        succ = MkSinkNode(argument)
      )
    }

    cached
    predicate positionalArgumentEdge(Node pred, int n, Node succ) {
      argumentEdge(pred,
        any(DataFlowDispatch::ArgumentPosition pos |
          pos.isPositional(n, DataFlowPrivate::emptyNamedSet())
        ), succ)
    }

    cached
    predicate keywordArgumentEdge(Node pred, string name, Node succ) {
      argumentEdge(pred, any(DataFlowDispatch::ArgumentPosition pos | pos.isKeyword(name)), succ)
    }

    private predicate positionalParameterEdge(Node pred, int n, Node succ) {
      parameterEdge(pred,
        any(DataFlowDispatch::ParameterPosition pos |
          pos.isPositional(n, DataFlowPrivate::emptyNamedSet())
        ), succ)
    }

    cached
    predicate positionalParameterOrArgumentEdge(Node pred, int n, Node succ) {
      positionalArgumentEdge(pred, n, succ)
      or
      positionalParameterEdge(pred, n, succ)
    }

    cached
    predicate instanceEdge(Node pred, Node succ) {
      // TODO: Also model parameters with a given type here
      exists(DataFlow::ObjectCreationNode objCreation |
        pred = getForwardEndNode(objCreation.getConstructedTypeNode()) and
        succ = getForwardStartNode(objCreation)
      )
    }

    cached
    predicate returnEdge(Node pred, Node succ) {
      exists(DataFlow::CallNode call |
        pred = MkMethodAccessNode(call) and
        succ = getForwardStartNode(call)
      )
      or
      exists(DataFlow::CallableNode callable |
        pred = getBackwardEndNode(callable) and
        succ = MkSinkNode(callable.getAReturnNode())
      )
    }

    cached
    predicate returnEdgeWithArg(Node pred, string arg, Node succ) {
      exists(DataFlow::CallNode call |
        pred = MkMethodAccessNode(call) and
        exists(call.getNamedArgument(arg)) and
        succ = getForwardStartNode(call)
      )
      or
      arg = "" and // TODO
      exists(DataFlow::CallableNode callable |
        pred = getBackwardEndNode(callable) and
        succ = MkSinkNode(callable.getAReturnNode())
      )
    }

    cached
    predicate entryPointEdge(EntryPoint entry, Node node) {
      node = MkSinkNode(entry.getASink()) or
      node = getForwardStartNode(entry.getASource()) or
      node = MkMethodAccessNode(entry.getACall())
    }
  }
}
