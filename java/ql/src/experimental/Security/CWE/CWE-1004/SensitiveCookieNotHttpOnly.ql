/**
 * @name Sensitive cookies without the HttpOnly response header set
 * @description Sensitive cookies without the 'HttpOnly' flag set leaves session cookies vulnerable to
 *              an XSS attack.
 * @kind path-problem
 * @problem.severity warning
 * @precision medium
 * @id java/sensitive-cookie-not-httponly
 * @tags security
 *       experimental
 *       external/cwe/cwe-1004
 */

/*
 * Sketch of the structure of this query: we track cookie names that appear to be sensitive
 * (e.g. `session` or `token`) to a `ServletResponse.addHeader(...)` or `.addCookie(...)`
 * method that does not set the `httpOnly` flag. Subsidiary configurations
 * `MatchesHttpOnlyConfiguration` and `SetHttpOnlyInCookieConfiguration` are used to establish
 * when the `httpOnly` flag is likely to have been set, before configuration
 * `MissingHttpOnlyConfiguration` establishes that a non-`httpOnly` cookie has a sensitive-seeming name.
 */

import java
import semmle.code.java.dataflow.FlowSteps
import semmle.code.java.frameworks.Servlets
import semmle.code.java.dataflow.TaintTracking
import MissingHttpOnlyFlow::PathGraph

/** Gets a regular expression for matching common names of sensitive cookies. */
string getSensitiveCookieNameRegex() { result = "(?i).*(auth|session|token|key|credential).*" }

/** Gets a regular expression for matching CSRF cookies. */
string getCsrfCookieNameRegex() { result = "(?i).*(csrf).*" }

/**
 * Holds if a string is concatenated with the name of a sensitive cookie. Excludes CSRF cookies since
 * they are special cookies implementing the Synchronizer Token Pattern that can be used in JavaScript.
 */
predicate isSensitiveCookieNameExpr(Expr expr) {
  exists(string s | s = expr.(CompileTimeConstantExpr).getStringValue() |
    s.regexpMatch(getSensitiveCookieNameRegex()) and not s.regexpMatch(getCsrfCookieNameRegex())
  )
  or
  isSensitiveCookieNameExpr(expr.(AddExpr).getAnOperand())
}

/** A sensitive cookie name. */
class SensitiveCookieNameExpr extends Expr {
  SensitiveCookieNameExpr() { isSensitiveCookieNameExpr(this) }
}

/** A method call that sets a `Set-Cookie` header. */
class SetCookieMethodCall extends MethodCall {
  SetCookieMethodCall() {
    (
      this.getMethod() instanceof ResponseAddHeaderMethod or
      this.getMethod() instanceof ResponseSetHeaderMethod
    ) and
    this.getArgument(0).(CompileTimeConstantExpr).getStringValue().toLowerCase() = "set-cookie"
  }
}

/**
 * A taint configuration tracking flow from the text `httponly` to argument 1 of
 * `SetCookieMethodCall`.
 */
module MatchesHttpOnlyConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) {
    source.asExpr().(CompileTimeConstantExpr).getStringValue().toLowerCase().matches("%httponly%")
  }

  predicate isSink(DataFlow::Node sink) {
    sink.asExpr() = any(SetCookieMethodCall ma).getArgument(1)
  }
}

module MatchesHttpOnlyFlow = TaintTracking::Global<MatchesHttpOnlyConfig>;

/** A class descended from `javax.servlet.http.Cookie`. */
class CookieClass extends RefType {
  CookieClass() { this.getAnAncestor().hasQualifiedName("javax.servlet.http", "Cookie") }
}

/** Holds if `expr` is any boolean-typed expression other than literal `false`. */
// Inlined because this could be a very large result set if computed out of context
pragma[inline]
predicate mayBeBooleanTrue(Expr expr) {
  expr.getType() instanceof BooleanType and
  not expr.(CompileTimeConstantExpr).getBooleanValue() = false
}

/** Holds if the method call may set the `HttpOnly` flag. */
predicate setsCookieHttpOnly(MethodCall ma) {
  ma.getMethod().getName() = "setHttpOnly" and
  // any use of setHttpOnly(x) where x isn't false is probably safe
  mayBeBooleanTrue(ma.getArgument(0))
}

/** Holds if `ma` removes a cookie. */
predicate removesCookie(MethodCall ma) {
  ma.getMethod().getName() = "setMaxAge" and
  ma.getArgument(0).(IntegerLiteral).getIntValue() = 0
}

/**
 * Holds if the MethodCall `ma` is a test method call indicated by:
 *    a) in a test directory such as `src/test/java`
 *    b) in a test package whose name has the word `test`
 *    c) in a test class whose name has the word `test`
 *    d) in a test class implementing a test framework such as JUnit or TestNG
 */
