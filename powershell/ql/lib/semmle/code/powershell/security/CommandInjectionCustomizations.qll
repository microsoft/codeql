/**
 * Provides default sources, sinks and sanitizers for reasoning about
 * command-injection vulnerabilities, as well as extension points for
 * adding your own.
 */

private import semmle.code.powershell.dataflow.DataFlow
import semmle.code.powershell.ApiGraphs
private import semmle.code.powershell.dataflow.flowsources.FlowSources
private import semmle.code.powershell.Cfg

module CommandInjection {
  /**
   * A data flow source for command-injection vulnerabilities.
   */
  abstract class Source extends DataFlow::Node {
    /** Gets a string that describes the type of this flow source. */
    abstract string getSourceType();
  }

  /**
   * A data flow sink for command-injection vulnerabilities.
   */
  abstract class Sink extends DataFlow::Node {
    abstract string getSinkType();
  }

  /**
   * A sanitizer for command-injection vulnerabilities.
   */
  abstract class Sanitizer extends DataFlow::Node { }

  /** A source of user input, considered as a flow source for command injection. */
  class FlowSourceAsSource extends Source {
    FlowSourceAsSource() {
      this instanceof SourceNode and
      not this instanceof EnvironmentVariableSource and 
      not this instanceof InvokeWebRequest
    }

    override string getSourceType() { result = "user-provided value" }
  }

  class InvokeWebRequest extends DataFlow::CallNode {
    InvokeWebRequest(){
      this.matchesName("Invoke-WebRequest")
    }
  }

  /**
   * A command argument to a function that initiates an operating system command.
   */
  class SystemCommandExecutionSink extends Sink {
    SystemCommandExecutionSink() {
      // An argument to a call
      exists(DataFlow::CallNode call |
        call.matchesName(["Invoke-Expression", "iex"]) and
        call.getAnArgument() = this
      )
      or
      // Or the call command itself in case it's a use of "operator &" or "operator .".
      any(DataFlow::CallOperatorNode call).getCommand() = this
      or
      any(DataFlow::DotSourcingOperatorNode call).getCommand() = this
    }

    override string getSinkType() { result = "call to Invoke-Expression" }
  }

  class StartProcessSink extends Sink {
    StartProcessSink(){
      exists(DataFlow::CallNode call | 
        call.matchesName("Start-Process") and 
        call.getAnArgument() = this
      )
    }
    override string getSinkType(){ result = "call to Start-Process"}
  }

  class AddTypeSink extends Sink {
    AddTypeSink() {
      exists(DataFlow::CallNode call |
        call.matchesName("Add-Type") and
        call.getAnArgument() = this
      )
    }

    override string getSinkType() { result = "call to Add-Type" }
  }

  class InvokeScriptSink extends Sink {
    InvokeScriptSink() {
      exists(API::Node call |
        API::getTopLevelMember("executioncontext")
            .getMember("invokecommand")
            .getMethod("invokescript") = call and
        this = call.getArgument(_).asSink()
      )
    }

    override string getSinkType() { result = "call to InvokeScript" }
  }

  class CreateNestedPipelineSink extends Sink {
    CreateNestedPipelineSink() {
      exists(API::Node call |
        API::getTopLevelMember("host").getMember("runspace").getMethod("createnestedpipeline") =
          call and
        this = call.getArgument(_).asSink()
      )
    }

    override string getSinkType() { result = "call to CreateNestedPipeline" }
  }

  class AddScriptInvokeSink extends Sink {
    AddScriptInvokeSink() {
      exists(InvokeMemberExpr addscript, InvokeMemberExpr create |
        this.asExpr().getExpr() = addscript.getAnArgument() and
        addscript.matchesName("AddScript") and
        create.matchesName("Create") and
        addscript.getQualifier().(InvokeMemberExpr) = create and
        create.getQualifier().(TypeNameExpr).getAName() = "PowerShell"
      )
    }

    override string getSinkType() { result = "call to AddScript" }
  }

  class PowershellSink extends Sink {
    PowershellSink() {
      exists(CmdCall c | c.matchesName("powershell") |
        this.asExpr().getExpr() = c.getArgument(1) and
        c.getArgument(0).getValue().asString() = "-command"
        or
        this.asExpr().getExpr() = c.getArgument(0)
      )
    }

