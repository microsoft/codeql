newtype InstructionTag =
  SingleTag() or
  TestAndTag() or
  TestZeroTag() or
  TestCmpTag() or
  ImmediateOperandConstTag() or
  MemoryOperandConstFactorTag() or
  MemoryOperandConstDisplacementTag() or
  MemoryOperandMulTag() or
  MemoryOperandAdd1Tag() or
  MemoryOperandAdd2Tag() or
  MemoryOperandLoadTag() or
  PushSubTag() or
  PushStoreTag() or
  PushSubConstTag() or
  PopAddTag() or
  PopAddConstTag() or
  PopLoadTag()

newtype VariableTag =
  TestVarTag() or
  ZeroVarTag() or
  ImmediateOperandVarTag() or
  MemoryOperandConstFactorVarTag() or
  MemoryOperandConstDisplacementVarTag() or
  MemoryOperandVarTag() or
  PushConstVarTag() or
  PopConstVarTag()

newtype SynthRegisterTag = CmpRegisterTag()

string stringOfSynthRegisterTag(SynthRegisterTag tag) {
  tag = CmpRegisterTag() and
  result = "Cmp"
}

string stringOfVariableTag(VariableTag tag) {
  tag = TestVarTag() and
  result = "Test"
  or
  tag = ImmediateOperandVarTag() and
  result = "ImmediateOperand"
  or
  tag = MemoryOperandVarTag() and
  result = "MemoryOperand"
  or
  tag = MemoryOperandConstFactorVarTag() and
  result = "MemoryOperandConstFactor"
  or
  tag = MemoryOperandConstDisplacementVarTag() and
  result = "MemoryOperandConstDisplacement"
  or
  tag = PushConstVarTag() and
  result = "PushConst"
}

newtype OperandTag =
  LeftTag() or
  RightTag() or
  UnaryTag() or
  StoreSourceTag() or
  StoreDestTag()

int getOperandTagIndex(OperandTag tag) {
  tag = LeftTag() and
  result = 0
  or
  tag = RightTag() and
  result = 1
  or
  tag = UnaryTag() and
  result = 0
  or
  tag = StoreSourceTag() and
  result = 1
  or
  tag = StoreDestTag() and
  result = 0
}

string stringOfOperandTag(OperandTag tag) {
  tag = LeftTag() and
  result = "Left"
  or
  tag = RightTag() and
  result = "Right"
  or
  tag = UnaryTag() and
  result = "Unary"
  or
  tag = StoreSourceTag() and
  result = "StoreSource"
  or
  tag = StoreDestTag() and
  result = "StoreDest"
}
