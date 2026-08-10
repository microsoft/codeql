/**
 * @name System prompt injection
 * @description Untrusted input flowing into the system prompt of an AI model
 *              may allow an attacker to manipulate the model's behavior.
 * @kind path-problem
 * @problem.severity error
 * @security-severity 7.8
 * @precision high
 * @id cs/system-prompt-injection
 * @tags security
 *       experimental
 *       external/cwe/cwe-1427
 */

import csharp
import semmle.code.csharp.security.dataflow.flowsources.FlowSources
import SystemPromptInjection::PathGraph

/**
 * A data flow sink corresponding to the textual content of a system prompt
 * constructed via the OpenAI .NET SDK.
 *
 * Only the `string` content of a system-role message is treated as a sink, which
 * keeps the query focused on values that end up as instructions to the model.
 */
predicate isSystemPromptSink(DataFlow::Node sink) {
  exists(ObjectCreation oc |
    oc.getType().hasFullyQualifiedName("OpenAI.Chat", "SystemChatMessage") and
    sink.asExpr() = oc.getArgument(0) and
    oc.getArgument(0).getType() instanceof StringType
  )
  or
  exists(MethodCall mc |
    mc.getTarget().hasName("CreateSystemMessage") and
    mc.getTarget().getDeclaringType().hasFullyQualifiedName("OpenAI.Chat", "ChatMessage") and
    sink.asExpr() = mc.getArgument(0) and
    mc.getArgument(0).getType() instanceof StringType
  )
}

/**
 * A taint-tracking configuration for untrusted data reaching an AI system prompt.
 */
module SystemPromptInjectionConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) { source instanceof ActiveThreatModelSource }

  predicate isSink(DataFlow::Node sink) { isSystemPromptSink(sink) }

  predicate observeDiffInformedIncrementalMode() { any() }
}

/** Taint-tracking flow for untrusted data reaching an AI system prompt. */
module SystemPromptInjection = TaintTracking::Global<SystemPromptInjectionConfig>;

from SystemPromptInjection::PathNode source, SystemPromptInjection::PathNode sink
where SystemPromptInjection::flowPath(source, sink)
select sink.getNode(), source, sink, "This system prompt depends on a $@.", source,
  "user-provided value"