    override string getSinkType() { result = "call to Powershell" }
  }

  class CmdSink extends Sink {
    CmdSink() {
      exists(CmdCall c |
        this.asExpr().getExpr() = c.getArgument(1) and
        c.matchesName("cmd") and
        c.getArgument(0).getValue().asString() = "/c"
      )
    }

    override string getSinkType() { result = "call to Cmd" }
  }

  class ForEachObjectSink extends Sink {
    ForEachObjectSink() {
      exists(CmdCall c |
        this.asExpr().getExpr() = c.getAnArgument() and
        c.matchesName("Foreach-Object")
      )
    }

    override string getSinkType() { result = "call to ForEach-Object" }
  }

  class InvokeSink extends Sink {
    InvokeSink() {
      exists(InvokeMemberExpr ie |
        this.asExpr().getExpr() = ie.getCallee()
        or
        ie.getAName() = "Invoke" and
        ie.getQualifier().(MemberExprReadAccess).getMemberExpr() = this.asExpr().getExpr()
      )
    }

    override string getSinkType() { result = "call to Invoke" }
  }

  class CreateScriptBlockSink extends Sink {
    CreateScriptBlockSink() {
      exists(InvokeMemberExpr ie |
        this.asExpr().getExpr() = ie.getAnArgument() and
        ie.matchesName("Create") and
        ie.getQualifier().(TypeNameExpr).getAName() = "ScriptBlock"
      )
    }

    override string getSinkType() { result = "call to CreateScriptBlock" }
  }

  class NewScriptBlockSink extends Sink {
    NewScriptBlockSink() {
      exists(API::Node call |
        API::getTopLevelMember("executioncontext")
            .getMember("invokecommand")
            .getMethod("newscriptblock") = call and
        this = call.getArgument(_).asSink()
      )
    }

    override string getSinkType() { result = "call to NewScriptBlock" }
  }

  class ExpandStringSink extends Sink {
    ExpandStringSink() {
      exists(API::Node call | this = call.getArgument(_).asSink() |
        API::getTopLevelMember("executioncontext")
            .getMember("invokecommand")
            .getMethod("expandstring") = call or
        API::getTopLevelMember("executioncontext")
            .getMember("sessionstate")
            .getMember("invokecommand")
            .getMethod("expandstring") = call
      )
    }

    override string getSinkType() { result = "call to ExpandString" }
  }

  private class ExternalCommandInjectionSink extends Sink {
    ExternalCommandInjectionSink() {
      this = ModelOutput::getASinkNode("command-injection").asSink()
    }

    override string getSinkType() { result = "external command injection" }
  }

  /**
   * A sanitizer for parameters with types that structurally prevent
   * command injection. Only non-string primitive types and value types
   * are considered safe, since `[string]` parameters can still carry
   * injection payloads.
   */
  class TypedParameterSanitizer extends Sanitizer {
    TypedParameterSanitizer() {
      exists(Function f, Parameter p |
        p = f.getAParameter() and
        p.getStaticType() =
          [
            // Integer types
            "int", "int16", "int32", "int64", "long", "uint16", "uint32", "uint64",
            // Floating point types
            "float", "double", "decimal", "single",
            // Boolean types
            "bool", "boolean", "switch",
            // Byte/char types
            "byte", "sbyte", "char",
            // Date/time types
            "datetime", "timespan",
            // Other non-injectable value types
            "guid", "version", "ipaddress", "mailaddress", "uri", "regex"
          ] and
        this.asParameter() = p
      )
    }
  }

  /**
   * A sanitizer for parameters with validation attributes that constrain
   * the set of allowed values.
   */
  class ValidateAttributeSanitizer extends Sanitizer {
    ValidateAttributeSanitizer() {
      exists(Function f, Attribute a, Parameter p |
        p = f.getAParameter() and
        p.getAnAttribute() = a and
        a.getAName() =
          ["ValidateScript", "ValidateSet", "ValidatePattern", "ValidateRange"] and
        this.asParameter() = p
      )
    }
  }

  class SingleQuoteSanitizer extends Sanitizer {
    SingleQuoteSanitizer() {
      exists(ExpandableStringExpr e, VarReadAccess v |
        v = this.asExpr().getExpr() and
        e.getUnexpandedValue()
            .toLowerCase()
            .matches("%'$" + v.getVariable().getLowerCaseName() + "'%") and
        e.getAnExpr() = v
      )
    }
  }

