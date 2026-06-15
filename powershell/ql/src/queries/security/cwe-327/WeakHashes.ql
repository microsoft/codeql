/**
 * @name Use of weak cryptographic hash
 * @description Using weak cryptographic hash algorithms like MD5 or SHA1 can compromise data integrity and security.
 * @kind problem
 * @problem.severity warning
 * @security-severity 7.5
 * @precision high
 * @id powershell/weak-hash
 * @tags security
 *       external/cwe/cwe-327
 *       external/cwe/cwe-328
 */

import powershell
import semmle.code.powershell.ApiGraphs
import semmle.code.powershell.dataflow.DataFlow
import semmle.code.powershell.security.cryptography.Concepts

bindingset[s]
private predicate securitySensitiveTerm(string s) {
  s.matches("%integrity%") or
  s.matches("%authentic%") or
  s.matches("%verify%") or
  s.matches("%validat%") or
  s.matches("%checksum%") or
  s.matches("%expected%") or
  s.matches("%trusted%") or
  s.matches("%manifest%") or
  s.matches("%signature%") or
  s.matches("%tamper%") or
  s.matches("%package%") or
  s.matches("%update%") or
  s.matches("%release%") or
  s.matches("%download%") or
  s.matches("%installer%") or
  s.matches("%artifact%") or
  s.matches("%sbom%") or
  s.matches("%attestation%")
}

bindingset[s]
private predicate nonSecurityTerm(string s) {
  s.matches("%cache%") or
  s.matches("%dedup%") or
  s.matches("%duplicat%") or
  s.matches("%telemetry%") or
  s.matches("%correlation%") or
  s.matches("%random%") or
  s.matches("%bucket%") or
  s.matches("%shard%") or
  s.matches("%partition%") or
  s.matches("%sample%") or
  s.matches("%rollout%") or
  s.matches("%experiment%")
}

private predicate hasSecuritySensitiveName(Ast root) {
  exists(Variable v | v.getAnAccess() = root.getAChild*() |
    securitySensitiveTerm(v.getLowerCaseName())
  )
  or
  exists(StringConstExpr s | s = root.getAChild*() |
    securitySensitiveTerm(s.getValueString().toLowerCase())
  )
  or
  exists(CallExpr c | c = root.getAChild*() | securitySensitiveTerm(c.getLowerCaseName()))
}

private predicate hasNonSecurityName(Ast root) {
  exists(Variable v | v.getAnAccess() = root.getAChild*() | nonSecurityTerm(v.getLowerCaseName()))
  or
  exists(StringConstExpr s | s = root.getAChild*() |
    nonSecurityTerm(s.getValueString().toLowerCase())
  )
  or
  exists(CallExpr c | c = root.getAChild*() | nonSecurityTerm(c.getLowerCaseName()))
}

private predicate nearestEnclosingStmt(Expr e, Stmt stmt) {
  stmt = e.getParent*() and
  not exists(Stmt inner |
    inner = e.getParent*() and
    inner != stmt and
    stmt = inner.getParent+()
  )
}

private predicate hasSecuritySensitiveContext(Expr e) {
  hasSecuritySensitiveName(e) or
  exists(Stmt stmt | nearestEnclosingStmt(e, stmt) | hasSecuritySensitiveName(stmt))
}

private predicate hasNonSecurityContext(Expr e) {
  hasNonSecurityName(e) or
  exists(Stmt stmt | nearestEnclosingStmt(e, stmt) | hasNonSecurityName(stmt))
}

private predicate isHashComparison(DataFlow::Node hashValue) {
  exists(DataFlow::Node use, ComparisonExpr cmp |
    hashValue.getALocalSource().flowsTo(use) and
    use.asExpr().getExpr() = cmp.getAChild*()
  )
}

private predicate isSecuritySensitiveHashUse(HashAlgorithm hashAlg) {
  hasSecuritySensitiveContext(hashAlg.asExpr().getExpr())
  or
  isHashComparison(hashAlg)
  or
  exists(DataFlow::CallNode computeHash |
    hashAlg.getALocalSource().getAMethodCall("computehash") = computeHash and
    (
      hasSecuritySensitiveContext(computeHash.asExpr().getExpr()) or
      isHashComparison(computeHash)
    )
  )
}

private predicate isObviousNonSecurityHashUse(HashAlgorithm hashAlg) {
  (
    hashAlg instanceof GetFileHashWeakAlgorithm and
    hasNonSecurityContext(hashAlg.asExpr().getExpr())
    or
    exists(DataFlow::CallNode computeHash |
      hashAlg.getALocalSource().getAMethodCall("computehash") = computeHash and
      hasNonSecurityContext(computeHash.asExpr().getExpr())
    )
    or
    hasNonSecurityContext(hashAlg.asExpr().getExpr())
  ) and
  not isSecuritySensitiveHashUse(hashAlg)
}

from HashAlgorithm hashAlg
where
  not hashAlg.getHashName() = ["sha256", "sha384", "sha512"] and
  not isObviousNonSecurityHashUse(hashAlg)
select hashAlg, "Use of weak cryptographic hash algorithm: " + hashAlg.getHashName() + "."
