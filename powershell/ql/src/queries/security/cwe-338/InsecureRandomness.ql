/**
 * @name Use of insecure random number generator in security-sensitive context
 * @description Using non-cryptographic random number generators such as Get-Random or System.Random
 *              for security-sensitive operations can compromise security.
 * @kind path-problem
 * @problem.severity error
 * @security-severity 7.5
 * @precision high
 * @id powershell/insecure-randomness
 * @tags security
 *       external/cwe/cwe-330
 *       external/cwe/cwe-338
 */

import powershell
import semmle.code.powershell.security.InsecureRandomnessQuery
import InsecureRandomnessFlow::PathGraph

from InsecureRandomnessFlow::PathNode source, InsecureRandomnessFlow::PathNode sink
where InsecureRandomnessFlow::flowPath(source, sink)
select sink.getNode(), source, sink,
  "Insecure random value flows to " + sink.getNode().(Sink).getSinkDescription() + " from $@.",
  source.getNode(), "this insecure random source"
