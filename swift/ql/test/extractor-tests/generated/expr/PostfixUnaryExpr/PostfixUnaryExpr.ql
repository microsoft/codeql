// generated by codegen/codegen.py, do not edit
import codeql.swift.elements
import TestUtils

from PostfixUnaryExpr x, string hasType, Expr getFunction, int getNumberOfArguments
where
  toBeTested(x) and
  not x.isUnknown() and
  (if x.hasType() then hasType = "yes" else hasType = "no") and
  getFunction = x.getFunction() and
  getNumberOfArguments = x.getNumberOfArguments()
select x, "hasType:", hasType, "getFunction:", getFunction, "getNumberOfArguments:",
  getNumberOfArguments
