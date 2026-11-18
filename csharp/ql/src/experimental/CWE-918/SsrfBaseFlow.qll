import csharp
import semmle.code.csharp.frameworks.System
import semmle.code.csharp.security.dataflow.flowsources.Remote
private import codeql.util.Unit
private import semmle.code.csharp.frameworks.system.Web
private import semmle.code.csharp.frameworks.system.IO
private import semmle.code.csharp.frameworks.system.threading.Tasks
private import semmle.code.csharp.dataflow.internal.ExternalFlow

/**
 * A data flow source for server side request forgery vulnerabilities.
 */
abstract class Source extends DataFlow::Node { }

/**
 * A data flow sink for server side request forgery vulnerabilities.
 */
abstract class Sink extends DataFlow::ExprNode { }

/**
 * A data flow Barrier that blocks the flow of taint for
 * server side request forgery vulnerabilities.
 */
abstract class Barrier extends DataFlow::Node { }

/**
 * A unit class for adding additional taint steps that are specific to server-side request forgery (SSRF) attacks.
 *
 * Extend this class to add additional taint steps to the SSRF query.
 */
class RequestForgeryAdditionalFlowStep extends Unit {
  /**
   * Holds if the step from `pred` to `succ` should be considered a taint
   * step for server-side request forgery.
   */
  abstract predicate propagatesTaint(DataFlow::Node pred, DataFlow::Node succ);
}

/**
 * A base data flow configuration for detecting server side request forgery vulnerabilities.
 */
private module RequestForgeryFlowConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) { source instanceof Source }

  predicate isSink(DataFlow::Node sink) { sink instanceof Sink }

  predicate isAdditionalFlowStep(DataFlow::Node pred, DataFlow::Node succ) {
    any(RequestForgeryAdditionalFlowStep r).propagatesTaint(pred, succ)
  }

  predicate isBarrier(DataFlow::Node node) { node instanceof Barrier }
}

module RequestForgeryFlow = TaintTracking::Global<RequestForgeryFlowConfig>;

/**
 * Holds for `StringLiteral` when not part of an `InterpolatedStringExpr`
 *
 * Used in several extensions of Source class
 */
predicate isStrictlyAStringLiteral(Expr e) {
  e instanceof StringLiteral and
  not (
    e.getParent() instanceof InterpolatedStringExpr or
    e.getParent() instanceof InterpolatedStringInsertExpr
  )
}

/** Call that sets a URI for a request call. */
abstract class UriForRequestCall extends Call {
  Expr getHostArg() { none() }
}

/** Call for creating a `System.URI` object. */
class HttpRequestCreation extends UriForRequestCall {
  HttpRequestCreation() {
    this.getTarget().getDeclaringType() instanceof SystemWebHttpRequestBaseClass and
    this instanceof ConstructorInitializer
  }

  /**
   * Gets the URI-related argument of the newly created System.URI.
   */
  override Expr getHostArg() {
    result = this.getArgumentForName("uriString") or
    result = this.getArgumentForName("url")
  }
}

/**
 * Used to propagate the step to a URI when its host is assigned
 */
predicate requestForgeryStep(DataFlow::Node pred, DataFlow::Node succ) {
  // propagate to a URI when its host is assigned to
  exists(UriForRequestCall c | c.getHostArg() = pred.asExpr() | succ.asExpr() = c)
}

/**
 * Used to propagate the step to a URI when its host is assigned
 */
private class UriHostAdditionalFlowStep extends RequestForgeryAdditionalFlowStep {
  override predicate propagatesTaint(DataFlow::Node pred, DataFlow::Node succ) {
    requestForgeryStep(pred, succ)
  }
}

/**
 * Holds for return statment expression of a chained method call
 * to `Task`1` class method call where `.GetAwaiter().GetResult()` are not explicitly called
 *
 * This holds for predecessor node `s` from `return s` and successor node `ConfigureAwait` call in example:
 *
 * `await MyMethod(myString).ConfigureAwait(false);`
 *
 * `private async Task<string> MyMethod(string s) { return s; }`
 *
 * NOTE: this fixes a false negative in the csharp dataflow library until
 * https://github.com/github/codeql-csharp-team/issues/95 is addressed
 */
private class TaskAwaitAdditionalFlowStep extends RequestForgeryAdditionalFlowStep {
  override predicate propagatesTaint(DataFlow::Node pred, DataFlow::Node succ) {
    exists(MethodCall mc, SystemThreadingTasksTaskTClass c, ReturnStmt rs |
      c.getAConstructedGeneric().getAMethod().getACall() = mc and
      (
        rs.getEnclosingCallable() = mc.getQualifier().(MethodCall).getTarget()
        or
        returnStmtGenericMethodCall(mc, rs)
      )
    |
      pred.asExpr() = rs.getExpr() and
      succ.asExpr() = mc
    )
  }
}

/**
 * Holds when a generic method call has a return statement.
 *
 * This holds for `GenericMethod<object>` call and `return s` in example:
 *
 * `await GenericMethod<object>(s, null);`
 *
 * `private string GenericMethod<T>(string s, T t) { return s; }`
 */
private predicate returnStmtGenericMethodCall(MethodCall mc, ReturnStmt rs) {
  exists(Method rsMethod, MethodCall rsCall | rs.getEnclosingCallable() = rsMethod |
    rsMethod.(UnboundGenericMethod).getAConstructedGeneric().getACall() = rsCall and
    mc.getQualifier().(MethodCall) = rsCall
  )
}

/**
 * Holds for arguments to class methods or constructors.
 */
predicate isSinkAnArgumentForAClassCallable(RequestForgeryFlow::PathNode sink, string className) {
  exists(Call call, Callable calbl, Class clas |
    sink.getNode().asExpr() = call.getAnArgument().getAChild*() and
    (calbl = clas.getAConstructor() or calbl = clas.getAMethod()) and
    call = calbl.getACall() and
    className = getFullyQualifiedName(clas)
  )
}

/**
 * Returns the fully qualified name of the given element, with a period `.` between the namespace and the identifier.
 */
pragma[inline]
string getFullyQualifiedName(NamedElement e) {
  exists(string a, string b |
    e.hasFullyQualifiedName(a, b) and
    if a = "" then result = b else result = a + "." + b
  )
}

/**
 * Holds for the `path` parameter of `System.Io.File.Read%`
 * There are cases where the RemoteFlow source is used in the file path, then the url is
 * read from the file. There may be file path traversal, but not SSRF.
 */
private class FileRead extends Barrier {
  FileRead() {
    exists(MethodCall mc, Method m, Class c |
      mc = m.getACall() and
      c.getAMethod() = m and
      c instanceof SystemIOFileClass and
      m.getName().matches("Read%") and
      this.asExpr() = mc.getArgumentForName("path")
    )
  }
}
