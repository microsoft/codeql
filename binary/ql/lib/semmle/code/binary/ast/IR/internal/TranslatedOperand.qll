private import semmle.code.binary.ast.instructions as RawInstruction
private import semmle.code.binary.ast.operand as RawOperand
private import TranslatedElement
private import codeql.util.Option
private import Opcode as Opcode
private import InstructionTag
private import TranslatedInstruction
private import Instruction
private import Operand
private import codeql.controlflow.SuccessorType
private import Variable

abstract class TranslatedOperand extends TranslatedElement {
  RawOperand::Operand op;

  override RawInstruction::Element getRawElement() { result = op }

  override predicate hasIndex(InstructionTag tag, QlBuiltins::BigInt index0, int index1, int index2) {
    this.hasIndex(tag, index2) and
    exists(RawInstruction::Instruction instr |
      instr = this.getUse().getRawElement() and
      instr.getIndex() = index0 and
      instr.getOperand(index1) = op
    )
  }

  abstract predicate hasIndex(InstructionTag tag, int index);

  TranslatedInstruction getUse() { result = getTranslatedInstruction(op.getUse()) }

  abstract Option<Instruction>::Option getEntry();
}

TranslatedOperand getTranslatedOperand(RawOperand::Operand op) {
  result.getRawElement() = op and
  result.producesResult()
}

class TranslatedRegisterOperand extends TranslatedOperand, TTranslatedRegisterOperand {
  override RawOperand::RegisterOperand op;

  TranslatedRegisterOperand() { this = TTranslatedRegisterOperand(op) }

  override Instruction getSuccessor(InstructionTag tag, SuccessorType succType) { none() }

  override predicate producesResult() { any() }

  override Variable getResultVariable() { result = getTranslatedVariableReal(op.getRegister()) }

  override Instruction getChildSuccessor(TranslatedElement child, SuccessorType succType) { none() }

  override predicate hasIndex(InstructionTag tag, int index) { none() }

  override Variable getVariableOperand(InstructionTag tag, OperandTag operandTag) { none() }

  override predicate hasInstruction(Opcode opcode, InstructionTag tag, Option<Variable>::Option v) {
    none()
  }

  override Option<Instruction>::Option getEntry() { result.isNone() }

  override string toString() { result = "Translation of " + op }
}

/**
 * Compile an immediate operand (such as 0x48) into:
 * ```
 * r1 = Const(0x48)
 * ```
 */
class TranslatedImmediateOperand extends TranslatedOperand, TTranslatedImmediateOperand {
  override RawOperand::ImmediateOperand op;

  TranslatedImmediateOperand() { this = TTranslatedImmediateOperand(op) }

  override Instruction getSuccessor(InstructionTag tag, SuccessorType succType) {
    tag = ImmediateOperandConstTag() and
    succType instanceof DirectSuccessor and
    result = getTranslatedInstruction(op.getUse()).getChildSuccessor(this, succType)
  }

  override predicate producesResult() { any() }

  override predicate hasTempVariable(VariableTag tag) { tag = ImmediateOperandVarTag() }

  override Variable getResultVariable() { result = this.getVariable(ImmediateOperandVarTag()) }

  override Instruction getChildSuccessor(TranslatedElement child, SuccessorType succType) { none() }

  override predicate hasIndex(InstructionTag tag, int index) {
    tag = ImmediateOperandConstTag() and
    index = 0
  }

  override Variable getVariableOperand(InstructionTag tag, OperandTag operandTag) { none() }

  override int getConstantValue(InstructionTag tag) {
    tag = ImmediateOperandConstTag() and
    result = op.getValue()
  }

  override predicate hasInstruction(Opcode opcode, InstructionTag tag, Option<Variable>::Option v) {
    opcode = Opcode::Const() and
    tag = ImmediateOperandConstTag() and
    v.asSome() = this.getVariable(ImmediateOperandVarTag())
  }

  override Option<Instruction>::Option getEntry() {
    result.asSome() = this.getInstruction(ImmediateOperandConstTag())
  }

  override string toString() { result = "Translation of " + op }
}

class TranslatedMemoryOperand extends TranslatedOperand, TTranslatedMemoryOperand {
  override RawOperand::MemoryOperand op;

  TranslatedMemoryOperand() { this = TTranslatedMemoryOperand(op) }

