private import semmle.code.binary.ast.Location
private import TranslatedElement
private import InstructionTag
private import Instruction
private import Opcode
private import Function
private import TranslatedFunction
private import codeql.controlflow.SuccessorType
private import BasicBlock

newtype TOperand =
  MkOperand(TranslatedElement te, InstructionTag tag, OperandTag operandTag) {
    exists(te.getVariableOperand(tag, operandTag))
  }

class Operand extends TOperand {
  TranslatedElement te;
  InstructionTag tag;
  OperandTag operandTag;

  string toString() { result = stringOfOperandTag(operandTag) }

  Instruction getUse() { result.getAnOperand() = this }
}
