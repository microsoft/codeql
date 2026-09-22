/**
 * Provides default sources, sinks and sanitizers for reasoning about
 * shell command constructed from library input vulnerabilities, as
 * well as extension points for adding your own.
 */

private import python
private import semmle.python.dataflow.new.DataFlow
private import semmle.python.dataflow.new.TaintTracking
private import CommandInjectionCustomizations::CommandInjection as CommandInjection
private import semmle.python.Concepts as Concepts
private import semmle.python.ApiGraphs

/**
 * Module containing sources, sinks, and sanitizers for shell command constructed from library input.
 */
module UnsafeShellCommandConstruction {
  /** A source for shell command constructed from library input vulnerabilities. */
  abstract class Source extends DataFlow::Node { }

  /** A sanitizer for shell command constructed from library input vulnerabilities. */
  abstract class Sanitizer extends DataFlow::Node { }

  private import semmle.python.frameworks.Setuptools

  /** An input parameter to a gem seen as a source. */
  private class LibraryInputAsSource extends Source instanceof DataFlow::ParameterNode {
    LibraryInputAsSource() {
      this = Setuptools::getALibraryInput() and
      not this.getParameter().getName().matches(["cmd%", "command%", "%_command", "%_cmd"])
    }
  }

  /** A sink for shell command constructed from library input vulnerabilities. */
  abstract class Sink extends DataFlow::Node {
    Sink() { not this.asExpr() instanceof StringLiteral } // filter out string constants, makes testing easier

    /** Gets a description of how the string in this sink was constructed. */
    abstract string describe();

    /** Gets the dataflow node where the string is constructed. */
    DataFlow::Node getStringConstruction() { result = this }

    /** Gets the dataflow node that executed the string as a shell command. */
    abstract DataFlow::Node getCommandExecution();
  }

  /** Holds if the string constructed at `source` is executed at `shellExec` */
  predicate isUsedAsShellCommand(DataFlow::Node source, Concepts::SystemCommandExecution shellExec) {
    source = backtrackShellExec(TypeTracker::TypeBackTracker::end(), shellExec)
  }

  import semmle.python.dataflow.new.TypeTracking as TypeTracker

  private DataFlow::LocalSourceNode backtrackShellExec(
    TypeTracker::TypeBackTracker t, Concepts::SystemCommandExecution shellExec
  ) {
    t.start() and
    result = any(DataFlow::Node n | shellExec.isShellInterpreted(n)).getALocalSource()
    or
    exists(TypeTracker::TypeBackTracker t2 |
      result = backtrackShellExec(t2, shellExec).backtrack(t2, t)
    )
  }

  private predicate isKnownShell(DataFlow::Node node) {
    node.asExpr().(StringLiteral).getText() in [
        "sh", "/bin/sh", "/usr/bin/sh", "bash", "/bin/bash", "/usr/bin/bash", "dash", "/bin/dash",
        "/usr/bin/dash", "zsh", "/bin/zsh", "/usr/bin/zsh"
      ]
  }

  private predicate isNamedTemporaryFile(DataFlow::Node node) {
    node = API::moduleImport("tempfile").getMember("NamedTemporaryFile").getACall()
  }

  private predicate isWrittenValue(DataFlow::Node construction, DataFlow::MethodCallNode write) {
    write.getMethodName() = "write" and
    DataFlow::localFlow(construction, write.getArg(0))
    or
    write.getMethodName() = "writelines" and
    exists(DataFlow::Node element |
      element.asCfgNode() = write.getArg(0).asCfgNode().(SequenceNode).getAnElement() and
      DataFlow::localFlow(construction, element)
    )
  }

  private predicate invokesArgumentVectorDirectly(API::CallNode processCall) {
    not exists(processCall.getParameter(2, "executable")) and
    (
      not exists(processCall.getParameter(8, "shell"))
      or
      processCall
          .getParameter(8, "shell")
          .getAValueReachingSink()
          .asExpr()
          .(ImmutableLiteral)
          .booleanValue() = false
    )
  }

  private predicate isWrittenToExecutedNamedTemporaryFile(
    DataFlow::Node construction, DataFlow::Node execution
  ) {
    exists(
      DataFlow::Node temporaryFile, DataFlow::MethodCallNode write, API::CallNode processCall,
      DataFlow::Node args, DataFlow::Node shell, DataFlow::Node scriptPath, Attribute nameAccess
    |
      isNamedTemporaryFile(temporaryFile) and
      DataFlow::localFlow(temporaryFile, write.getObject()) and
      isWrittenValue(construction, write) and
      processCall =
        API::moduleImport("subprocess")
            .getMember(["Popen", "run", "call", "check_call", "check_output"])
            .getACall() and
      invokesArgumentVectorDirectly(processCall) and
      write.asCfgNode().strictlyReaches(processCall.asCfgNode()) and
      args = processCall.getParameter(0, "args").asSink() and
      shell.asCfgNode() = args.asCfgNode().(SequenceNode).getElement(0) and
      scriptPath.asCfgNode() = args.asCfgNode().(SequenceNode).getElement(1) and
      isKnownShell(shell) and
      scriptPath.asExpr() = nameAccess and
      nameAccess.getName() = "name" and
      DataFlow::localFlow(temporaryFile, DataFlow::exprNode(nameAccess.getObject())) and
      execution = processCall
    )
  }

