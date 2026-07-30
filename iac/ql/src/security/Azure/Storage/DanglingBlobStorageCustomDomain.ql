/**
 * @name Custom domain pointing to Azure Blob Storage endpoint
 * @description A custom domain configuration pointing to a blob.core.windows.net endpoint
 *              may reference a dangling DNS record if the underlying storage account is
 *              deleted but the domain record persists, enabling subdomain takeover attacks.
 * @kind problem
 * @problem.severity warning
 * @security-severity 7.5
 * @precision high
 * @id iac/azure/dangling-blob-storage-custom-domain
 * @tags security
 *       azure
 *       storage
 */

import iac

bindingset[s]
predicate isAzureBlobStorageUrl(string s) {
  s.toLowerCase().regexpMatch(".*[a-z0-9]+\\.blob\\.core\\.windows\\.net.*")
}

from StringLiteral s, Block customDomain
where
  customDomain.hasType("custom_domain") and
  s.getParent+() = customDomain and
  isAzureBlobStorageUrl(s.getValue())
select s,
  "Custom domain value '" + s.getValue() +
    "' points to a blob.core.windows.net endpoint and may be vulnerable to subdomain takeover."