  private predicate isLoaded() { this.getUse().isOperandLoaded(op) }

  override Instruction getSuccessor(InstructionTag tag, SuccessorType succType) {
    this.case1Applies() and
    (
      tag = MemoryOperandConstFactorTag() and
      succType instanceof DirectSuccessor and
      result = this.getInstruction(MemoryOperandMulTag())
      or
      tag = MemoryOperandMulTag() and
      succType instanceof DirectSuccessor and
      result = this.getInstruction(MemoryOperandAdd1Tag())
      or
      tag = MemoryOperandAdd1Tag() and
      succType instanceof DirectSuccessor and
      result = this.getInstruction(MemoryOperandAdd2Tag())
      or
      this.isLoaded() and
      tag = MemoryOperandAdd2Tag() and
      succType instanceof DirectSuccessor and
      result = this.getInstruction(MemoryOperandLoadTag())
    )
    or
    this.case2Applies() and
    (
      tag = MemoryOperandConstFactorTag() and
      succType instanceof DirectSuccessor and
      result = this.getInstruction(MemoryOperandMulTag())
      or
      tag = MemoryOperandMulTag() and
      succType instanceof DirectSuccessor and
      result = this.getInstruction(MemoryOperandAdd1Tag())
      or
      this.isLoaded() and
      tag = MemoryOperandAdd1Tag() and
      succType instanceof DirectSuccessor and
      result = this.getInstruction(MemoryOperandLoadTag())
    )
    or
    this.case3Applies() and
    (
      tag = MemoryOperandConstDisplacementTag() and
      succType instanceof DirectSuccessor and
      result = this.getInstruction(MemoryOperandAdd1Tag())
      or
      tag = MemoryOperandAdd1Tag() and
      succType instanceof DirectSuccessor and
      result = this.getInstruction(MemoryOperandAdd2Tag())
      or
      this.isLoaded() and
      tag = MemoryOperandAdd2Tag() and
      succType instanceof DirectSuccessor and
      result = this.getInstruction(MemoryOperandLoadTag())
    )
    or
    this.case4Applies() and
    (
      tag = MemoryOperandConstDisplacementTag() and
      succType instanceof DirectSuccessor and
      result = this.getInstruction(MemoryOperandAdd1Tag())
      or
      this.isLoaded() and
      tag = MemoryOperandAdd1Tag() and
      succType instanceof DirectSuccessor and
      result = this.getInstruction(MemoryOperandLoadTag())
    )
    or
    this.case5Applies() and
    (
      tag = MemoryOperandConstDisplacementTag() and
      succType instanceof DirectSuccessor and
      result = this.getInstruction(MemoryOperandAdd1Tag())
      or
      this.isLoaded() and
      tag = MemoryOperandAdd1Tag() and
      succType instanceof DirectSuccessor and
      result = this.getInstruction(MemoryOperandLoadTag())
    )
    or
    this.case6Applies() and
    none() // case6 has no instructions
    or
    this.case7Applies() and
    (
      tag = MemoryOperandConstFactorTag() and
      succType instanceof DirectSuccessor and
      result = this.getInstruction(MemoryOperandMulTag())
      or
      tag = MemoryOperandMulTag() and
      succType instanceof DirectSuccessor and
      result = this.getInstruction(MemoryOperandAdd1Tag())
      or
      this.isLoaded() and
      tag = MemoryOperandAdd1Tag() and
      succType instanceof DirectSuccessor and
      result = this.getInstruction(MemoryOperandLoadTag())
    )
    or
    this.case8Applies() and
    (
      tag = MemoryOperandConstFactorTag() and
      succType instanceof DirectSuccessor and
      result = this.getInstruction(MemoryOperandMulTag())
      or
      this.isLoaded() and
      tag = MemoryOperandMulTag() and
      succType instanceof DirectSuccessor and
      result = this.getInstruction(MemoryOperandLoadTag())
    )
    or
    this.case9Applies() and
    (
      tag = MemoryOperandConstDisplacementTag() and
      succType instanceof DirectSuccessor and
      result = this.getInstruction(MemoryOperandAdd1Tag())
      or
      this.isLoaded() and
      tag = MemoryOperandAdd1Tag() and
      succType instanceof DirectSuccessor and
      result = this.getInstruction(MemoryOperandLoadTag())
    )
    or
    this.case10Applies() and
    none() // case10 has no instructions
    or
    this.case11Applies() and
    none() // case11 has no instructions
  }

