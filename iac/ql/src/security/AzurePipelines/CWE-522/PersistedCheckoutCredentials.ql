/**
 * @name Persisted checkout credentials in Azure DevOps pipeline
 * @description Persisting checkout credentials makes the repository's authentication
 *              token available to subsequent steps in the job.
 * @kind problem
 * @problem.severity warning
 * @security-severity 6.5
 * @precision high
 * @id ado/persisted-checkout-credentials
 * @tags security
 *       external/cwe/cwe-522
 */

import iac

from AzurePipelines::Checkout checkout, string repository
where
  YamlDocumentClassification::isSupportedYamlDocument(checkout.getEnclosingDocument(),
    "ado-pipeline") and
  checkout.persistsCredentials() and
  repository = checkout.lookup("checkout").(YamlString).getValue() and
  not repository = ["none", ""] and
  not repository.matches("%$(%") and
  not repository.matches("%${{%") and
  not repository.matches("%$[%")
select checkout.getPersistCredentials(),
  "Checkout of '" + repository +
    "' persists authentication credentials in Git configuration, making them available to subsequent steps."
