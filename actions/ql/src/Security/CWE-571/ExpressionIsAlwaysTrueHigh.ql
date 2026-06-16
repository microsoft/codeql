/**
 * @name If expression always true
 * @description Expressions used in If conditions with extra spaces are always true.
 * @kind problem
 * @problem.severity error
 * @precision high
 * @security-severity 7.5
 * @id actions/if-expression-always-true/high
 * @tags actions
 *       maintainability
 *       external/cwe/cwe-275
 */

import actions
import codeql.actions.security.ControlChecks

from If i
where
  not i instanceof ControlCheck and
  // exclude escaped template expressions ($${{ }}) used in composite actions/templates
  not i.getCondition().matches("%$${{%") and
  exists(string cond | cond = i.getCondition().trim() |
    cond.matches("%${{%") and
    (
      not cond.matches("${{%") or
      not cond.matches("%}}")
    )
    or
    count(cond.splitAt("${{")) > 2
  )
select i, "Expression always evaluates to true"
