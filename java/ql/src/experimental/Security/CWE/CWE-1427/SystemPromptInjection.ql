/**
 * @name System prompt injection
 * @description Untrusted input flowing into the system prompt of an AI model
 *              may allow an attacker to manipulate the model's behavior.
 * @kind path-problem
 * @problem.severity error
 * @security-severity 7.8
 * @precision high
 * @id java/system-prompt-injection
 * @tags security
 *       experimental
 *       external/cwe/cwe-1427
 */

import java
import semmle.code.java.dataflow.TaintTracking
import semmle.code.java.dataflow.FlowSources
import SystemPromptInjectionFlow::PathGraph

/** The LangChain4j class `dev.langchain4j.data.message.SystemMessage`. */
class LangChain4jSystemMessage extends RefType {
  LangChain4jSystemMessage() {
    this.hasQualifiedName("dev.langchain4j.data.message", "SystemMessage")
  }
}

/**
 * A data flow sink corresponding to the textual content of a system prompt
 * constructed via the LangChain4j `SystemMessage` API.
 *
 * Only the `String` content is treated as a sink, which keeps the query
 * focused on values that end up as instructions to the model.
 */
class SystemPromptSink extends DataFlow::Node {
  SystemPromptSink() {
    exists(MethodCall ma |
      ma.getMethod().getDeclaringType() instanceof LangChain4jSystemMessage and
      ma.getMethod().hasName(["from", "systemMessage"]) and
      this.asExpr() = ma.getArgument(0) and
      this.asExpr().getType() instanceof TypeString
    )
    or
    exists(ClassInstanceExpr cie |
      cie.getConstructedType() instanceof LangChain4jSystemMessage and
      this.asExpr() = cie.getArgument(0) and
      this.asExpr().getType() instanceof TypeString
    )
  }
}

/**
 * A taint-tracking configuration for untrusted data reaching an AI system prompt.
 */
module SystemPromptInjectionConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) { source instanceof ActiveThreatModelSource }

  predicate isSink(DataFlow::Node sink) { sink instanceof SystemPromptSink }
}

/** Taint-tracking flow for untrusted data reaching an AI system prompt. */
module SystemPromptInjectionFlow = TaintTracking::Global<SystemPromptInjectionConfig>;

deprecated query predicate problems(
  DataFlow::Node sinkNode, SystemPromptInjectionFlow::PathNode source,
  SystemPromptInjectionFlow::PathNode sink, string message1, DataFlow::Node sourceNode,
  string message2
) {
  SystemPromptInjectionFlow::flowPath(source, sink) and
  sinkNode = sink.getNode() and
  message1 = "This system prompt depends on a $@." and
  sourceNode = source.getNode() and
  message2 = "user-provided value"
}