  override predicate producesResult() { any() }

  override Instruction getChildSuccessor(TranslatedElement child, SuccessorType succType) { none() }

  override predicate hasIndex(InstructionTag tag, int index) {
    this.case1Applies() and
    (
      tag = MemoryOperandConstFactorTag() and
      index = 0
      or
      tag = MemoryOperandMulTag() and
      index = 1
      or
      tag = MemoryOperandAdd1Tag() and
      index = 2
      or
      tag = MemoryOperandAdd2Tag() and
      index = 3
      or
      this.isLoaded() and
      tag = MemoryOperandLoadTag() and
      index = 4
    )
    or
    this.case2Applies() and
    (
      tag = MemoryOperandConstFactorTag() and
      index = 0
      or
      tag = MemoryOperandMulTag() and
      index = 1
      or
      tag = MemoryOperandAdd1Tag() and
      index = 2
      or
      this.isLoaded() and
      tag = MemoryOperandLoadTag() and
      index = 3
    )
    or
    this.case3Applies() and
    (
      tag = MemoryOperandConstDisplacementTag() and
      index = 0
      or
      tag = MemoryOperandAdd1Tag() and
      index = 1
      or
      tag = MemoryOperandAdd2Tag() and
      index = 2
      or
      this.isLoaded() and
      tag = MemoryOperandLoadTag() and
      index = 3
    )
    or
    this.case4Applies() and
    (
      tag = MemoryOperandConstDisplacementTag() and
      index = 0
      or
      tag = MemoryOperandAdd1Tag() and
      index = 1
      or
      this.isLoaded() and
      tag = MemoryOperandLoadTag() and
      index = 2
    )
    or
    this.case5Applies() and
    (
      tag = MemoryOperandConstDisplacementTag() and
      index = 0
      or
      tag = MemoryOperandAdd1Tag() and
      index = 1
      or
      this.isLoaded() and
      tag = MemoryOperandLoadTag() and
      index = 2
    )
    or
    this.case6Applies() and
    (
      this.isLoaded() and
      tag = MemoryOperandLoadTag() and
      index = 0
    )
    or
    this.case7Applies() and
    (
      tag = MemoryOperandConstFactorTag() and
      index = 0
      or
      tag = MemoryOperandMulTag() and
      index = 1
      or
      tag = MemoryOperandAdd1Tag() and
      index = 2
      or
      this.isLoaded() and
      tag = MemoryOperandLoadTag() and
      index = 3
    )
    or
    this.case8Applies() and
    (
      tag = MemoryOperandConstFactorTag() and
      index = 0
      or
      tag = MemoryOperandMulTag() and
      index = 1
      or
      this.isLoaded() and
      tag = MemoryOperandLoadTag() and
      index = 2
    )
    or
    this.case9Applies() and
    (
      tag = MemoryOperandConstDisplacementTag() and
      index = 0
      or
      tag = MemoryOperandAdd1Tag() and
      index = 1
      or
      this.isLoaded() and
      tag = MemoryOperandLoadTag() and
      index = 2
    )
    or
    this.case10Applies() and
    (
      tag = MemoryOperandConstDisplacementTag() and
      index = 0
      or
      this.isLoaded() and
      tag = MemoryOperandLoadTag() and
      index = 1
    )
    or
    this.case11Applies() and
    (
      tag = MemoryOperandConstDisplacementTag() and
      index = 0
      or
      this.isLoaded() and
      tag = MemoryOperandLoadTag() and
      index = 1
    )
  }

  private predicate hasScaleFactor() { op.getScaleFactor() != 1 }

  private predicate hasIndex() { exists(op.getIndexRegister()) }

  private predicate hasDisplacementValue() { op.getDisplacementValue() != 0 }

  private predicate hasBase() { exists(op.getBaseRegister()) }

  override int getConstantValue(InstructionTag tag) {
    this.hasScaleFactor() and
    tag = MemoryOperandConstFactorTag() and
    result = op.getScaleFactor()
    or
    this.hasDisplacementValue() and
    tag = MemoryOperandConstDisplacementTag() and
    result = op.getDisplacementValue()
  }

