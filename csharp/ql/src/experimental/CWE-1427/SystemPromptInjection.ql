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
 * Gets the expression that selects a system-message branch containing `sinkExpr`.
 */
private Expr getSystemRoleSelector(Expr sinkExpr) {
  exists(SwitchExpr switchExpr, SwitchCaseExpr switchCase, StringLiteral systemPattern |
    switchCase = switchExpr.getACase() and
    switchCase.getBody().getAChild*() = sinkExpr and
    switchCase.getPattern().getAChild*() = systemPattern and
    systemPattern.getValue().toLowerCase() = "system" and
    result = switchExpr.getExpr()
  )
  or
  exists(IfStmt ifStmt, MethodCall roleCheck, StringLiteral systemArgument |
    sinkExpr.getEnclosingStmt().getParent*() = ifStmt.getThen() and
    ifStmt.getCondition().getAChild*() = roleCheck and
    roleCheck.getTarget().getName().matches(["Equals", "OrdinalEquals"]) and
    roleCheck.getArgument(0) = systemArgument and
    systemArgument.getValue().toLowerCase() = "system" and
    result = roleCheck.getQualifier()
  )
  or
  exists(IfStmt ifStmt, EQExpr roleCheck, StringLiteral systemOperand |
    sinkExpr.getEnclosingStmt().getParent*() = ifStmt.getThen() and
    ifStmt.getCondition().getAChild*() = roleCheck and
    roleCheck.getAnOperand() = systemOperand and
    systemOperand.getValue().toLowerCase() = "system" and
    result = roleCheck.getAnOperand() and
    result != systemOperand
  )
}

/**
 * Tracks untrusted input to expressions that select a system-message branch.
 */
module SystemRoleConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) { source instanceof ActiveThreatModelSource }

  predicate isSink(DataFlow::Node sink) {
    exists(Expr sinkExpr | sink = DataFlow::exprNode(getSystemRoleSelector(sinkExpr)))
  }
}

module SystemRole = TaintTracking::Global<SystemRoleConfig>;

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
    oc.getArgument(0).getType() instanceof StringType and
    (
      not exists(getSystemRoleSelector(oc))
      or
      SystemRole::flowTo(DataFlow::exprNode(getSystemRoleSelector(oc)))
    )
  )
  or
  exists(MethodCall mc |
    mc.getTarget().hasName("CreateSystemMessage") and
    mc.getTarget().getDeclaringType().hasFullyQualifiedName("OpenAI.Chat", "ChatMessage") and
    sink.asExpr() = mc.getArgument(0) and
    mc.getArgument(0).getType() instanceof StringType and
    (
      not exists(getSystemRoleSelector(mc))
      or
      SystemRole::flowTo(DataFlow::exprNode(getSystemRoleSelector(mc)))
    )
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
