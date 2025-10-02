private import semmle.code.binary.ast.Location
private import codeql.util.Option
private import TranslatedElement
private import InstructionTag
private import Opcode
private import Function
private import TranslatedInstruction
private import TranslatedOperand
private import TranslatedFunction
private import codeql.controlflow.SuccessorType
private import BasicBlock
private import Operand
private import Variable

newtype TInstruction =
  MkInstruction(TranslatedElement te, InstructionTag tag) { hasInstruction(te, tag) }

class Instruction extends TInstruction {
  TranslatedElement te;
  InstructionTag tag;

  Instruction() { this = MkInstruction(te, tag) }

  Opcode getOpcode() { te.hasInstruction(result, tag, _) }

  Operand getOperand(OperandTag operandTag) { result = MkOperand(te, tag, operandTag) }

  Operand getAnOperand() { result = this.getOperand(_) }

  string toString() { result = stringOfOpcode(this.getOpcode()) }

  Instruction getSuccessor(SuccessorType succType) { result = te.getSuccessor(tag, succType) }

  Instruction getASuccessor() { result = this.getSuccessor(_) }

  Instruction getAPredecessor() { this = result.getASuccessor() }

  Location getLocation() { result instanceof EmptyLocation }

  Function getEnclosingFunction() {
    exists(TranslatedFunction f |
      result = TMkFunction(f) and
      f.getEntry() = this
    )
    or
    result = this.getAPredecessor().getEnclosingFunction()
  }

  predicate hasInternalOrder(QlBuiltins::BigInt index0, int index1, int index2) {
    te.(TranslatedInstruction).hasIndex(tag, index0, index1, index2)
  }

  BasicBlock getBasicBlock() { result.getAnInstruction() = this }

  Variable getResultVariable() {
    exists(Option<Variable>::Option v |
      te.hasInstruction(_, tag, v) and
      result = v.asSome()
    )
  }
}
