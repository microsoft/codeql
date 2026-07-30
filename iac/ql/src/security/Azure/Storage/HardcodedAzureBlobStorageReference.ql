/**
 * @name Hardcoded Azure Blob Storage endpoint in IaC configuration
 * @description A hardcoded reference to an Azure Blob Storage endpoint (*.blob.core.windows.net)
 *              in an IaC file (Terraform/HCL, ARM templates, CloudFormation, Helm charts, etc.)
 *              may indicate a dangling storage account that could be hijacked by an attacker
 *              for supply chain attacks, data exfiltration, or code execution.
 * @kind problem
 * @problem.severity warning
 * @security-severity 7.5
 * @precision high
 * @id iac/azure/hardcoded-blob-storage-reference
 * @tags security
 *       azure
 *       storage
 */

import iac

bindingset[s]
predicate isAzureBlobStorageUrl(string s) {
  s.toLowerCase().regexpMatch(".*[a-z0-9]+\\.blob\\.core\\.windows\\.net.*")
}

private newtype TBlobStorageReference =
  THclStringLiteral(StringLiteral s) { isAzureBlobStorageUrl(s.getValue()) } or
  TYamlScalar(YamlScalar y) { isAzureBlobStorageUrl(y.getValue()) }

/**
 * A hardcoded reference to an Azure Blob Storage endpoint, either in an HCL/Terraform
 * string literal or in a YAML/JSON scalar (ARM templates, CloudFormation, Helm charts, etc.).
 */
class BlobStorageReference extends TBlobStorageReference {
  /** Gets the referenced Azure Blob Storage endpoint value. */
  string getValue() {
    exists(StringLiteral s | this = THclStringLiteral(s) | result = s.getValue())
    or
    exists(YamlScalar y | this = TYamlScalar(y) | result = y.getValue())
  }

  /** Gets a textual representation of this reference. */
  string toString() { result = this.getValue() }

  /** Holds if this reference is at the specified location. */
  predicate hasLocationInfo(
    string filepath, int startline, int startcolumn, int endline, int endcolumn
  ) {
    exists(StringLiteral s | this = THclStringLiteral(s) |
      s.getLocation().hasLocationInfo(filepath, startline, startcolumn, endline, endcolumn)
    )
    or
    exists(YamlScalar y | this = TYamlScalar(y) |
      y.getLocation().hasLocationInfo(filepath, startline, startcolumn, endline, endcolumn)
    )
  }
}

from BlobStorageReference ref
select ref,
  "Hardcoded reference to Azure Blob Storage endpoint '" + ref.getValue() +
    "' may indicate a dangling storage account."
