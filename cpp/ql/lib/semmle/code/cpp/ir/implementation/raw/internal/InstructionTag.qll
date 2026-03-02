private import cpp

newtype TInstructionTag =
  OnlyInstructionTag() or // Single instruction (not including implicit Load)
  InitializerVariableAddressTag() or
  InitializerLoadStringTag() or
  InitializerStoreTag() or
  InitializerIndirectAddressTag() or
  InitializerIndirectStoreTag() or
  DynamicInitializationFlagAddressTag() or
  DynamicInitializationFlagLoadTag() or
  DynamicInitializationConditionalBranchTag() or
  DynamicInitializationFlagConstantTag() or
  DynamicInitializationFlagStoreTag() or
  ZeroPadStringConstantTag() or
  ZeroPadStringElementIndexTag() or
  ZeroPadStringElementAddressTag() or
  ZeroPadStringStoreTag() or
  AssignOperationConvertLeftTag() or
  AssignOperationOpTag() or
  AssignOperationConvertResultTag() or
  AssignmentStoreTag() or
  CrementConstantTag() or
  CrementOpTag() or
  CrementStoreTag() or
  EnterFunctionTag() or
  ReturnValueAddressTag() or
  ReturnTag() or
  ExitFunctionTag() or
  AliasedDefinitionTag() or
  InitializeNonLocalTag() or
  AliasedUseTag() or
  SwitchBranchTag() or
  CallTargetTag() or
  CallTag() or
  CallSideEffectTag() or
  CallNoReturnTag() or
  AllocationSizeTag() or
  AllocationElementSizeTag() or
  AllocationExtentConvertTag() or
  ValueConditionCompareTag() or
  ValueConditionConstantTag() or
  ValueConditionConditionalBranchTag() or
  ValueConditionConditionalConstantTag() or
  ValueConditionConditionalCompareTag() or
  ConditionValueTrueTempAddressTag() or
  ConditionValueTrueConstantTag() or
  ConditionValueTrueStoreTag() or
  ConditionValueFalseTempAddressTag() or
  ConditionValueFalseConstantTag() or
  ConditionValueFalseStoreTag() or
  ConditionValueResultTempAddressTag() or
  ConditionValueResultLoadTag() or
  BoolConversionConstantTag() or
  BoolConversionCompareTag() or
  NotExprOperationTag() or
  NotExprConstantTag() or
  ResultCopyTag() or
  LoadTag() or // Implicit load due to lvalue-to-rvalue conversion
  CatchTag() or
  ThrowTag() or
  UnwindTag() or
  InitializerUninitializedTag() or
  InitializerFieldAddressTag() or
  InitializerFieldDefaultValueTag() or
  InitializerFieldDefaultValueStoreTag() or
  InitializerElementIndexTag() or
  InitializerElementAddressTag() or
  InitializerElementDefaultValueTag() or
  InitializerElementDefaultValueStoreTag() or
  VarArgsStartEllipsisAddressTag() or
  VarArgsStartTag() or
  VarArgsVAListLoadTag() or
  VarArgsArgAddressTag() or
  VarArgsArgLoadTag() or
  VarArgsMoveNextTag() or
  VarArgsVAListStoreTag() or
  AsmTag() or
  AsmInputTag(int elementIndex) { exists(AsmStmt asm | exists(asm.getChild(elementIndex))) } or
  ThisAddressTag() or
  ThisLoadTag() or
  StructuredBindingAccessTag() or
  // The next three cases handle generation of the constants -1, 0 and 1 for __except handling.
  TryExceptGenerateNegativeOne() or
  TryExceptGenerateZero() or
  TryExceptGenerateOne() or
  // The next three cases handle generation of comparisons for __except handling.
  TryExceptCompareNegativeOne() or
  TryExceptCompareZero() or
  TryExceptCompareOne() or
  // The next three cases handle generation of branching for __except handling.
  TryExceptCompareNegativeOneBranch() or
  TryExceptCompareZeroBranch() or
  TryExceptCompareOneBranch() or
  ImplicitDestructorTag(int index) {
    exists(Expr e | exists(e.getImplicitDestructorCall(index))) or
    exists(Stmt s | exists(s.getImplicitDestructorCall(index)))
  } or
  CoAwaitBranchTag() or
  BoolToIntConversionTag() or
  SizeofVlaBaseSizeTag() or
  SizeofVlaConversionTag(int index) {
    exists(VlaDeclStmt v | exists(v.getTransitiveVlaDimensionStmt(index)))
  } or
  SizeofVlaDimensionTag(int index) {
    exists(VlaDeclStmt v | exists(v.getTransitiveVlaDimensionStmt(index)))
  } or
  AssertionVarAddressTag() or
  AssertionVarLoadTag() or
  AssertionOpTag() or
  AssertionBranchTag()

