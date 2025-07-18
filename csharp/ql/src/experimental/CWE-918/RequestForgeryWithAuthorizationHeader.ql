/**
 * @name Server-side request forgery with Authorization header
 * @description Making a network request with user-controlled data in the URL allows for request forgery attacks.
 * @kind path-problem
 * @problem.severity error
 * @precision high
 * @id cs/request-forgery-with-authorization-header
 * @tags security
 *       experimental
 *       external/cwe/cwe-918
 */

import csharp
import SsrfBarrierHost
import RequestForgeryFlow::PathGraph
import semmle.code.csharp.dataflow.internal.ExternalFlow

/**
 * Holds when source is a `RemoteFlowSource`
 */
class RequestForgerySource extends Source {
  RequestForgerySource() { this instanceof RemoteFlowSource }
}

class GeneralHttpClientSink extends Sink {
  GeneralHttpClientSink() { sinkNode(this, "ssrf") }
}

predicate isRequestVariable(Variable v) {
  v.getType().hasFullyQualifiedName("System.Net.Http", "HttpRequestMessage")
  or
  v.getType().hasFullyQualifiedName("System.Net", "HttpWebRequest")
  or
  v.getType().hasFullyQualifiedName("System.Net", "WebRequest")
}

VariableAccess getRequestForSink(Sink sink) {
  exists(Expr e, VariableAccess va | e = sink.asExpr() and isRequestVariable(va.getTarget()) |
    TaintTracking::localTaint(DataFlow::exprNode(e), DataFlow::exprNode(va)) and
    result = va
  )
}

/**
 * Holds when sink is for a request that also has an `Authorization` header set
 */
predicate hasPotentialTokenLeak(Sink sink) {
  // Authorization header is set using
  // a simple key-value assignment expression where the key is a string with a
  // case-insensitive text "Authorization".
  //
  // Example:
  //
  //   req.Headers["Authorization"] = token;
  //   req.Headers["authorization"] = token;
  //   req.Headers["aUtHoRiZaTiOn"] = token;
  exists(IndexerAccess reqHeadersMap, PropertyAccess pa |
    getRequestForSink(sink) = pa.getQualifier() and
    reqHeadersMap.getQualifier() = pa and
    pa.getProperty().getName() = "Headers" and
    reqHeadersMap.getAnIndex().(StringLiteral).getValue().toLowerCase() = "authorization"
  )
  or
  // Authorization header is set using
  // the function call Headers.Add(key, value) where the key is a string with a
  // case-insensitive text "Authorization".
  //
  // Example:
  //
  //   req.Headers.Add("Authorization", token);
  //   req.Headers.Add("authorization", token);
  //   req.Headers.Add("aUtHoRiZaTiOn", token);
  exists(MethodCall reqHeadersAdd, PropertyAccess pa |
    getRequestForSink(sink) = pa.getQualifier() and
    reqHeadersAdd.getTarget().getName() = "Add" and
    reqHeadersAdd.getQualifier() = pa and
    pa.getProperty().getName() = "Headers" and
    reqHeadersAdd.getArgument(0).getValue().toLowerCase() = "authorization"
  )
  or
  // Authorization header is set using
  // the function call Headers.Add(key, value) where the key is a constant with
  // a case-insensitive text "Authorization".
  //
  // Example:
  //
  //   req.Headers.Add(AuthorizationHeaderName, token);
  //   req.Headers.Add(Constants.AuthHeaderName, token);
  exists(MethodCall reqHeadersAdd, PropertyAccess pa, MemberConstantAccess mca |
    getRequestForSink(sink) = pa.getQualifier() and
    reqHeadersAdd.getTarget().getName() = "Add" and
    reqHeadersAdd.getQualifier() = pa and
    pa.getProperty().getName() = "Headers" and
    reqHeadersAdd.getArgument(0) = mca and
    // Let's hope the word "auth" is somewhere in the constant's name.
    mca.getTarget().getName().regexpMatch(".*(?i)auth.*")
  )
  or
  // Authorization header is set using
  // a simple key-value assignment expression where the key is a constant with
  // a case-insensitive text "Authorization".
  //
  // Example:
  //
  //   req.Headers[AuthorizationHeaderName] = token;
  //   req.Headers[Constants.AuthHeaderName] = token;
  //
  // Not supported:
  //
  //   req.Headers[sink.Config["AuthHeader"]] = token;
  exists(IndexerAccess reqHeadersMap, PropertyAccess pa, MemberConstantAccess mca |
    getRequestForSink(sink) = pa.getQualifier() and
    reqHeadersMap.getQualifier() = pa and
    pa.getProperty().getName() = "Headers" and
    reqHeadersMap.getAnIndex() = mca and
    mca.getTarget().getName().regexpMatch(".*(?i)auth.*")
  )
}

from RequestForgeryFlow::PathNode source, RequestForgeryFlow::PathNode sink, string className
where
  RequestForgeryFlow::flowPath(source, sink) and
  (
    isSinkAnArgumentForAClassCallable(sink, className)
    or
    not isSinkAnArgumentForAClassCallable(sink, _) and
    className = "(Sink was not detected as an argument for a callable)"
  ) and
  hasPotentialTokenLeak(sink.getNode())
select sink.getNode(), source, sink,
  "Potential server side request forgery due to $@ flowing to a constructor or method from class $@.",
  source.getNode(), "a user-provided value", className, className
