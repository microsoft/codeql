/**
 * @name Azure Pipelines system access token exposed to executable code
 * @description Passing the job access token to scripts, command arguments, or
 *              artifact publication inputs makes it available beyond checkout.
 * @kind problem
 * @problem.severity warning
 * @security-severity 8.1
 * @precision high
 * @id ado/system-access-token-exposure
 * @tags security
 *       external/cwe/cwe-522
 */

import iac
import codeql.iac.azure.Execution

from AzurePipelines::Step step, YamlString sink, string kind
where
  YamlDocumentClassification::isSupportedYamlDocument(step.getEnclosingDocument(), "ado-pipeline") and
  AzurePipelineExecution::directTokenSink(step, sink, kind) and
  AzurePipelineExecution::containsSystemAccessToken(sink)
select sink,
  "System.AccessToken is passed directly to " + kind +
    ". The receiving code can use the token even when logs mask its value."