  override Variable getResultVariable() {
    (
      this.case1Applies() or
      this.case2Applies() or
      this.case3Applies() or
      this.case4Applies() or
      this.case5Applies() or
      this.case7Applies() or
      this.case8Applies() or
      this.case9Applies()
    ) and
    result = this.getVariable(MemoryOperandVarTag())
    or
    this.case6Applies() and
    not this.isLoaded() and
    result = getTranslatedVariableReal(op.getBaseRegister().getTarget())
    or
    this.case10Applies() and
    not this.isLoaded() and
    result = getTranslatedVariableReal(op.getIndexRegister().getTarget())
    or
    this.case11Applies() and
    not this.isLoaded() and
    result = this.getInstruction(MemoryOperandConstDisplacementTag()).getResultVariable()
  }

  // Compute base + index * factor + displacement
  Variable case1(InstructionTag tag, OperandTag operandTag) {
    // x = index * factor
    tag = MemoryOperandMulTag() and
    (
      operandTag = LeftTag() and
      result = getTranslatedVariableReal(op.getIndexRegister().getTarget())
      or
      operandTag = RightTag() and
      result = this.getInstruction(MemoryOperandConstFactorTag()).getResultVariable()
    )
    or
    // x = x + base
    tag = MemoryOperandAdd1Tag() and
    (
      operandTag = LeftTag() and
      result = this.getInstruction(MemoryOperandMulTag()).getResultVariable()
      or
      operandTag = RightTag() and
      result = getTranslatedVariableReal(op.getBaseRegister().getTarget())
    )
    or
    // x = x + displacement
    tag = MemoryOperandAdd2Tag() and
    (
      operandTag = LeftTag() and
      result = this.getInstruction(MemoryOperandAdd1Tag()).getResultVariable()
      or
      operandTag = RightTag() and
      result = this.getInstruction(MemoryOperandConstDisplacementTag()).getResultVariable()
    )
    or
    // Load from [x]
    this.isLoaded() and
    tag = MemoryOperandLoadTag() and
    operandTag = UnaryTag() and
    result = this.getInstruction(MemoryOperandAdd2Tag()).getResultVariable()
  }

  // Compute base + index * scale
  Variable case2(InstructionTag tag, OperandTag operandTag) {
    // x = index * factor
    tag = MemoryOperandMulTag() and
    (
      operandTag = LeftTag() and
      result = getTranslatedVariableReal(op.getIndexRegister().getTarget())
      or
      operandTag = RightTag() and
      result = this.getInstruction(MemoryOperandConstFactorTag()).getResultVariable()
    )
    or
    // x = x + base
    tag = MemoryOperandAdd1Tag() and
    (
      operandTag = LeftTag() and
      result = this.getInstruction(MemoryOperandMulTag()).getResultVariable()
      or
      operandTag = RightTag() and
      result = getTranslatedVariableReal(op.getBaseRegister().getTarget())
    )
    or
    // Load from [x]
    this.isLoaded() and
    tag = MemoryOperandLoadTag() and
    operandTag = UnaryTag() and
    result = this.getInstruction(MemoryOperandAdd1Tag()).getResultVariable()
  }

  // Compute base + index + displacement
  Variable case3(InstructionTag tag, OperandTag operandTag) {
    // x = base + index
    tag = MemoryOperandAdd1Tag() and
    (
      operandTag = LeftTag() and
      result = getTranslatedVariableReal(op.getBaseRegister().getTarget())
      or
      operandTag = RightTag() and
      result = getTranslatedVariableReal(op.getIndexRegister().getTarget())
    )
    or
    // x = x + displacement
    tag = MemoryOperandAdd2Tag() and
    (
      operandTag = LeftTag() and
      result = this.getInstruction(MemoryOperandAdd1Tag()).getResultVariable()
      or
      operandTag = RightTag() and
      result = this.getInstruction(MemoryOperandConstDisplacementTag()).getResultVariable()
    )
    or
    // Load from [x]
    this.isLoaded() and
    tag = MemoryOperandLoadTag() and
    operandTag = UnaryTag() and
    result = this.getInstruction(MemoryOperandAdd2Tag()).getResultVariable()
  }

