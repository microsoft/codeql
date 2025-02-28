deprecated module;

import csharp
import semmle.code.csharp.frameworks.system.Net
import semmle.code.csharp.frameworks.System
import semmle.code.csharp.security.dataflow.flowsources.FlowSources
import semmle.code.csharp.security.Sanitizers

//If this leaves experimental this should probably go in semmle.code.csharp.frameworks.system.Net
/** The `System.Net.WebClient` class. */
class SystemNetWebClientClass extends SystemNetClass {
  SystemNetWebClientClass() { this.hasName("WebClient") }

  /** Gets the `DownloadString` method. */
  Method getDownloadStringMethod() { result = this.getAMethod("DownloadString") }
}

//If this leaves experimental this should probably go in semmle.code.csharp.frameworks.System
//Extend the already existent SystemUriClass to not touch the stdlib.
/** The `System.Uri` class. */
class SystemUriClassExtra extends SystemUriClass {
  /** Gets the `IsWellFormedUriString` method. */
  Method getIsWellFormedUriStringMethod() { result = this.getAMethod("IsWellFormedUriString") }
}

//If this leaves experimental this should probably go in semmle.code.csharp.frameworks.system
/**
 * A data flow source for uncontrolled data in path expression vulnerabilities.
 */
abstract class Source extends DataFlow::Node { }

/**
 * A data flow sink for uncontrolled data in path expression vulnerabilities.
 */
abstract class Sink extends DataFlow::ExprNode { }

/**
 * A sanitizer for uncontrolled data in path expression vulnerabilities.
 */
abstract class Sanitizer extends DataFlow::ExprNode { }

/**
 * A taint-tracking configuration for uncontrolled data in path expression vulnerabilities.
 */
private module TaintedWebClientConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) { source instanceof Source }

  predicate isSink(DataFlow::Node sink) { sink instanceof Sink }

  predicate isBarrier(DataFlow::Node node) { node instanceof Sanitizer }
}

/**
 * A taint-tracking module for uncontrolled data in path expression vulnerabilities.
 */
module TaintedWebClient = TaintTracking::Global<TaintedWebClientConfig>;

/**
 * DEPRECATED: Use `ThreatModelSource` instead.
 *
 * A source of remote user input.
 */
deprecated class RemoteSource extends DataFlow::Node instanceof RemoteFlowSource { }

/** A source supported by the current threat model. */
class ThreatModelSource extends Source instanceof ActiveThreatModelSource { }

/**
 * A path argument to a `WebClient` method call that has an address argument.
 */
class WebClientSink extends Sink {
  WebClientSink() {
    exists(Method m | m = any(SystemNetWebClientClass f).getAMethod() |
      this.getExpr() = m.getACall().getArgumentForName("address")
    )
  }
}

/**
 * A call to `System.Uri.IsWellFormedUriString` that is considered to sanitize the input.
 */
class RequestMapPathSanitizer extends Sanitizer {
  RequestMapPathSanitizer() {
    exists(Method m | m = any(SystemUriClassExtra uri).getIsWellFormedUriStringMethod() |
      this.getExpr() = m.getACall().getArgument(0)
    )
  }
}

private class SimpleTypeSanitizer extends Sanitizer, SimpleTypeSanitizedExpr { }

private class GuidSanitizer extends Sanitizer, GuidSanitizedExpr { }
