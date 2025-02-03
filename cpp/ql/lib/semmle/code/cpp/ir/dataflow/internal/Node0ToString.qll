/**
 * This file imports the class that is used to construct the strings used by
 * `Node.ToString`.
 *
 * Normally, this file should just import `NormalNode0ToString` to compute the
 * efficient `toString`, but for debugging purposes one can import
 * `DebugPrinting.qll` to better correlate the dataflow nodes with their
 * underlying instructions and operands.
 */

private import semmle.code.cpp.ir.IR
private import codeql.util.Unit
private import DataFlowUtil
private import DataFlowPrivate
private import DataFlowNodes
import NormalNode0ToString // Change this import to control which version should be used.

private int getNumberOfIndirections(Node n) {
  exists(Node1Impl n1 |
    n = TNode1(n1) and
    result = getNumberOfIndirections0(n1)
  )
  or
  result = n.(VariableNode).getIndirectionIndex()
  or
  result = n.(PostUpdateNodeImpl).getIndirectionIndex()
  or
  result = n.(FinalParameterNode).getIndirectionIndex()
  or
  result = n.(BodyLessParameterNodeImpl).getIndirectionIndex()
}

/**
 * Gets the number of stars (i.e., `*`s) needed to produce the `toString`
 * output for `n`.
 */
string stars(Node n) { result = repeatStars(getNumberOfIndirections(n)) }

/** An abstract class to control the behavior of `Node.toString`. */
abstract class Node0ToString extends Unit {
  /**
   * Gets the string that should be used by `OperandNode.toString` to print the
   * dataflow node whose underlying operand is `op.`
   */
  abstract string operandToString(Operand op);

  /**
   * Gets the string that should be used by `InstructionNode.toString` to print
   * the dataflow node whose underlying instruction is `instr`.
   */
  abstract string instructionToString(Instruction i);

  /**
   * Gets the string representation of the `Expr` associated with `n`, if any.
   */
  abstract string toExprString(Node n);
}

/**
 * Gets the string that should be used by `OperandNode.toString` to print the
 * dataflow node whose underlying operand is `op.`
 */
string operandToString(Operand op) { result = any(Node0ToString s).operandToString(op) }

/**
 * Gets the string that should be used by `InstructionNode.toString` to print
 * the dataflow node whose underlying instruction is `instr`.
 */
string instructionToString(Instruction instr) {
  result = any(Node0ToString s).instructionToString(instr)
}

/**
 * Gets the string representation of the `Expr` associated with `n`, if any.
 */
string toExprString(Node n) { result = any(Node0ToString s).toExprString(n) }
