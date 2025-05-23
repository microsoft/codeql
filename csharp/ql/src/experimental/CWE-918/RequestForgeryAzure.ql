/**
 * @name Server-side request forgery for Azure
 * @description Making a network request with user-controlled data in the URL allows for request forgery attacks.
 * @kind path-problem
 * @problem.severity error
 * @precision high
 * @id cs/request-forgery-azure
 * @tags security
 *       experimental
 *       external/cwe/cwe-918
 */

import csharp
import SsrfBarrierAzure
import RequestForgeryFlow::PathGraph
import semmle.code.csharp.dataflow.internal.ExternalFlow

/**
 * Holds when source is a `RemoteFlowSource`
 * and not from `IConfiguration` or `Ioptions`
 * and not a `StringLiteral`
 */
class RequestForgerySource extends Source {
  RequestForgerySource() {
    this instanceof RemoteFlowSource and
    // Not interested in string literals
    not isStrictlyAStringLiteral(this.asExpr()) and
    // if not Ioptions = critical severity. if Ioptions = a lower severity
    not isNodeUsingIconfigurationOrIOption(this)
  }
}

class AzureStorageClientSink extends Sink {
  AzureStorageClientSink() {
    sinkNode(this, "azure-ssrf")
    or
    sinkNode(this, "azure-ssrf-key-vault")
    or
    sinkNode(this, "azure-ssrf-storage")
  }
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
  "Potential server side request forgery using Azure Storage SDKs - data from an untrusted source $@ flows to an Azure Storage related constructor or method from class $@.",
  source.getNode(), "a user-provided value", className, className
