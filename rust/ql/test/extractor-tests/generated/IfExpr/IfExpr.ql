// generated by codegen, do not edit
import codeql.rust.elements
import TestUtils

from IfExpr x, int getNumberOfAttrs, string hasCondition, string hasElse, string hasThen
where
  toBeTested(x) and
  not x.isUnknown() and
  getNumberOfAttrs = x.getNumberOfAttrs() and
  (if x.hasCondition() then hasCondition = "yes" else hasCondition = "no") and
  (if x.hasElse() then hasElse = "yes" else hasElse = "no") and
  if x.hasThen() then hasThen = "yes" else hasThen = "no"
select x, "getNumberOfAttrs:", getNumberOfAttrs, "hasCondition:", hasCondition, "hasElse:", hasElse,
  "hasThen:", hasThen
