/**
 * @name System prompt injection
 * @description Untrusted input flowing into the system prompt of an AI model
 *              may allow an attacker to manipulate the model's behavior.
 * @kind path-problem
 * @problem.severity error
 * @security-severity 7.8
 * @precision high
 * @id go/system-prompt-injection
 * @tags security
 *       experimental
 *       external/cwe/cwe-1427
 */

import go
import semmle.go.security.FlowSources
import SystemPromptInjectionFlow::PathGraph

/**
 * Holds if `sink` is the value written to the `Content` field of a LangChainGo
 * `SystemChatMessage`, i.e. the textual content of a system prompt.
 *
 * The write is matched by the named type of the value being initialized rather
 * than by the field alone: `SystemChatMessage` and the other message types (such
 * as `HumanChatMessage`) share an identical `struct { Content string }` layout,
 * so their `Content` fields are indistinguishable at the field level. Only the
 * system-role message type is treated as a sink, which keeps the query focused
 * on values that end up as instructions to the model.
 */
predicate isSystemPromptSink(DataFlow::Node sink) {
  exists(DataFlow::Write w, Field f, DataFlow::Node base |
    f.getName() = "Content" and
    w.writesField(base, f, sink) and
    base.getType().hasQualifiedName("github.com/tmc/langchaingo/llms", "SystemChatMessage")
  )
}

/**
 * A taint-tracking configuration for untrusted data reaching an AI system prompt.
 */
module SystemPromptInjectionConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) { source instanceof ActiveThreatModelSource }

  predicate isSink(DataFlow::Node sink) { isSystemPromptSink(sink) }
}

/** Taint-tracking flow for untrusted data reaching an AI system prompt. */
module SystemPromptInjectionFlow = TaintTracking::Global<SystemPromptInjectionConfig>;

from SystemPromptInjectionFlow::PathNode source, SystemPromptInjectionFlow::PathNode sink
where SystemPromptInjectionFlow::flowPath(source, sink)
select sink.getNode(), source, sink, "This system prompt depends on a $@.", source.getNode(),
  "user-provided value"