private predicate instructionTagComponents(InstructionTag tag, int a, int b) {
  tag = OnlyInstructionTag() and a = 1 and b = 0
  or
  tag = InitializerVariableAddressTag() and a = 2 and b = 0
  or
  tag = InitializerLoadStringTag() and a = 3 and b = 0
  or
  tag = InitializerStoreTag() and a = 4 and b = 0
  or
  tag = InitializerIndirectAddressTag() and a = 5 and b = 0
  or
  tag = InitializerIndirectStoreTag() and a = 6 and b = 0
  or
  tag = DynamicInitializationFlagAddressTag() and a = 7 and b = 0
  or
  tag = DynamicInitializationFlagLoadTag() and a = 8 and b = 0
  or
  tag = DynamicInitializationConditionalBranchTag() and a = 9 and b = 0
  or
  tag = DynamicInitializationFlagConstantTag() and a = 10 and b = 0
  or
  tag = DynamicInitializationFlagStoreTag() and a = 11 and b = 0
  or
  tag = ZeroPadStringConstantTag() and a = 12 and b = 0
  or
  tag = ZeroPadStringElementIndexTag() and a = 13 and b = 0
  or
  tag = ZeroPadStringElementAddressTag() and a = 14 and b = 0
  or
  tag = ZeroPadStringStoreTag() and a = 15 and b = 0
  or
  tag = AssignOperationConvertLeftTag() and a = 16 and b = 0
  or
  tag = AssignOperationOpTag() and a = 17 and b = 0
  or
  tag = AssignOperationConvertResultTag() and a = 18 and b = 0
  or
  tag = AssignmentStoreTag() and a = 19 and b = 0
  or
  tag = CrementConstantTag() and a = 20 and b = 0
  or
  tag = CrementOpTag() and a = 21 and b = 0
  or
  tag = CrementStoreTag() and a = 22 and b = 0
  or
  tag = EnterFunctionTag() and a = 23 and b = 0
  or
  tag = ReturnValueAddressTag() and a = 24 and b = 0
  or
  tag = ReturnTag() and a = 25 and b = 0
  or
  tag = ExitFunctionTag() and a = 26 and b = 0
  or
  tag = AliasedDefinitionTag() and a = 27 and b = 0
  or
  tag = InitializeNonLocalTag() and a = 28 and b = 0
  or
  tag = AliasedUseTag() and a = 29 and b = 0
  or
  tag = SwitchBranchTag() and a = 30 and b = 0
  or
  tag = CallTargetTag() and a = 31 and b = 0
  or
  tag = CallTag() and a = 32 and b = 0
  or
  tag = CallSideEffectTag() and a = 33 and b = 0
  or
  tag = CallNoReturnTag() and a = 34 and b = 0
  or
  tag = AllocationSizeTag() and a = 35 and b = 0
  or
  tag = AllocationElementSizeTag() and a = 36 and b = 0
  or
  tag = AllocationExtentConvertTag() and a = 37 and b = 0
  or
  tag = ValueConditionCompareTag() and a = 38 and b = 0
  or
  tag = ValueConditionConstantTag() and a = 39 and b = 0
  or
  tag = ValueConditionConditionalBranchTag() and a = 40 and b = 0
  or
  tag = ValueConditionConditionalConstantTag() and a = 41 and b = 0
  or
  tag = ValueConditionConditionalCompareTag() and a = 42 and b = 0
  or
  tag = ConditionValueTrueTempAddressTag() and a = 43 and b = 0
  or
  tag = ConditionValueTrueConstantTag() and a = 44 and b = 0
  or
  tag = ConditionValueTrueStoreTag() and a = 45 and b = 0
  or
  tag = ConditionValueFalseTempAddressTag() and a = 46 and b = 0
  or
  tag = ConditionValueFalseConstantTag() and a = 47 and b = 0
  or
  tag = ConditionValueFalseStoreTag() and a = 48 and b = 0
  or
  tag = ConditionValueResultTempAddressTag() and a = 49 and b = 0
  or
  tag = ConditionValueResultLoadTag() and a = 50 and b = 0
  or
  tag = BoolConversionConstantTag() and a = 51 and b = 0
  or
  tag = BoolConversionCompareTag() and a = 52 and b = 0
  or
  tag = NotExprOperationTag() and a = 53 and b = 0
  or
  tag = NotExprConstantTag() and a = 54 and b = 0
  or
  tag = ResultCopyTag() and a = 55 and b = 0
  or
  tag = LoadTag() and a = 56 and b = 0
  or
  tag = CatchTag() and a = 57 and b = 0
  or
  tag = ThrowTag() and a = 58 and b = 0
  or
  tag = UnwindTag() and a = 59 and b = 0
  or
  tag = InitializerUninitializedTag() and a = 60 and b = 0
  or
  tag = InitializerFieldAddressTag() and a = 61 and b = 0
  or
  tag = InitializerFieldDefaultValueTag() and a = 62 and b = 0
  or
  tag = InitializerFieldDefaultValueStoreTag() and a = 63 and b = 0
  or
  tag = InitializerElementIndexTag() and a = 64 and b = 0
  or
  tag = InitializerElementAddressTag() and a = 65 and b = 0
  or
  tag = InitializerElementDefaultValueTag() and a = 66 and b = 0
  or
  tag = InitializerElementDefaultValueStoreTag() and a = 67 and b = 0
  or
  tag = VarArgsStartEllipsisAddressTag() and a = 68 and b = 0
  or
  tag = VarArgsStartTag() and a = 69 and b = 0
  or
  tag = VarArgsVAListLoadTag() and a = 70 and b = 0
  or
  tag = VarArgsArgAddressTag() and a = 71 and b = 0
  or
  tag = VarArgsArgLoadTag() and a = 72 and b = 0
  or
  tag = VarArgsMoveNextTag() and a = 73 and b = 0
  or
  tag = VarArgsVAListStoreTag() and a = 74 and b = 0
  or
  tag = AsmTag() and a = 75 and b = 0
  or
  tag = AsmInputTag(b) and a = 76
  or
  tag = DynamicInitializationFlagAddressTag() and a = 77 and b = 0
  or
  tag = DynamicInitializationFlagLoadTag() and a = 78 and b = 0
  or
  tag = DynamicInitializationConditionalBranchTag() and a = 79 and b = 0
  or
  tag = DynamicInitializationFlagConstantTag() and a = 80 and b = 0
  or
  tag = DynamicInitializationFlagStoreTag() and a = 81 and b = 0
  or
  tag = ThisAddressTag() and a = 82 and b = 0
  or
  tag = ThisLoadTag() and a = 83 and b = 0
  or
  tag = StructuredBindingAccessTag() and a = 84 and b = 0
  or
  tag = TryExceptCompareNegativeOne() and a = 85 and b = 0
  or
  tag = TryExceptCompareZero() and a = 86 and b = 0
  or
  tag = TryExceptCompareOne() and a = 87 and b = 0
  or
  tag = TryExceptGenerateNegativeOne() and a = 88 and b = 0
  or
  tag = TryExceptGenerateZero() and a = 89 and b = 0
  or
  tag = TryExceptGenerateOne() and a = 90 and b = 0
  or
  tag = TryExceptCompareNegativeOneBranch() and a = 91 and b = 0
  or
  tag = TryExceptCompareZeroBranch() and a = 92 and b = 0
  or
  tag = TryExceptCompareOneBranch() and a = 93 and b = 0
  or
  tag = ImplicitDestructorTag(b) and a = 94
  or
  tag = CoAwaitBranchTag() and a = 95 and b = 0
  or
  tag = BoolToIntConversionTag() and a = 96 and b = 0
  or
  tag = AssertionVarAddressTag() and a = 97 and b = 0
  or
  tag = AssertionVarLoadTag() and a = 98 and b = 0
  or
  tag = AssertionOpTag() and a = 99 and b = 0
  or
  tag = AssertionBranchTag() and a = 100 and b = 0
}

