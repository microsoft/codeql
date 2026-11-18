/**
 * @name Server Side Request Forgery (SSRF)
 * @description Making web requests based on unvalidated user-input may cause server to communicate with malicious servers.
 *              Variation: standard sources, generic sinks
 * @kind path-problem
 * @problem.severity error
 * @precision high
 * @id cs/ssrf
 * @tags security
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

from RequestForgeryFlow::PathNode source, RequestForgeryFlow::PathNode sink, string className
where
  RequestForgeryFlow::flowPath(source, sink) and
  (
    isSinkAnArgumentForAClassCallable(sink, className)
    or
    not isSinkAnArgumentForAClassCallable(sink, _) and
    className = "(Sink was not detected as an argument for a callable)"
  )
select sink.getNode(), source, sink,
  "Potential server side request forgery due to $@ flowing to a constructor or method from class $@.",
  source.getNode(), "a user-provided value", className, className