  // Compute base + index
  Variable case4(InstructionTag tag, OperandTag operandTag) {
    // x = base + index
    tag = MemoryOperandAdd1Tag() and
    (
      operandTag = LeftTag() and
      result = getTranslatedVariableReal(op.getBaseRegister().getTarget())
      or
      operandTag = RightTag() and
      result = getTranslatedVariableReal(op.getIndexRegister().getTarget())
    )
    or
    // Load from [x]
    this.isLoaded() and
    tag = MemoryOperandLoadTag() and
    operandTag = UnaryTag() and
    result = this.getInstruction(MemoryOperandAdd1Tag()).getResultVariable()
  }

  // Compute base + displacement
  Variable case5(InstructionTag tag, OperandTag operandTag) {
    // x = base + displacement
    tag = MemoryOperandAdd1Tag() and
    (
      operandTag = LeftTag() and
      result = getTranslatedVariableReal(op.getBaseRegister().getTarget())
      or
      operandTag = RightTag() and
      result = this.getInstruction(MemoryOperandConstDisplacementTag()).getResultVariable()
    )
    or
    // Load from [x]
    this.isLoaded() and
    tag = MemoryOperandLoadTag() and
    operandTag = UnaryTag() and
    result = this.getInstruction(MemoryOperandAdd1Tag()).getResultVariable()
  }

  // Compute base
  Variable case6(InstructionTag tag, OperandTag operandTag) {
    this.isLoaded() and
    tag = MemoryOperandLoadTag() and
    operandTag = UnaryTag() and
    result = getTranslatedVariableReal(op.getBaseRegister().getTarget())
    // If we are in case6 and we do not need to load the result will be the base register
  }

  // Compute index * scale + displacement
  Variable case7(InstructionTag tag, OperandTag operandTag) {
    // x = index * factor
    tag = MemoryOperandMulTag() and
    (
      operandTag = LeftTag() and
      result = getTranslatedVariableReal(op.getIndexRegister().getTarget())
      or
      operandTag = RightTag() and
      result = this.getInstruction(MemoryOperandConstFactorTag()).getResultVariable()
    )
    or
    // x = x + displacement
    tag = MemoryOperandAdd1Tag() and
    (
      operandTag = LeftTag() and
      result = this.getInstruction(MemoryOperandMulTag()).getResultVariable()
      or
      operandTag = RightTag() and
      result = this.getInstruction(MemoryOperandConstDisplacementTag()).getResultVariable()
    )
    or
    // Load from [x]
    this.isLoaded() and
    tag = MemoryOperandLoadTag() and
    operandTag = UnaryTag() and
    result = this.getInstruction(MemoryOperandAdd1Tag()).getResultVariable()
  }

  // Compute index * factor
  Variable case8(InstructionTag tag, OperandTag operandTag) {
    // x = index * factor
    tag = MemoryOperandMulTag() and
    (
      operandTag = LeftTag() and
      result = getTranslatedVariableReal(op.getIndexRegister().getTarget())
      or
      operandTag = RightTag() and
      result = this.getInstruction(MemoryOperandConstFactorTag()).getResultVariable()
    )
    or
    // Load from [x]
    this.isLoaded() and
    tag = MemoryOperandLoadTag() and
    operandTag = UnaryTag() and
    result = this.getInstruction(MemoryOperandMulTag()).getResultVariable()
  }

  // Compute index + displacement
  Variable case9(InstructionTag tag, OperandTag operandTag) {
    // x = index + displacement
    tag = MemoryOperandAdd1Tag() and
    (
      operandTag = LeftTag() and
      result = getTranslatedVariableReal(op.getIndexRegister().getTarget())
      or
      operandTag = RightTag() and
      result = this.getInstruction(MemoryOperandConstDisplacementTag()).getResultVariable()
    )
    or
    // Load from [x]
    this.isLoaded() and
    tag = MemoryOperandLoadTag() and
    operandTag = UnaryTag() and
    result = this.getInstruction(MemoryOperandAdd1Tag()).getResultVariable()
  }

  Variable case10(InstructionTag tag, OperandTag operandTag) {
    this.isLoaded() and
    tag = MemoryOperandLoadTag() and
    operandTag = UnaryTag() and
    result = getTranslatedVariableReal(op.getIndexRegister().getTarget())
    // If we are in case10 and we do not need to load the result will be the index register
  }

