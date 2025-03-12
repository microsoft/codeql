/**
 * Provides predicates for mapping the `FunctionInput` and `FunctionOutput`
 * classes used in function models to the corresponding instructions.
 */

private import semmle.code.cpp.ir.IR
private import semmle.code.cpp.ir.dataflow.DataFlow
private import DataFlowUtil
private import DataFlowPrivate
private import DataFlowNodes
private import SsaInternals as Ssa

private IndirectReturnOutNode0 getIndirectReturnOutNode0(CallInstruction call, int d) {
  result.getCallInstruction() = call and
  result.getIndirectionIndex() = d
}

/**
 * Gets the instruction that goes into `input` for `call`.
 */
Node1Impl callInput0(CallInstruction call, FunctionInput input) {
  // An argument or qualifier
  exists(int index |
    result.asOperand() = call.getArgumentOperand(index) and
    input.isParameterOrQualifierAddress(index)
  )
  or
  // A value pointed to by an argument or qualifier
  exists(int index, int indirectionIndex |
    hasOperandAndIndex1(result, call.getArgumentOperand(index), indirectionIndex) and
    input.isParameterDerefOrQualifierObject(index, indirectionIndex)
  )
  or
  exists(int ind |
    result = getIndirectReturnOutNode0(call, ind) and
    input.isReturnValueDeref(ind)
  )
}

DataFlow::Node callInput(CallInstruction call, FunctionInput input) {
  result = TNode1(callInput0(call, input))
}

/**
 * Gets the node that represents the output of `call` with kind `output` at
 * indirection index `indirectionIndex`.
 */
private Node1Impl callOutputWithIndirectionIndex0(
  CallInstruction call, FunctionOutput output, int indirectionIndex
) {
  // The return value
  simpleOutNode1(result, call) and
  output.isReturnValue() and
  indirectionIndex = 0
  or
  // The side effect of a call on the value pointed to by an argument or qualifier
  exists(int index |
    result.(IndirectArgumentOutNode0).getArgumentIndex() = index and
    result.(IndirectArgumentOutNode0).getIndirectionIndex() = indirectionIndex - 1 and
    result.(IndirectArgumentOutNode0).getCallInstruction() = call and
    output.isParameterDerefOrQualifierObject(index, indirectionIndex - 1)
  )
  or
  result = getIndirectReturnOutNode0(call, indirectionIndex) and
  output.isReturnValueDeref(indirectionIndex)
}

/**
 * Gets the instruction that holds the `output` for `call`.
 */
Node1Impl callOutput0(CallInstruction call, FunctionOutput output) {
  result = callOutputWithIndirectionIndex0(call, output, _)
}

/**
 * Gets the instruction that holds the `output` for `call`.
 */
Node callOutput(CallInstruction call, FunctionOutput output) {
  result = TNode1(callOutput0(call, output))
}

Node1Impl callInput0(CallInstruction call, FunctionInput input, int d) {
  exists(Node1Impl n | n = callInput0(call, input) and d > 0 |
    // An argument or qualifier
    hasOperandAndIndex1(result, n.asOperand(), d)
    or
    exists(Operand operand, int indirectionIndex |
      // A value pointed to by an argument or qualifier
      hasOperandAndIndex1(n, operand, indirectionIndex) and
      hasOperandAndIndex1(result, operand, indirectionIndex + d)
    )
  )
}

DataFlow::Node callInput(CallInstruction call, FunctionInput input, int d) {
  result = TNode1(callInput0(call, input, d))
}

/**
 * Gets the instruction that holds the `output` for `call`.
 */
bindingset[d]
Node1Impl callOutput0(CallInstruction call, FunctionOutput output, int d) {
  exists(Node1Impl n, int indirectionIndex |
    n = callOutputWithIndirectionIndex0(call, output, indirectionIndex) and d > 0
  |
    // The return value
    result = callOutputWithIndirectionIndex0(call, output, indirectionIndex + d)
    or
    // If there isn't an indirect out node for the call with indirection `d` then
    // we conflate this with the underlying `CallInstruction`.
    not exists(getIndirectReturnOutNode0(call, indirectionIndex + d)) and
    n = result
  )
}

/**
 * Gets the instruction that holds the `output` for `call`.
 */
bindingset[d]
Node callOutput(CallInstruction call, FunctionOutput output, int d) {
  result = TNode1(callOutput0(call, output, d))
}
