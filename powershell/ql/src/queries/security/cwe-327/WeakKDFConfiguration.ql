/**
 * @name Weak key derivation function configuration
 * @description Rfc2898DeriveBytes (PBKDF2) should use at least 100,000 iterations
 *              and a hash algorithm of SHA-256 or stronger to resist brute-force attacks.
 * @kind problem
 * @problem.severity error
 * @security-severity 7.5
 * @precision high
 * @id powershell/weak-kdf-configuration
 * @tags security
 *       external/cwe/cwe-327
 *       external/cwe/cwe-328
 *       cryptography
 */

import powershell
import semmle.code.powershell.ApiGraphs
import semmle.code.powershell.dataflow.DataFlow

private int minIterationCount() { result = 100000 }

/**
 * An instantiation of Rfc2898DeriveBytes via New-Object or [Type]::new().
 */
class Rfc2898DeriveBytesCreation extends DataFlow::CallNode {
  Rfc2898DeriveBytesCreation() {
    this =
      API::getTopLevelMember("system")
          .getMember("security")
          .getMember("cryptography")
          .getMember("rfc2898derivebytes")
          .getMember("new")
          .asCall()
    or
    // New-Object pattern
    exists(DataFlow::ObjectCreationNode oc |
      oc = this and
      oc.getExprNode().getExpr().(CallExpr).getAnArgument().getValue().asString().toLowerCase() =
        [
          "system.security.cryptography.rfc2898derivebytes",
          "rfc2898derivebytes"
        ]
    )
  }

  /** Gets the iteration count argument (position 2, 0-indexed), if any. */
  DataFlow::Node getIterationCountArg() { result = this.getPositionalArgument(2) }

  /** Gets the hash algorithm argument (position 3, 0-indexed), if any. */
  DataFlow::Node getHashAlgorithmArg() { result = this.getPositionalArgument(3) }

  /** Holds if the constructor has an explicit iteration count argument. */
  predicate hasIterationCountArg() { exists(this.getIterationCountArg()) }

  /** Holds if the constructor has an explicit hash algorithm argument. */
  predicate hasHashAlgorithmArg() { exists(this.getHashAlgorithmArg()) }
}

/**
 * A call to the static Rfc2898DeriveBytes.Pbkdf2 method (.NET 6+).
 */
class Pbkdf2StaticCall extends DataFlow::CallNode {
  Pbkdf2StaticCall() {
    this =
      API::getTopLevelMember("system")
          .getMember("security")
          .getMember("cryptography")
          .getMember("rfc2898derivebytes")
          .getMember("pbkdf2")
          .asCall()
  }

  /** Gets the iteration count argument (position 2, 0-indexed). */
  DataFlow::Node getIterationCountArg() { result = this.getPositionalArgument(2) }

  /** Gets the hash algorithm argument (position 3, 0-indexed). */
  DataFlow::Node getHashAlgorithmArg() { result = this.getPositionalArgument(3) }
}

/**
 * Holds if `node` is an integer literal less than the minimum iteration count.
 */
private predicate isLowIterationValue(DataFlow::Node node, int value) {
  value = node.asExpr().getExpr().getValue().asInt() and
  value < minIterationCount()
}

/**
 * Holds if `node` references a weak hash algorithm (MD5 or SHA1).
 */
private predicate isWeakHashAlgorithm(DataFlow::Node node, string name) {
  // [HashAlgorithmName]::MD5 or [HashAlgorithmName]::SHA1
  node =
    API::getTopLevelMember("system")
        .getMember("security")
        .getMember("cryptography")
        .getMember("hashalgorithmname")
        .getMember(name)
        .asSource() and
  name = ["md5", "sha1"]
  or
  // String literal "MD5" or "SHA1"
  exists(string s |
    s = node.asExpr().getExpr().getValue().asString().toLowerCase() and
    s = ["md5", "sha1"] and
    name = s
  )
}

/**
 * Gets a human-readable name for the weak hash algorithm.
 */
private string prettyHashName(string name) {
  name = "md5" and result = "MD5"
  or
  name = "sha1" and result = "SHA1"
}

from DataFlow::CallNode call, string message
where
  // Case 1: Rfc2898DeriveBytes created without specifying iteration count
  call instanceof Rfc2898DeriveBytesCreation and
  not call.(Rfc2898DeriveBytesCreation).hasIterationCountArg() and
  message =
    "Rfc2898DeriveBytes uses default iteration count of 1000. Specify at least " +
      minIterationCount().toString() + " iterations."
  or
  // Case 2: Rfc2898DeriveBytes created with low iteration count
  exists(int value |
    call instanceof Rfc2898DeriveBytesCreation and
    isLowIterationValue(call.(Rfc2898DeriveBytesCreation).getIterationCountArg(), value) and
    message =
      "Rfc2898DeriveBytes uses iteration count of " + value.toString() +
        ", which is below the minimum of " + minIterationCount().toString() + "."
  )
  or
  // Case 3: Rfc2898DeriveBytes created without specifying hash algorithm (defaults to SHA1)
  call instanceof Rfc2898DeriveBytesCreation and
  not call.(Rfc2898DeriveBytesCreation).hasHashAlgorithmArg() and
  message = "Rfc2898DeriveBytes uses the default hash algorithm SHA1. Specify SHA-256 or stronger."
  or
  // Case 4: Rfc2898DeriveBytes created with weak hash algorithm
  exists(string name |
    call instanceof Rfc2898DeriveBytesCreation and
    isWeakHashAlgorithm(call.(Rfc2898DeriveBytesCreation).getHashAlgorithmArg(), name) and
    message =
      "Rfc2898DeriveBytes uses weak hash algorithm " + prettyHashName(name) +
        ". Use SHA-256 or stronger."
  )
  or
  // Case 5: Pbkdf2 static method with low iteration count
  exists(int value |
    call instanceof Pbkdf2StaticCall and
    isLowIterationValue(call.(Pbkdf2StaticCall).getIterationCountArg(), value) and
    message =
      "Rfc2898DeriveBytes.Pbkdf2 uses iteration count of " + value.toString() +
        ", which is below the minimum of " + minIterationCount().toString() + "."
  )
  or
  // Case 6: Pbkdf2 static method with weak hash algorithm
  exists(string name |
    call instanceof Pbkdf2StaticCall and
    isWeakHashAlgorithm(call.(Pbkdf2StaticCall).getHashAlgorithmArg(), name) and
    message =
      "Rfc2898DeriveBytes.Pbkdf2 uses weak hash algorithm " + prettyHashName(name) +
        ". Use SHA-256 or stronger."
  )
select call, message
