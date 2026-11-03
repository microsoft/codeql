/**
 * @name Floating GitHub release download in an Azure DevOps pipeline
 * @description Downloading the latest GitHub release allows the artifact to change without a pipeline change.
 * @kind problem
 * @problem.severity warning
 * @security-severity 7.5
 * @precision medium
 * @id iac/azure-pipelines/floating-github-release-download
 * @tags security
 *       azure-pipelines
 *       external/cwe/cwe-829
 *       experimental
 */

import iac

private YamlString getAnInlineScript(AzurePipelines::Document doc) {
  result = doc.getAScriptStep().getScriptContent()
  or
  exists(AzurePipelines::Task task, YamlMapping inputs |
    task = doc.getATaskStep() and
    inputs = task.lookup("inputs") and
    (
      task.getName().toLowerCase().regexpMatch("(powershell|bash)@[0-9]+") and
      inputs.lookup("targetType").(YamlString).getValue().toLowerCase() = "inline"
      or
      task.getName().toLowerCase().regexpMatch("cmdline@[0-9]+")
    )
  |
    result = inputs.lookup("script")
  )
}

private predicate hasFloatingDownload(YamlString script) {
  exists(string command |
    // Join shell continuations before matching a command and its literal URL.
    command =
      script
          .getValue()
          .regexpReplaceAll("(\\\\|`)[ \\t]*\\r?\\n[ \\t]*", " ")
          .regexpFind("(?im)^[ \\t]*(&[ \\t]+)?" +
              "(curl(\\.exe)?|wget(\\.exe)?|invoke-webrequest|iwr|invoke-restmethod|irm|start-bitstransfer)"
              + "[ \\t]+[^\\r\\n#;|&]*", _, _) and
    exists(
      command
          .regexpFind("[\\s\"'](?i:https://github\\.com)/[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+/releases/latest/download/[^\\s\"'<>|;&)]+",
            _, _)
    )
  )
}

from YamlDocumentClassification::YamlSyntaxDocument doc, YamlString script
where
  YamlDocumentClassification::isSupportedYamlDocument(doc, "ado-pipeline") and
  script = getAnInlineScript(doc.(AzurePipelines::Document)) and
  hasFloatingDownload(script)
select script,
  "This download uses GitHub's floating 'latest' release. Pin the artifact version and enforce integrity verification before use."
