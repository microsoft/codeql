newtype TTempVariableTag =
  ConditionValueTempVar() or
  ReturnValueTempVar() or
  ThrowTempVar() or
  LambdaTempVar() or
  EllipsisTempVar() or
  ThisTempVar() or
  TempObjectTempVar()

string getTempVariableTagId(TTempVariableTag tag) {
  tag = ConditionValueTempVar() and result = "CondVal"
  or
  tag = ReturnValueTempVar() and result = "Ret"
  or
  tag = ThrowTempVar() and result = "Throw"
  or
  tag = LambdaTempVar() and result = "Lambda"
  or
  tag = EllipsisTempVar() and result = "Ellipsis"
  or
  tag = ThisTempVar() and result = "This"
  or
  tag = TempObjectTempVar() and result = "Temp"
}

int getTempVariableUniqueId_fast(TTempVariableTag tag) {
  tag = ConditionValueTempVar() and result = 1
  or
  tag = ReturnValueTempVar() and result = 2
  or
  tag = ThrowTempVar() and result = 3
  or
  tag = LambdaTempVar() and result = 4
  or
  tag = EllipsisTempVar() and result = 5
  or
  tag = ThisTempVar() and result = 6
  or
  tag = TempObjectTempVar() and result = 7
}
