/**
 * @name Pull request code executes on a private Azure Pipelines agent
 * @description A PR-enabled pipeline that executes code on a private agent pool
 *              can expose persistent agent state to pull request contributors.
 * @kind problem
 * @problem.severity warning
 * @security-severity 8.8
 * @precision high
 * @id ado/untrusted-code-on-self-hosted-agent
 * @tags security
 *       external/cwe/cwe-829
 */

import iac
import codeql.iac.azure.Agents
import codeql.iac.azure.Execution

from AzurePipelines::Step step, YamlValue pool
where
  YamlDocumentClassification::isSupportedYamlDocument(step.getEnclosingDocument(), "ado-pipeline") and
  AzurePipelineAgents::hasExplicitPrEvidence(step) and
  AzurePipelineExecution::isExecutionStep(step) and
  not AzurePipelineAgents::hasKnownNonPrGuard(step) and
  pool = AzurePipelineAgents::getEffectivePool(step) and
  AzurePipelineAgents::isPrivatePool(pool)
select step,
  "This explicit PR execution path runs code on a private agent pool. Pull request contributors may influence code running with the agent's persistent state."