  private predicate temporaryScriptStringConstruction(
    DataFlow::Node component, DataFlow::Node construction, string description
  ) {
    exists(Fstring fstring |
      construction = DataFlow::exprNode(fstring) and
      component.asExpr() = fstring.getASubExpression() and
      description = "f-string"
    )
    or
    exists(BinaryExpr add |
      add.getOp() instanceof Add and
      construction.asExpr() = add and
      component.asExpr() = add.getASubExpression() and
      description = "string concatenation"
    )
    or
    exists(DataFlow::MethodCallNode call |
      call.getMethodName() = "join" and
      unique( | | call.getArg(_)).asExpr().(StringLiteral).getText() = " " and
      construction = call and
      (
        component = call.getArg(0) and
        not call.getArg(0).asExpr() instanceof List
        or
        component.asExpr() = call.getArg(0).asExpr().(List).getASubExpression()
      ) and
      description = "array"
    )
    or
    exists(DataFlow::Node formatCall |
      construction = formatCall and
      (
        formatCall.asExpr().(BinaryExpr).getOp() instanceof Mod and
        component.asExpr() = formatCall.asExpr().(BinaryExpr).getASubExpression()
        or
        formatCall.(DataFlow::MethodCallNode).getMethodName() = "format" and
        component =
          [
            formatCall.(DataFlow::MethodCallNode).getArg(_),
            formatCall.(DataFlow::MethodCallNode).getObject()
          ]
      ) and
      description = "formatted string"
    )
  }

  /**
   * A string construction written to a `tempfile.NamedTemporaryFile` and executed by passing the
   * same temporary-file object's `name` attribute as the script argument to a known shell.
   */
  class ExecutedNamedTemporaryScriptAsSink extends Sink {
    DataFlow::Node construction;
    DataFlow::Node execution;
    string description;

    ExecutedNamedTemporaryScriptAsSink() {
      temporaryScriptStringConstruction(this, construction, description) and
      isWrittenToExecutedNamedTemporaryFile(construction, execution)
    }

    override string describe() { result = description }

    override DataFlow::Node getCommandExecution() { result = execution }

    override DataFlow::Node getStringConstruction() { result = construction }
  }

  /**
   * A string constructed from a string-literal (e.g. `f'foo {sink}'`),
   * where the resulting string ends up being executed as a shell command.
   */
  class StringInterpolationAsSink extends Sink {
    Concepts::SystemCommandExecution s;
    Fstring fstring;

    StringInterpolationAsSink() {
      isUsedAsShellCommand(DataFlow::exprNode(fstring), s) and
      this.asExpr() = fstring.getASubExpression()
    }

    override string describe() { result = "f-string" }

    override DataFlow::Node getCommandExecution() { result = s }

    override DataFlow::Node getStringConstruction() { result.asExpr() = fstring }
  }

  /**
   * A component of a string-concatenation (e.g. `"foo " + sink`),
   * where the resulting string ends up being executed as a shell command.
   */
  class StringConcatAsSink extends Sink {
    Concepts::SystemCommandExecution s;
    BinaryExpr add;

    StringConcatAsSink() {
      add.getOp() instanceof Add and
      isUsedAsShellCommand(any(DataFlow::Node n | n.asExpr() = add), s) and
      this.asExpr() = add.getASubExpression()
    }

    override DataFlow::Node getCommandExecution() { result = s }

    override string describe() { result = "string concatenation" }

    override DataFlow::Node getStringConstruction() { result.asExpr() = add }
  }

  /**
   * A string constructed using a `" ".join(...)` call, where the resulting string ends up being executed as a shell command.
   */
  class ArrayJoin extends Sink {
    Concepts::SystemCommandExecution s;
    DataFlow::MethodCallNode call;

    ArrayJoin() {
      call.getMethodName() = "join" and
      unique( | | call.getArg(_)).asExpr().(StringLiteral).getText() = " " and
      isUsedAsShellCommand(call, s) and
      (
        this = call.getArg(0) and
        not call.getArg(0).asExpr() instanceof List
        or
        this.asExpr() = call.getArg(0).asExpr().(List).getASubExpression()
      )
    }

    override string describe() { result = "array" }

    override DataFlow::Node getCommandExecution() { result = s }

    override DataFlow::Node getStringConstruction() { result = call }
  }

  /**
   * A string constructed from a format call,
   * where the resulting string ends up being executed as a shell command.
   * Either a call to `.format(..)` or a string-interpolation with a `%` operator.
   */
  class TaintedFormatStringAsSink extends Sink {
    Concepts::SystemCommandExecution s;
    DataFlow::Node formatCall;

    TaintedFormatStringAsSink() {
      (
        formatCall.asExpr().(BinaryExpr).getOp() instanceof Mod and
        this.asExpr() = formatCall.asExpr().(BinaryExpr).getASubExpression()
        or
        formatCall.(DataFlow::MethodCallNode).getMethodName() = "format" and
        this =
          [
            formatCall.(DataFlow::MethodCallNode).getArg(_),
            formatCall.(DataFlow::MethodCallNode).getObject()
          ]
      ) and
      isUsedAsShellCommand(formatCall, s)
    }

    override string describe() { result = "formatted string" }

    override DataFlow::Node getCommandExecution() { result = s }

    override DataFlow::Node getStringConstruction() { result = formatCall }
  }

  /**
   * A call to `shlex.quote`, considered as a sanitizer.
   */
  class ShlexQuoteAsSanitizer extends Sanitizer, DataFlow::Node {
    ShlexQuoteAsSanitizer() {
      this = API::moduleImport("shlex").getMember("quote").getACall().getArg(0)
    }
  }
}
