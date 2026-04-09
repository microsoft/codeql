/**
 * @name Use of insecure random number generator
 * @description Using non-cryptographic random number generators such as Get-Random or System.Random
 *              for security-sensitive operations can compromise security.
 * @kind problem
 * @problem.severity error
 * @security-severity 7.5
 * @precision high
 * @id powershell/microsoft/security/insecure-random
 * @tags security
 *       external/cwe/cwe-330
 *       external/cwe/cwe-338
 */

import powershell
import semmle.code.powershell.ApiGraphs
import semmle.code.powershell.dataflow.DataFlow

/** A call to the `Get-Random` cmdlet. */
class GetRandomCall extends DataFlow::CallNode {
  GetRandomCall() { this.matchesName("Get-Random") }
}

/** An instantiation of `System.Random` via `New-Object`. */
class SystemRandomObjectCreation extends DataFlow::ObjectCreationNode {
  SystemRandomObjectCreation() {
    this.asExpr()
        .getExpr()
        .(ObjectCreation)
        .getAnArgument()
        .getValue()
        .stringMatches("System.Random")
  }
}

/** A call to `[System.Random]::new()` via the API graph. */
class SystemRandomNewCall extends DataFlow::CallNode {
  SystemRandomNewCall() {
    this = API::getTopLevelMember("system").getMember("random").getMember("new").asCall()
  }
}

from DataFlow::Node node, string msg
where
  node instanceof GetRandomCall and
  msg =
    "Use of insecure random number generator 'Get-Random'. Use [System.Security.Cryptography.RandomNumberGenerator] instead."
  or
  node instanceof SystemRandomObjectCreation and
  msg =
    "Use of insecure random number generator 'System.Random'. Use [System.Security.Cryptography.RandomNumberGenerator] instead."
  or
  node instanceof SystemRandomNewCall and
  msg =
    "Use of insecure random number generator 'System.Random'. Use [System.Security.Cryptography.RandomNumberGenerator] instead."
select node, msg
