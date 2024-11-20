/**
 * @name Uncontrolled command line
 * @description Using externally controlled strings in a command line may allow a malicious
 *              user to change the meaning of the command.
 * @kind path-problem
 * @problem.severity error
 * @security-severity 9.8
 * @precision high
 * @id powershell/command-injection-test
 * @tags correctness
 *       security
 *       external/cwe/cwe-078
 *       external/cwe/cwe-088
 */

import powershell
import semmle.code.powershell.security.CommandInjectionQuery
import CommandInjectionFlow::PathGraph

from CommandInjetionFlow::PathNode source, CommandInjectionFlow::PathNode sink, Source sourceNode
where
  CommandInjectionFlow::flowPath(source, sink) and
  sourceNode = source.getNode()
select sink.getNode(), source, sink, "This command depends on a $@.", sourceNode,
  sourceNode.getSourceType()
