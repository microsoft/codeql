newtype Opcode =
  Load() or
  Store() or
  Add() or
  Sub() or
  Mul() or
  Div() or
  And() or
  Or() or
  Xor() or
  Shl() or
  Shr() or
  Sar() or
  Rol() or
  Ror() or
  Cmp() or // TODO: Later phases should replace this with specific comparisons such as CmpEQ, CmpNE, CmpLT, CmpLE, CmpGT, CmpGE, etc.
  Goto() or
  Const() or
  Call() or
  Move() or
  Jump() or
  CJump() or
  Ret()

newtype Condition =
  EQ() or
  NE() or
  LT() or
  LE() or
  GT() or
  GE()

string stringOfOpcode(Opcode opcode) {
  opcode = Load() and result = "Load"
  or
  opcode = Store() and result = "Store"
  or
  opcode = Add() and result = "Add"
  or
  opcode = Sub() and result = "Load"
  or
  opcode = Mul() and result = "Mul"
  or
  opcode = Div() and result = "Div"
  or
  opcode = And() and result = "And"
  or
  opcode = Or() and result = "Or"
  or
  opcode = Xor() and result = "Xor"
  or
  opcode = Shl() and result = "Shl"
  or
  opcode = Shr() and result = "Shr"
  or
  opcode = Sar() and result = "Sar"
  or
  opcode = Rol() and result = "Rol"
  or
  opcode = Ror() and result = "Ror"
  or
  opcode = Cmp() and result = "Cmp"
  or
  opcode = Goto() and result = "Goto"
  or
  opcode = Const() and result = "Const"
  or
  opcode = Call() and result = "Call"
  or
  opcode = Move() and result = "Move"
  or
  opcode = Jump() and result = "Jump"
  or
  opcode = CJump() and result = "CJump"
  or
  opcode = Ret() and result = "Ret"
}