class InstructionTag extends TInstructionTag {
  final string toString() { result = getInstructionTagId(this) }

  final int getUniqueId_fast() {
    this =
      rank[result + 1](InstructionTag cand, int a, int b |
        instructionTagComponents(cand, a, b)
      |
        cand order by a, b
      )
  }
}

/**
 * Gets a unique string for the instruction tag. Primarily used for generating
 * instruction IDs to ensure stable IR dumps.
 */
string getInstructionTagId(TInstructionTag tag) {
  tag = OnlyInstructionTag() and result = "Only" // Single instruction (not including implicit Load)
  or
  tag = InitializerVariableAddressTag() and result = "InitVarAddr"
  or
  tag = InitializerLoadStringTag() and result = "InitLoadStr"
  or
  tag = InitializerStoreTag() and result = "InitStore"
  or
  tag = InitializerUninitializedTag() and result = "InitUninit"
  or
  tag = InitializerIndirectAddressTag() and result = "InitIndirectAddr"
  or
  tag = InitializerIndirectStoreTag() and result = "InitIndirectStore"
  or
  tag = ZeroPadStringConstantTag() and result = "ZeroPadConst"
  or
  tag = ZeroPadStringElementIndexTag() and result = "ZeroPadElemIndex"
  or
  tag = ZeroPadStringElementAddressTag() and result = "ZeroPadElemAddr"
  or
  tag = ZeroPadStringStoreTag() and result = "ZeroPadStore"
  or
  tag = AssignOperationConvertLeftTag() and result = "AssignOpConvLeft"
  or
  tag = AssignOperationOpTag() and result = "AssignOpOp"
  or
  tag = AssignOperationConvertResultTag() and result = "AssignOpConvRes"
  or
  tag = AssignmentStoreTag() and result = "AssignStore"
  or
  tag = CrementConstantTag() and result = "CrementConst"
  or
  tag = CrementOpTag() and result = "CrementOp"
  or
  tag = CrementStoreTag() and result = "CrementStore"
  or
  tag = EnterFunctionTag() and result = "EnterFunc"
  or
  tag = ReturnValueAddressTag() and result = "RetValAddr"
  or
  tag = ReturnTag() and result = "Ret"
  or
  tag = ExitFunctionTag() and result = "ExitFunc"
  or
  tag = AliasedDefinitionTag() and result = "AliasedDef"
  or
  tag = InitializeNonLocalTag() and result = "InitNonLocal"
  or
  tag = AliasedUseTag() and result = "AliasedUse"
  or
  tag = SwitchBranchTag() and result = "SwitchBranch"
  or
  tag = CallTargetTag() and result = "CallTarget"
  or
  tag = CallTag() and result = "Call"
  or
  tag = CallSideEffectTag() and result = "CallSideEffect"
  or
  tag = AllocationSizeTag() and result = "AllocSize"
  or
  tag = AllocationElementSizeTag() and result = "AllocElemSize"
  or
  tag = AllocationExtentConvertTag() and result = "AllocExtConv"
  or
  tag = ValueConditionConditionalBranchTag() and result = "ValCondCondBranch"
  or
  tag = ValueConditionConditionalConstantTag() and result = "ValueConditionConditionalConstant"
  or
  tag = ValueConditionConditionalCompareTag() and result = "ValueConditionConditionalCompare"
  or
  tag = ValueConditionCompareTag() and result = "ValCondCondCompare"
  or
  tag = ValueConditionConstantTag() and result = "ValCondConstant"
  or
  tag = ConditionValueTrueTempAddressTag() and result = "CondValTrueTempAddr"
  or
  tag = ConditionValueTrueConstantTag() and result = "CondValTrueConst"
  or
  tag = ConditionValueTrueStoreTag() and result = "CondValTrueStore"
  or
  tag = ConditionValueFalseTempAddressTag() and result = "CondValFalseTempAddr"
  or
  tag = ConditionValueFalseConstantTag() and result = "CondValFalseConst"
  or
  tag = ConditionValueFalseStoreTag() and result = "CondValFalseStore"
  or
  tag = ConditionValueResultTempAddressTag() and result = "CondValResTempAddr"
  or
  tag = ConditionValueResultLoadTag() and result = "CondValResLoad"
  or
  tag = BoolConversionConstantTag() and result = "BoolConvConst"
  or
  tag = BoolConversionCompareTag() and result = "BoolConvComp"
  or
  tag = NotExprOperationTag() and result = "NotExprOperation"
  or
  tag = NotExprConstantTag() and result = "NotExprWithBoolConversionConstant"
  or
  tag = ResultCopyTag() and result = "ResultCopy"
  or
  tag = LoadTag() and result = "Load" // Implicit load due to lvalue-to-rvalue conversion
  or
  tag = CatchTag() and result = "Catch"
  or
  tag = ThrowTag() and result = "Throw"
  or
  tag = UnwindTag() and result = "Unwind"
  or
  tag = InitializerFieldAddressTag() and result = "InitFieldAddr"
  or
  tag = InitializerFieldDefaultValueTag() and result = "InitFieldDefVal"
  or
  tag = InitializerFieldDefaultValueStoreTag() and result = "InitFieldDefValStore"
  or
  tag = InitializerElementIndexTag() and result = "InitElemIndex"
  or
  tag = InitializerElementAddressTag() and result = "InitElemAddr"
  or
  tag = InitializerElementDefaultValueTag() and result = "InitElemDefVal"
  or
  tag = InitializerElementDefaultValueStoreTag() and result = "InitElemDefValStore"
  or
  tag = VarArgsStartEllipsisAddressTag() and result = "VarArgsStartEllipsisAddr"
  or
  tag = VarArgsStartTag() and result = "VarArgsStart"
  or
  tag = VarArgsVAListLoadTag() and result = "VarArgsVAListLoad"
  or
  tag = VarArgsArgAddressTag() and result = "VarArgsArgAddr"
  or
  tag = VarArgsArgLoadTag() and result = "VaArgsArgLoad"
  or
  tag = VarArgsMoveNextTag() and result = "VarArgsMoveNext"
  or
  tag = VarArgsVAListStoreTag() and result = "VarArgsVAListStore"
  or
  tag = AsmTag() and result = "Asm"
  or
  exists(int index | tag = AsmInputTag(index) and result = "AsmInputTag(" + index + ")")
  or
  tag = DynamicInitializationFlagAddressTag() and result = "DynInitFlagAddr"
  or
  tag = DynamicInitializationFlagLoadTag() and result = "DynInitFlagLoad"
  or
  tag = DynamicInitializationConditionalBranchTag() and result = "DynInitCondBranch"
  or
  tag = DynamicInitializationFlagConstantTag() and result = "DynInitFlagConst"
  or
  tag = DynamicInitializationFlagStoreTag() and result = "DynInitFlagStore"
  or
  tag = ThisAddressTag() and result = "ThisAddress"
  or
  tag = ThisLoadTag() and result = "ThisLoad"
  or
  tag = StructuredBindingAccessTag() and result = "StructuredBindingAccess"
  or
  tag = TryExceptCompareNegativeOne() and result = "TryExceptCompareNegativeOne"
  or
  tag = TryExceptCompareZero() and result = "TryExceptCompareZero"
  or
  tag = TryExceptCompareOne() and result = "TryExceptCompareOne"
  or
  tag = TryExceptGenerateNegativeOne() and result = "TryExceptGenerateNegativeOne"
  or
  tag = TryExceptGenerateZero() and result = "TryExceptGenerateNegativeOne"
  or
  tag = TryExceptGenerateOne() and result = "TryExceptGenerateOne"
  or
  tag = TryExceptCompareNegativeOneBranch() and result = "TryExceptCompareNegativeOneBranch"
  or
  tag = TryExceptCompareZeroBranch() and result = "TryExceptCompareZeroBranch"
  or
  tag = TryExceptCompareOneBranch() and result = "TryExceptCompareOneBranch"
  or
  exists(int index |
    tag = ImplicitDestructorTag(index) and result = "ImplicitDestructor(" + index + ")"
  )
  or
  tag = CoAwaitBranchTag() and result = "CoAwaitBranch"
  or
  tag = BoolToIntConversionTag() and result = "BoolToIntConversion"
  or
  tag = AssertionVarAddressTag() and result = "AssertionVarAddress"
  or
  tag = AssertionVarLoadTag() and result = "AssertionVarLoad"
  or
  tag = AssertionOpTag() and result = "AssertionOp"
  or
  tag = AssertionBranchTag() and result = "AssertionBranch"
}