  Variable case11(InstructionTag tag, OperandTag operandTag) {
    this.isLoaded() and
    tag = MemoryOperandLoadTag() and
    operandTag = UnaryTag() and
    result = this.getInstruction(MemoryOperandConstDisplacementTag()).getResultVariable()
    // If we are in case11 and we do not need to load the result will be the displacement constant
  }

  private predicate case1Applies() {
    this.hasDisplacementValue() and this.hasScaleFactor() and this.hasIndex() and this.hasBase()
  }

  private predicate case2Applies() {
    not this.hasDisplacementValue() and this.hasScaleFactor() and this.hasIndex() and this.hasBase()
  }

  private predicate case3Applies() {
    this.hasDisplacementValue() and not this.hasScaleFactor() and this.hasIndex() and this.hasBase()
  }

  private predicate case4Applies() {
    not this.hasDisplacementValue() and
    not this.hasScaleFactor() and
    this.hasIndex() and
    this.hasBase()
  }

  private predicate case5Applies() {
    this.hasDisplacementValue() and not this.hasIndex() and this.hasBase()
  }

  private predicate case6Applies() {
    not this.hasDisplacementValue() and not this.hasIndex() and this.hasBase()
  }

  private predicate case7Applies() {
    this.hasDisplacementValue() and this.hasScaleFactor() and this.hasIndex() and not this.hasBase()
  }

  private predicate case8Applies() {
    not this.hasDisplacementValue() and
    this.hasScaleFactor() and
    this.hasIndex() and
    not this.hasBase()
  }

  private predicate case9Applies() {
    this.hasDisplacementValue() and not this.hasScaleFactor() and this.hasIndex()
  }

  private predicate case10Applies() {
    not this.hasDisplacementValue() and not this.hasScaleFactor() and this.hasIndex()
  }

  private predicate case11Applies() {
    this.hasDisplacementValue() and not this.hasIndex() and not this.hasBase()
  }

  override Variable getVariableOperand(InstructionTag tag, OperandTag operandTag) {
    if this.hasBase()
    then
      if this.hasIndex()
      then
        if this.hasScaleFactor()
        then
          if this.hasDisplacementValue()
          then result = this.case1(tag, operandTag)
          else result = this.case2(tag, operandTag)
        else
          if this.hasDisplacementValue()
          then result = this.case3(tag, operandTag)
          else result = this.case4(tag, operandTag)
      else
        if this.hasDisplacementValue()
        then result = this.case5(tag, operandTag)
        else result = this.case6(tag, operandTag)
    else
      if this.hasIndex()
      then
        if this.hasScaleFactor()
        then
          if this.hasDisplacementValue()
          then result = this.case7(tag, operandTag)
          else result = this.case8(tag, operandTag)
        else
          if this.hasDisplacementValue()
          then result = this.case9(tag, operandTag)
          else result = this.case10(tag, operandTag)
      else result = this.case11(tag, operandTag)
  }

  override predicate hasTempVariable(VariableTag tag) {
    tag = MemoryOperandVarTag()
    or
    tag = MemoryOperandConstFactorVarTag()
    or
    tag = MemoryOperandConstDisplacementVarTag()
  }

  override predicate hasInstruction(Opcode opcode, InstructionTag tag, Option<Variable>::Option v) {
    opcode = Opcode::Const() and
    (
      tag = MemoryOperandConstFactorTag() and
      v.asSome() = this.getVariable(MemoryOperandConstFactorVarTag())
      or
      tag = MemoryOperandConstDisplacementTag() and
      v.asSome() = this.getVariable(MemoryOperandConstDisplacementVarTag())
    )
    or
    (
      opcode = Opcode::Add() and
      (tag = MemoryOperandAdd1Tag() or tag = MemoryOperandAdd2Tag())
      or
      opcode = Opcode::Mul() and
      tag = MemoryOperandMulTag()
    ) and
    v.asSome() = this.getVariable(MemoryOperandVarTag())
    or
    this.isLoaded() and
    opcode = Opcode::Load() and
    tag = MemoryOperandLoadTag() and
    v.asSome() = this.getVariable(MemoryOperandVarTag())
  }

  override Option<Instruction>::Option getEntry() { none() }

  override string toString() { result = "Translation of " + op }
}
