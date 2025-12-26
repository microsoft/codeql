/**
* @name Year field changed using an arithmetic operation without checking for leap year (AntiPattern 1)
* @description A field that represents a year is being modified by an arithmetic operation, but no proper check for leap years can be detected afterwards.
* @kind path-problem
* @problem.severity warning
* @id cpp/microsoft/public/leap-year/unchecked-after-arithmetic-year-modification-precise
* @precision medium
* @tags leap-year
*       correctness
*/

import cpp
import LeapYear

/**
 * The set of expressions which are ignorable; either because they seem to not be part of a year mutation,
 * or because they seem to be a conversion pattern of mapping date scalars.
 */
abstract class IgnorableOperation extends Expr { }

class IgnorableExprAssignRem extends IgnorableOperation instanceof AssignRemExpr { }

class IgnorableExprRem extends IgnorableOperation instanceof RemExpr { }

class IgnorableExprUnaryMinus extends IgnorableOperation instanceof UnaryMinusExpr { }

class IgnorableNonPlusMinusOperation extends IgnorableOperation instanceof Operation {
  IgnorableNonPlusMinusOperation() { not isOperationSourceCandidate(this) }
}

class IgnorableNonPlusMinusAssignment extends IgnorableOperation instanceof AssignArithmeticOperation
{
  IgnorableNonPlusMinusAssignment() { not isOperationSourceCandidate(this) }
}

/**
 * Anything involving a sub expression with char literal 48, ignore as a likely string conversion
 */
class IgnorableExpr48Mapping extends IgnorableOperation {
  IgnorableExpr48Mapping() {
    exists(SubExpr child | this.(Operation).getAChild*() = child |
      child.getRightOperand().(Literal).getValue().toInt() = 48
      or
      child.getRightOperand().(CharLiteral).getValue().toInt() = 48
    )
  }
}

/**
 * if doing any kind of operation involving multiplying 10, 100, 1000, etc., likely some kind of conversion
 * and ignorable
 */
class IgnorableExpr10MulipleComponent extends IgnorableOperation {
  IgnorableExpr10MulipleComponent() {
    this.(Operation).getAChild*().(MulExpr).getAnOperand().(Literal).getValue().toInt() in [
        10, 100, 100
      ]
    or
    exists(AssignMulExpr a | this = a or a.getRValue() = this |
      a.getRValue().getAChild*().(Literal).getValue().toInt() in [10, 100, 100]
    )
  }
}

/*
 * linux time conversions expect the year to start from 1900, so subtracting or
 * adding 1900 or anything involving 1900 as a generalization is probably
 * a conversion that is ignorable
 */

class IgnorableExprExpr1900Mapping extends IgnorableOperation {
  IgnorableExprExpr1900Mapping() {
    this.(Operation).getAnOperand().getAChild*().(Literal).getValue().toInt() = 1900
    or
    exists(AssignArithmeticOperation a | this = a or this = a.getRValue() |
      a.getRValue().getAChild*().(Literal).getValue().toInt() = 1900
    )
    // or
    // this.(Literal).getValue().toInt() = 1900
  }
}

predicate isOperationSourceCandidate(Expr e) {
  e instanceof SubExpr
  or
  e instanceof AddExpr
  or
  e instanceof CrementOperation
  or
  exists(AssignSubExpr a | a.getRValue() = e)
  or
  exists(AssignAddExpr a | a.getRValue() = e)
}

class OperationSource extends Expr {
  OperationSource() {
    // operation source candidates that aren't nested inside other operation source candidates
    isOperationSourceCandidate(this) and
    not exists(Expr parent | isOperationSourceCandidate(parent) | parent.getAChild+() = this) and
    not this instanceof IgnorableOperation and
    not this.getEnclosingFunction() instanceof IgnorableFunction
  }
}

/**
 * An assignment to a year field, which will be a sink
 * NOTE: could not make this abstract, it was binding to all expressions
 */
abstract class YearFieldAssignment extends Expr {
  abstract YearFieldAccess getYearFieldAccess();
}

/**
 * An assignment to x ie `x = a`.
 */
class YearFieldAssignmentAccess extends YearFieldAssignment {
  YearFieldAccess access;

  YearFieldAssignmentAccess() {
    // TODO: why can't I make this just the L value? Doesn't seem to work
    exists(Assignment a |
      a.getLValue() = access and
      a.getRValue() = this
    )
  }

  override YearFieldAccess getYearFieldAccess() { result = access }
}

/**
 * A year field assignment, by a unary operator ie `x++`.
 */
class YearFieldAssignmentUnary extends YearFieldAssignment instanceof CrementOperation {
  YearFieldAccess access;

  YearFieldAssignmentUnary() { this.getOperand() = access }

  override YearFieldAccess getYearFieldAccess() { result = access }
}

/**
 * An access to either a Month or Day.
 */
class MonthOrDayFieldAccess extends FieldAccess {
  MonthOrDayFieldAccess() {
    this instanceof MonthFieldAccess
    or
    this instanceof DayFieldAccess
  }
}

class OperationNode extends DataFlow::Node{
    OperationNode(){
      this.asExpr() instanceof Operation
      or
      this.asExpr() instanceof AssignArithmeticOperation
    }
}

