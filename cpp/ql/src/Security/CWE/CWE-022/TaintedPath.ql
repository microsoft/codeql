/**
 * @name Uncontrolled data used in path expression
 * @description Accessing paths influenced by users can allow an
 *              attacker to access unexpected resources.
 * @kind path-problem
 * @problem.severity warning
 * @security-severity 7.5
 * @precision medium
 * @id cpp/path-injection
 * @tags security
 *       external/cwe/cwe-022
 *       external/cwe/cwe-023
 *       external/cwe/cwe-036
 *       external/cwe/cwe-073
 */

import cpp
import semmle.code.cpp.security.FunctionWithWrappers
import semmle.code.cpp.security.FlowSources
import semmle.code.cpp.ir.IR
import semmle.code.cpp.ir.dataflow.TaintTracking
import TaintedPathFlow::PathGraph
import semmle.code.cpp.controlflow.IRGuards



/**
 * A node whose type is a simple type unlikely to carry taint, such as primitives and their boxed counterparts,
 * `java.util.UUID` and `java.util.Date`.
 */
class SimpleTypeSanitizer extends DataFlow::Node {
  SimpleTypeSanitizer() {
    this.getType() instanceof ArithmeticType
  }
}


/**
 * A function for opening a file.
 */
class FileFunction extends FunctionWithWrappers {
  FileFunction() {
    exists(string nme | this.hasGlobalName(nme) |
      nme = ["fopen", "_fopen", "_wfopen", "open", "_open", "_wopen"]
      or
      // create file function on windows
      nme.matches("CreateFile%")
    )
    or
    this.hasQualifiedName("std", "fopen")
    or
    // on any of the fstream classes, or filebuf
    exists(string nme | this.getDeclaringType().hasQualifiedName("std", nme) |
      nme = ["basic_fstream", "basic_ifstream", "basic_ofstream", "basic_filebuf"]
    ) and
    // we look for either the open method or the constructor
    (this.getName() = "open" or this instanceof Constructor)
  }

  // conveniently, all of these functions take the path as the first parameter!
  override predicate interestingArg(int arg) { arg = 0 }
}

predicate testcheck(IRGuardCondition g, Expr e, boolean branch) {
  branch = [true, false] and 
  not g.getLocation().getStartLine() = 11 and 
  g.getLocation().getFile().getBaseName() = "testcpp.cpp" and 
  e = g.getUnconvertedResultExpression().getAChild*()
  // // exists(Operand left |
  // //   g.comparesEq(left, _, _, _, branch) or 
  // //   g.ensuresEq(left, _, _, _, branch)
  // // |
  // //   left.getDef().getUnconvertedResultExpression() = e and
  // //   //exists(Literal l | l.getValue().matches("..") and e.getAChild*() = l)
  // //   e.getLocation().getFile().getBaseName() = "testcpp.cpp"
  // // )
  // //g.getLocation().getFile().getBaseName() = "testcpp.cpp" and
  // e = g.getUnconvertedResultExpression().getAChild*() and
  // e.(Call).getTarget().getName().matches("find")
  // // exists(Call c | c = g.getUnconvertedResultExpression().getAChild*() and
  // //  c.getTarget().hasName("find")) and
  // // g.comparesEq(_, _, _, _, branch) 
  // and
  // branch = [true, false]

  //.comparesEq(_, _, _, _, branch) and
  // e = g.getUnconvertedResultExpression().getAChild*() and
  // e.(Call).getTarget().getName().matches("is_open") and
  // branch = true

    // e = g.getUnconvertedResultExpression() and 
    // e.getLocation().getFile().getBaseName() = "testcpp.cpp" and
    // branch = [true, false]

  // exists(Call call |
  //   g.getUnconvertedResultExpression().getAChild*() = call and
  //   call.getTarget().hasName("exists") and
  //   e = call.getAnArgument() and
  //   (branch = true or branch = false)
  //    )
}

module TaintedPathConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node node) { node instanceof FlowSource }

  predicate isSink(DataFlow::Node node) {
    any()
    // exists(FileFunction fileFunction |
    //   fileFunction.outermostWrapperFunctionCall(node.asIndirectArgument(), _)
    // )
  }

  predicate isBarrier(DataFlow::Node node) {
    // node instanceof SimpleTypeSanitizer or
    node = DataFlow::BarrierGuard<testcheck/3>::getAnIndirectBarrierNode()
    or
    node = DataFlow::BarrierGuard<testcheck/3>::getABarrierNode()
  }



  //   // node.asExpr().(Call).getTarget().getUnspecifiedType() instanceof ArithmeticType
  //   // or
  //   // exists(LoadInstruction load, Variable checkedVar |
  //   //   load = node.asInstruction() and
  //   //   checkedVar = load.getSourceAddress().(VariableAddressInstruction).getAstVariable() and
  //   //   hasUpperBoundsCheck(checkedVar)
  //   // )
  // }
}

module TaintedPathFlow = TaintTracking::Global<TaintedPathConfig>;

// from
//   FileFunction fileFunction, Expr taintedArg, FlowSource taintSource,
//   TaintedPathFlow::PathNode sourceNode, TaintedPathFlow::PathNode sinkNode, string callChain
// where
//   taintedArg = sinkNode.getNode().asIndirectArgument() and
//   fileFunction.outermostWrapperFunctionCall(taintedArg, callChain) and
//   TaintedPathFlow::flowPath(sourceNode, sinkNode) and
//   taintSource = sourceNode.getNode()
// select taintedArg, sourceNode, sinkNode,
//   "This argument to a file access function is derived from $@ and then passed to " + callChain + ".",
//   taintSource, "user input (" + taintSource.getSourceType() + ")"


from
  TaintedPathFlow::PathNode sourceNode, TaintedPathFlow::PathNode sinkNode
where
  TaintedPathFlow::flowPath(sourceNode, sinkNode) 
select sinkNode.getNode(), sourceNode, sinkNode, "test"
