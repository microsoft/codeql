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
abstract class IgnorableOperationSource extends Expr {}

class IgnorableExprAssignRem extends IgnorableOperationSource instanceof AssignRemExpr{}
class IgnorableExprRem extends IgnorableOperationSource instanceof RemExpr{}
class IgnorableExprUnaryMinus extends IgnorableOperationSource instanceof UnaryMinusExpr{}
/**
 * Ignore any operation that is nested inside a larger operation, assume the larger operation is the real source
 * */
class IgnorableExprNestedExpr extends IgnorableOperationSource instanceof BinaryArithmeticOperation{
    IgnorableExprNestedExpr(){
        exists(BinaryArithmeticOperation parentOp |
            parentOp.getAChild+() = this
        )
    }
}

/**
 * Anything involving a sub expression with char literal 48, ignore as a likely string conversion
 */
class IgnorableExpr48Mapping extends IgnorableOperationSource{
    IgnorableExpr48Mapping(){
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
class IgnorableExpr10MulipleComponent extends IgnorableOperationSource{
    IgnorableExpr10MulipleComponent(){
        this.(Operation).getAChild*().(MulExpr).getAnOperand().(Literal).getValue().toInt() % 10 = 0
        or
        this.(AssignMulExpr).getRValue().(Literal).getValue().toInt() % 10 = 0
    }
}

/*
 * linux time conversions expect the year to start from 1900, so subtracting or
 * adding 1900 or anything involving 1900 as a generalization is probably
 * a conversion that is ignorable
 * */
class IgnorableExprExpr1900Mapping extends IgnorableOperationSource instanceof Operation{
  IgnorableExprExpr1900Mapping() {
    this.(Operation).getAnOperand().getAChild*().(Literal).getValue().toInt() = 1900
  }
}

class OperationSource extends Expr {
  OperationSource() {
    (
      this instanceof BinaryArithmeticOperation
      or
      this instanceof UnaryArithmeticOperation
      or
      exists(AssignArithmeticOperation a | a.getRValue() = this)
    ) and
    not this instanceof IgnorableOperationSource
  }
}

/**
 * An assignment to a year field, which will be a sink
 */
abstract class YearFieldAssignment extends Expr{}

/**
 * An assignment to x ie `x = a`.
 */
class YearFieldAssignmentAccess extends YearFieldAssignment{
    YearFieldAssignmentAccess(){
        // TODO: why can't I make this just the L value? Doesn't seem to work
        exists(Assignment a |
            a.getLValue() instanceof YearFieldAccess and
            a.getRValue() = this
        )
    }
}

/**
 * 
 */
class YearFieldAssignmentUnary extends YearFieldAssignment instanceof UnaryArithmeticOperation{
    YearFieldAssignmentUnary(){
        this.getOperand() instanceof YearFieldAccess and
    }
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
    n.asExpr() instanceof IgnorableOperationSource
    or
    exists(ChecksForLeapYearFunctionCall fc | fc.getAnArgument() = n.asExpr())
  }
}

module OperationToYearAssignmentFlow = TaintTracking::Global<OperationToYearAssignmentConfig>;
import OperationToYearAssignmentFlow::PathGraph

from OperationToYearAssignmentFlow::PathNode src, OperationToYearAssignmentFlow::PathNode sink
where OperationToYearAssignmentFlow::flowPath(src, sink)
select sink, src, sink, "TEST"