predicate isTestMethod(MethodCall ma) {
  exists(Method m |
    m = ma.getEnclosingCallable() and
    (
      m.getDeclaringType().getName().toLowerCase().matches("%test%") or // Simple check to exclude test classes to reduce FPs
      m.getDeclaringType().getPackage().getName().toLowerCase().matches("%test%") or // Simple check to exclude classes in test packages to reduce FPs
      exists(m.getLocation().getFile().getAbsolutePath().indexOf("/src/test/java")) or //  Match test directory structure of build tools like maven
      m instanceof TestMethod // Test method of a test case implementing a test framework such as JUnit or TestNG
    )
  )
}

/**
 * A taint configuration tracking flow of a method that sets the `HttpOnly` flag,
 * or one that removes a cookie, to a `ServletResponse.addCookie` call.
 */
module SetHttpOnlyOrRemovesCookieConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) {
    source.asExpr() =
      any(MethodCall ma | setsCookieHttpOnly(ma) or removesCookie(ma)).getQualifier()
  }

  predicate isSink(DataFlow::Node sink) {
    sink.asExpr() =
      any(MethodCall ma | ma.getMethod() instanceof ResponseAddCookieMethod).getArgument(0)
  }
}

module SetHttpOnlyOrRemovesCookieFlow = TaintTracking::Global<SetHttpOnlyOrRemovesCookieConfig>;

/**
 * A cookie that is added to an HTTP response and which doesn't have `httpOnly` set, used as a sink
 * in `MissingHttpOnlyConfiguration`.
 */
class CookieResponseSink extends DataFlow::ExprNode {
  CookieResponseSink() {
    exists(MethodCall ma |
      (
        ma.getMethod() instanceof ResponseAddCookieMethod and
        this.getExpr() = ma.getArgument(0) and
        not SetHttpOnlyOrRemovesCookieFlow::flowTo(this)
        or
        ma instanceof SetCookieMethodCall and
        this.getExpr() = ma.getArgument(1) and
        not MatchesHttpOnlyFlow::flowTo(this) // response.addHeader("Set-Cookie", "token=" +authId + ";HttpOnly;Secure")
      ) and
      not isTestMethod(ma) // Test class or method
    )
  }
}

/** Holds if `cie` is an invocation of a JAX-RS `NewCookie` constructor that sets `HttpOnly` to true. */
predicate setsHttpOnlyInNewCookie(ClassInstanceExpr cie) {
  cie.getConstructedType().hasQualifiedName(["javax.ws.rs.core", "jakarta.ws.rs.core"], "NewCookie") and
  (
    cie.getNumArgument() = 6 and
    mayBeBooleanTrue(cie.getArgument(5)) // NewCookie(Cookie cookie, String comment, int maxAge, Date expiry, boolean secure, boolean httpOnly)
    or
    cie.getNumArgument() = 8 and
    cie.getArgument(6).getType() instanceof BooleanType and
    mayBeBooleanTrue(cie.getArgument(7)) // NewCookie(String name, String value, String path, String domain, String comment, int maxAge, boolean secure, boolean httpOnly)
    or
    cie.getNumArgument() = 10 and
    mayBeBooleanTrue(cie.getArgument(9)) // NewCookie(String name, String value, String path, String domain, int version, String comment, int maxAge, Date expiry, boolean secure, boolean httpOnly)
  )
}

/**
 * A taint configuration tracking flow from a sensitive cookie without the `HttpOnly` flag
 * set to its HTTP response.
 */
module MissingHttpOnlyConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) { source.asExpr() instanceof SensitiveCookieNameExpr }

  predicate isSink(DataFlow::Node sink) { sink instanceof CookieResponseSink }

  predicate isBarrier(DataFlow::Node node) {
    // JAX-RS's `new NewCookie("session-access-key", accessKey, "/", null, null, 0, true, true)` and similar
    setsHttpOnlyInNewCookie(node.asExpr())
  }

  predicate isAdditionalFlowStep(DataFlow::Node pred, DataFlow::Node succ) {
    exists(
      ConstructorCall cc // new Cookie(...)
    |
      cc.getConstructedType() instanceof CookieClass and
      pred.asExpr() = cc.getAnArgument() and
      succ.asExpr() = cc
    )
    or
    exists(
      MethodCall ma // cookie.toString()
    |
      ma.getMethod().getName() = "toString" and
      ma.getQualifier().getType() instanceof CookieClass and
      pred.asExpr() = ma.getQualifier() and
      succ.asExpr() = ma
    )
  }
}

module MissingHttpOnlyFlow = TaintTracking::Global<MissingHttpOnlyConfig>;

deprecated query predicate problems(
  DataFlow::Node sinkNode, MissingHttpOnlyFlow::PathNode source, MissingHttpOnlyFlow::PathNode sink,
  string message1, DataFlow::Node sourceNode, string message2
) {
  MissingHttpOnlyFlow::flowPath(source, sink) and
  sinkNode = sink.getNode() and
  message1 = "$@ doesn't have the HttpOnly flag set." and
  sourceNode = source.getNode() and
  message2 = "This sensitive cookie"
}
