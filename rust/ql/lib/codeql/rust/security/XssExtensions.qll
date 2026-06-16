/**
 * Provides classes and predicates for reasoning about cross-site scripting (XSS)
 * vulnerabilities.
 */

import rust
private import codeql.rust.dataflow.DataFlow
private import codeql.rust.dataflow.FlowBarrier
private import codeql.rust.dataflow.FlowSink
private import codeql.rust.Concepts
private import codeql.util.Unit
private import codeql.rust.security.Barriers as Barriers

/**
 * Provides default sources, sinks and barriers for detecting XSS
 * vulnerabilities, as well as extension points for adding your own.
 */
module Xss {
  /**
   * A data flow source for XSS vulnerabilities.
   */
  abstract class Source extends DataFlow::Node { }

  /**
   * A data flow sink for XSS vulnerabilities.
   */
  abstract class Sink extends QuerySink::Range {
    override string getSinkType() { result = "Xss" }
  }

  /**
   * A barrier for XSS vulnerabilities.
   */
  abstract class Barrier extends DataFlow::Node { }

  /**
   * An active threat-model source, considered as a flow source.
   *
   * Environment variables are excluded: they hold trusted deployment
   * configuration (for example the service's own hostname or public base URL,
   * set from an environment variable at startup) rather than per-request,
   * attacker-controlled input, so they are not a meaningful source for XSS.
   */
  private class ActiveThreatModelSourceAsSource extends Source, ActiveThreatModelSource {
    ActiveThreatModelSourceAsSource() { not this.getThreatModel() = "environment" }
  }

  /**
   * A sink for XSS from model data.
   */
  private class ModelsAsDataSink extends Sink {
    ModelsAsDataSink() { sinkNode(this, "html-injection") }
  }

  /**
   * A barrier for XSS from model data.
   */
  private class ModelsAsDataBarrier extends Barrier {
    ModelsAsDataBarrier() { barrierNode(this, "html-injection") }
  }

  /**
   * A barrier for XSS vulnerabilities for nodes whose type is a
   * numeric or boolean type, which is unlikely to expose any vulnerability.
   */
  private class NumericTypeBarrier extends Barrier instanceof Barriers::NumericTypeBarrier { }

  /** A call to a function with "escape" or "encode" in its name. */
  private class HeuristicHtmlEncodingBarrier extends Barrier {
    HeuristicHtmlEncodingBarrier() {
      exists(Call c |
        c.getStaticTarget().getName().getText().regexpMatch(".*(escape|encode).*") and
        c.getAnArgument() = this.asExpr()
      )
    }
  }

  // TODO: Convert this to MaD once MaD supports sink for tuple struct expressions.
  private class AxumHtmlSink extends Sink {
    AxumHtmlSink() {
      exists(TupleStructExpr call |
        call.getResolvedTarget().getCanonicalPath() = "axum::response::Html" and
        this.asExpr() = call.getSyntacticPositionalArgument(0)
      )
    }
  }
}