  /**
   * A sanitizer for values that have been escaped using the PowerShell
   * `CodeGeneration` escaping APIs, which neutralize special characters.
   */
  class EscapeApiSanitizer extends Sanitizer {
    EscapeApiSanitizer() {
      exists(InvokeMemberExpr escape |
        (
          escape.matchesName("EscapeSingleQuotedStringContent") or
          escape.matchesName("EscapeFormatStringContent")
        ) and
        this.asExpr().getExpr() = escape
      )
    }
  }

  /**
   * A sanitizer for parameters that are validated by an early-exit guard
   * at the start of a function. Handles the common PowerShell pattern:
   * ```
   * param($Action)
   * if ($Action -notin @("start", "stop")) { throw "Invalid" }
   * ```
   *
   * Note: This is a limited structural check. Full guard-based barriers
   * require the BarrierGuard module (currently unimplemented).
   */
  class EarlyExitGuardSanitizer extends Sanitizer {
    EarlyExitGuardSanitizer() {
      exists(Function f, Parameter p, If guard, BinaryExpr cond |
        p = f.getAParameter() and
        this.asParameter() = p and
        // The guard is in this function (using getEnclosingFunction)
        guard.getEnclosingFunction() = f and
        cond = guard.getCondition(0) and
        // The condition compares the parameter to constants
        parameterComparedToConstants(p, cond) and
        // The guard exits early (throw or return)
        guardBodyExitsEarly(guard.getThen(0))
      )
    }
  }

  /**
   * Holds if `cond` compares parameter `p` to constant values using
   * `-notin`, `-notcontains`, `-eq`, `-ne`, or negated `-in`/`-contains`.
   */
  private predicate parameterComparedToConstants(Parameter p, BinaryExpr cond) {
    // $param -notin @("a", "b", "c")
    (
      cond instanceof NotInExpr and
      cond.getLeft().(VarReadAccess).getVariable() = p and
      allElementsConstant(cond.getRight())
    )
    or
    // $param -eq "constant"
    (
      cond instanceof EqExpr and
      cond.getLeft().(VarReadAccess).getVariable() = p and
      isConstantExpr(cond.getRight())
    )
  }

  /** Holds if all elements of an array expression are constant. */
  private predicate allElementsConstant(Expr e) {
    // @("a", "b", "c") - array expression with constant elements
    exists(ArrayExpr arr | arr = e |
      forall(Expr elem | elem = arr.getAnExpr() | isConstantExpr(elem))
    )
    or
    // "a", "b", "c" - array literal with constant elements
    exists(ArrayLiteral arr | arr = e |
      forall(Expr elem | elem = arr.getAnExpr() | isConstantExpr(elem))
    )
    or
    isConstantExpr(e)
  }

  /** Holds if `e` is a constant expression (string, number, or boolean literal). */
  private predicate isConstantExpr(Expr e) {
    e instanceof ConstExpr or
    e instanceof StringConstExpr or
    e instanceof Literal
  }

  /** Holds if the guard body contains a throw or return statement. */
  private predicate guardBodyExitsEarly(StmtBlock body) {
    body.getAStmt() instanceof ThrowStmt or
    body.getAStmt() instanceof ReturnStmt
  }

  /**
   * A sanitizer for parameters of non-top-level functions where all
   * call sites within the analyzed codebase pass constant expressions.
   * If no caller passes tainted data, the parameter cannot be exploited.
   */
  class ConstantCallSiteSanitizer extends Sanitizer {
    ConstantCallSiteSanitizer() {
      exists(Function f, Parameter p |
        p = f.getAParameter() and
        this.asParameter() = p and
        not f instanceof TopLevelFunction and
        // There is at least one call to this function
        exists(CmdCall call | call.getLowerCaseName() = f.getLowerCaseName()) and
        // All call sites pass constant values for this parameter
        forall(CmdCall call | call.getLowerCaseName() = f.getLowerCaseName() |
          isConstantExpr(call.getNamedArgument(p.getLowerCaseName()))
          or
          isConstantExpr(call.getPositionalArgument(p.getIndex()))
        )
      )
    }
  }
}
