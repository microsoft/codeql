// generated by codegen, do not edit
import codeql.rust.elements
import TestUtils

from
  ClosureExpr x, string hasParamList, int getNumberOfAttrs, int getNumberOfParams, string hasBody,
  string hasClosureBinder, string isAsync, string isConst, string isGen, string isMove,
  string isStatic, string hasRetType
where
  toBeTested(x) and
  not x.isUnknown() and
  (if x.hasParamList() then hasParamList = "yes" else hasParamList = "no") and
  getNumberOfAttrs = x.getNumberOfAttrs() and
  getNumberOfParams = x.getNumberOfParams() and
  (if x.hasBody() then hasBody = "yes" else hasBody = "no") and
  (if x.hasClosureBinder() then hasClosureBinder = "yes" else hasClosureBinder = "no") and
  (if x.isAsync() then isAsync = "yes" else isAsync = "no") and
  (if x.isConst() then isConst = "yes" else isConst = "no") and
  (if x.isGen() then isGen = "yes" else isGen = "no") and
  (if x.isMove() then isMove = "yes" else isMove = "no") and
  (if x.isStatic() then isStatic = "yes" else isStatic = "no") and
  if x.hasRetType() then hasRetType = "yes" else hasRetType = "no"
select x, "hasParamList:", hasParamList, "getNumberOfAttrs:", getNumberOfAttrs,
  "getNumberOfParams:", getNumberOfParams, "hasBody:", hasBody, "hasClosureBinder:",
  hasClosureBinder, "isAsync:", isAsync, "isConst:", isConst, "isGen:", isGen, "isMove:", isMove,
  "isStatic:", isStatic, "hasRetType:", hasRetType
