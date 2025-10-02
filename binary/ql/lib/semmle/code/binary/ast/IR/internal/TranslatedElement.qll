private import semmle.code.binary.ast.instructions as RawInstruction
private import semmle.code.binary.ast.operand as RawOperand
private import codeql.controlflow.SuccessorType
private import Opcode as Opcode
private import InstructionTag
private import Instruction
private import Operand
private import codeql.util.Either
private import TranslatedInstruction
private import TranslatedOperand
private import Variable
private import codeql.util.Option

class Opcode = Opcode::Opcode;

newtype TTranslatedElement =
  TTranslatedFunction(RawInstruction::Instruction entry) {
    entry = any(RawInstruction::Call call).getTarget()
    or
    entry instanceof RawInstruction::ProgramEntryInstruction
  } or
  TTranslatedSimpleBinaryInstruction(RawInstruction::Instruction instr) {
    isSimpleBinaryInstruction(instr, _, _)
  } or
  TTranslatedImmediateOperand(RawOperand::ImmediateOperand op) or
  TTranslatedRegisterOperand(RawOperand::RegisterOperand reg) or
  TTranslatedMemoryOperand(RawOperand::MemoryOperand mem) or
  TTranslatedCall(RawInstruction::Call call) or
  TTranslatedJmp(RawInstruction::Jmp jmp) { exists(jmp.getTarget()) } or
  TTranslatedMov(RawInstruction::Mov mov) or
  TTranslatedPush(RawInstruction::Push push) or
  TTranslatedTest(RawInstruction::Test test) or
  TTranslatedConditionalJump(RawInstruction::ConditionalJumpInstruction cjmp) or
  TTranslatedCmp(RawInstruction::Cmp cmp) or
  TTranslatedLea(RawInstruction::Lea lea) or
  TTranslatedPop(RawInstruction::Pop pop) or
  TTranslatedRet(RawInstruction::Ret ret)

TranslatedElement getTranslatedElement(RawInstruction::Element raw) {
  result.getRawElement() = raw and
  result.producesResult()
}

TranslatedInstruction getTranslatedInstruction(RawInstruction::Instruction raw) {
  result.getRawElement() = raw and
  result.producesResult()
}

abstract class TranslatedElement extends TTranslatedElement {
  abstract predicate hasInstruction(Opcode opcode, InstructionTag tag, Option<Variable>::Option v);

  predicate hasTempVariable(VariableTag tag) { none() }

  predicate hasJumpCondition(InstructionTag tag, Opcode::Condition kind) { none() }

  predicate hasSynthVariable(SynthRegisterTag tag) { none() }

  Variable getVariable(VariableTag tag) { result = TTempVariable(this, tag) }

  final Instruction getInstruction(InstructionTag tag) { result = MkInstruction(this, tag) }

  int getConstantValue(InstructionTag tag) { none() }

  abstract RawInstruction::Element getRawElement();

  abstract Instruction getSuccessor(InstructionTag tag, SuccessorType succType);

  abstract Instruction getChildSuccessor(TranslatedElement child, SuccessorType succType);

  abstract Variable getVariableOperand(InstructionTag tag, OperandTag operandTag);

  abstract predicate producesResult();

  abstract Variable getResultVariable();

  abstract predicate hasIndex(InstructionTag tag, QlBuiltins::BigInt index0, int index1, int index2);

  abstract string toString();
}

predicate hasInstruction(TranslatedElement te, InstructionTag tag) { te.hasInstruction(_, tag, _) }

predicate hasTempVariable(TranslatedElement te, VariableTag tag) { te.hasTempVariable(tag) }

predicate hasSynthVariable(SynthRegisterTag tag) { any(TranslatedElement te).hasSynthVariable(tag) }
