/**
 * @name Unpinned Azure Pipelines template repository
 * @description Loading pipeline templates from a mutable repository revision lets
 *              changes to that revision change the pipeline's executable configuration.
 * @kind problem
 * @problem.severity warning
 * @security-severity 8.1
 * @precision high
 * @id ado/unpinned-template-repository
 * @tags security
 *       external/cwe/cwe-829
 */

import iac
import codeql.iac.azure.Templates

private predicate hasConstrainedCommitParameter(AzurePipelines::RepositoryResource repository) {
  exists(AzurePipelines::Parameter parameter, string name |
    name =
      repository
          .lookup("ref")
          .(YamlString)
          .getValue()
          .regexpCapture("\\$\\{\\{\\s*parameters\\.([A-Za-z_][A-Za-z0-9_]*)\\s*\\}\\}", 1) and
    parameter = repository.getEnclosingDocument().getAParameter() and
    parameter.lookup("name").(YamlString).getValue() = name and
    exists(parameter.getAnAllowedValue()) and
    forall(YamlValue value | value = parameter.getAnAllowedValue() |
      value.(YamlString).getValue().regexpMatch("[0-9a-fA-F]{40}")
    ) and
    (
      not exists(parameter.getDefault())
      or
      parameter.getDefault().(YamlString).getValue().regexpMatch("[0-9a-fA-F]{40}")
    )
  )
}

from AzurePipelines::RepositoryResource repository, string alias, string source, string revision
where
  YamlDocumentClassification::isSupportedYamlDocument(repository.getEnclosingDocument(),
    "ado-pipeline") and
  alias = repository.lookup("repository").(YamlString).getValue() and
  source = repository.lookup("name").(YamlString).getValue() and
  not alias = ["self", ""] and
  not hasConstrainedCommitParameter(repository) and
  exists(AzurePipelineTemplates::Reference reference |
    AzurePipelineTemplates::reaches(repository.getEnclosingDocument(),
      reference.getEnclosingDocument()) and
    YamlDocumentClassification::isSupportedYamlDocument(reference.getEnclosingDocument(),
      "ado-pipeline") and
    reference.getRepositoryAlias() = alias
  ) and
  (
    not exists(repository.lookup("ref")) and revision = "(omitted; defaults to refs/heads/main)"
    or
    revision = repository.lookup("ref").(YamlScalar).getValue() and
    not revision.regexpMatch("[0-9a-fA-F]{40}")
  )
select repository,
  "Template repository '" + alias + "' (" + source + ") uses revision '" + revision +
    "' that is not proven to be an immutable commit SHA."