/**
 * An access or assignment to a Year field.
 */
class YearFieldAccessNode extends DataFlow::Node{
    YearFieldAccessNode(){
        this.asExpr() instanceof YearFieldAssignment
        or
        this.asExpr() instanceof YearFieldAccess
    }
}

/**
 * Flow for non operation candidate sources to year assignments to detect
 * ignorable functions.
 * If the ignorable operation flows to a year assignment and the source and sink
 * are in the same function, we will consider that function ignorable.
 */
module IgnorableOperationToYearConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node n) {
    n instanceof OperationNode and
    not isOperationSourceCandidate(n.asExpr())
  }

  predicate isSink(DataFlow::Node n) {
    n instanceof YearFieldAccessNode
  }

  // looking for sources and sinks in the same function
  DataFlow::FlowFeature getAFeature() {
    result instanceof DataFlow::FeatureEqualSourceSinkCallContext
  }

  predicate isBarrierOut(DataFlow::Node n) { isSink(n) }
}

module IgnorableOperationToYearFlow = TaintTracking::Global<IgnorableOperationToYearConfig>;

module YearToIgnorableOperationConfig implements DataFlow::ConfigSig {
  predicate isSink(DataFlow::Node n) {
    n instanceof OperationNode and
    not isOperationSourceCandidate(n.asExpr())
  }

  predicate isSource(DataFlow::Node n) {
    n instanceof YearFieldAccessNode
  }

  // looking for sources and sinks in the same function
  DataFlow::FlowFeature getAFeature() {
    result instanceof DataFlow::FeatureEqualSourceSinkCallContext
  }

  predicate isBarrierOut(DataFlow::Node n) { isSink(n) }
}

module YearToIgnorableOperationFlow = TaintTracking::Global<YearToIgnorableOperationConfig>;

class IgnorableFunction extends Function {
  IgnorableFunction() { isIgnorableFunction(this) }
}

predicate isIgnorableFunction(Function f) {
  exists(IgnorableOperationToYearFlow::PathNode sink |
    sink.getNode().asExpr().getEnclosingFunction() = f and
    sink.isSink()
  )
  or
  exists(YearToIgnorableOperationFlow::PathNode sink |
    sink.getNode().asExpr().getEnclosingFunction() = f and
    sink.isSink()
  )
}

/**
 * A DataFlow configuration for identifying flows from some non trivial access or literal
 * to the Year field of a date object.
 */
module OperationToYearAssignmentConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node n) { n.asExpr() instanceof OperationSource }

  predicate isSink(DataFlow::Node n) { n.asExpr() instanceof YearFieldAssignment }

  predicate isBarrier(DataFlow::Node n) {
    exists(ArrayExpr arr | arr.getArrayOffset() = n.asExpr())
    or
    n.asExpr().getUnspecifiedType() instanceof PointerType
    or
    n.asExpr() instanceof IgnorableOperation
    or
    exists(ChecksForLeapYearFunctionCall fc | fc.getAnArgument() = n.asExpr())
    or
    n.asExpr().getEnclosingFunction() instanceof IgnorableFunction
  }
}

module OperationToYearAssignmentFlow = TaintTracking::Global<OperationToYearAssignmentConfig>;

predicate isYearModifiedWithCheck(YearFieldAccess fa) {
  // If there is a local check for leap year after the modification
  exists(LeapYearFieldAccess yfacheck, Variable var, YearFieldAccess yfa |
    // TODO: cleanup
    yfa = fa and
    var.getAnAccess() = fa.getQualifier() and
    yfacheck.getQualifier() = var.getAnAccess() and
    yfacheck.isUsedInCorrectLeapYearCheck() and
    yfacheck.getBasicBlock() = yfa.getBasicBlock().getASuccessor*()
  )
  or
  // If there is a data flow from the variable that was modified to a function that seems to check for leap year
  exists(VariableAccess source, ChecksForLeapYearFunctionCall fc, Variable var |
    var.getAnAccess() = fa.getQualifier() and
    source = var.getAnAccess() and
    LeapYearCheckFlow::flow(DataFlow::exprNode(source), DataFlow::exprNode(fc.getAnArgument()))
  )
  or
  // If there is a data flow from the field that was modified to a function that seems to check for leap year
  exists(
    VariableAccess vacheck, YearFieldAccess yfacheck, ChecksForLeapYearFunctionCall fc, Variable var
  |
    // TODO: cleanup
    var.getAnAccess() = fa.getQualifier() and
    vacheck = var.getAnAccess() and
    yfacheck.getQualifier() = vacheck and
    LeapYearCheckFlow::flow(DataFlow::exprNode(yfacheck), DataFlow::exprNode(fc.getAnArgument()))
  )
}

import OperationToYearAssignmentFlow::PathGraph

from OperationToYearAssignmentFlow::PathNode src, OperationToYearAssignmentFlow::PathNode sink
where
  OperationToYearAssignmentFlow::flowPath(src, sink) and
  not isYearModifiedWithCheck(sink.getNode().asExpr().(YearFieldAssignment).getYearFieldAccess())
select sink, src, sink, "TEST"
