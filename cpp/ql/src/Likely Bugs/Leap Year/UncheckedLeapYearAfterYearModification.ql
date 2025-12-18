/**
 * @name Year field changed using an arithmetic operation without checking for leap year (AntiPattern 1)
 * @description A field that represents a year is being modified by an arithmetic operation, but no proper check for leap years can be detected afterwards.
 * @kind problem
 * @problem.severity warning
 * @id cpp/microsoft/public/leap-year/unchecked-after-arithmetic-year-modification
 * @precision medium
 * @tags leap-year
 *       correctness
 */

import cpp
import LeapYear

/**
 * Holds if there is no known leap-year verification for the given `YearWriteOp`.
 * Binds the `var` argument to the qualifier of the `ywo` argument.
 */
bindingset[ywo]
predicate isYearModifedWithoutExplicitLeapYearCheck(Variable var, YearWriteOp ywo) {
  exists(VariableAccess va, YearFieldAccess yfa |
    yfa = ywo.getYearAccess() and
    yfa.getQualifier() = va and
    var.getAnAccess() = va and
    // Avoid false positives
    not (
      // If there is a local check for leap year after the modification
      exists(LeapYearFieldAccess yfacheck |
        yfacheck.getQualifier() = var.getAnAccess() and
        yfacheck.isUsedInCorrectLeapYearCheck() and
        yfacheck.getBasicBlock() = yfa.getBasicBlock().getASuccessor*()
      )
      or
      // If there is a data flow from the variable that was modified to a function that seems to check for leap year
      exists(VariableAccess source, ChecksForLeapYearFunctionCall fc |
        source = var.getAnAccess() and
        LeapYearCheckFlow::flow(DataFlow::exprNode(source), DataFlow::exprNode(fc.getAnArgument()))
      )
      or
      // If there is a data flow from the field that was modified to a function that seems to check for leap year
      exists(VariableAccess vacheck, YearFieldAccess yfacheck, ChecksForLeapYearFunctionCall fc |
        vacheck = var.getAnAccess() and
        yfacheck.getQualifier() = vacheck and
        LeapYearCheckFlow::flow(DataFlow::exprNode(yfacheck), DataFlow::exprNode(fc.getAnArgument()))
      )
      or
      // If there is a successor or predecessor that sets the month or day to a fixed value
      exists(FieldAccess mfa, AssignExpr ae, int val |
        mfa instanceof MonthFieldAccess or mfa instanceof DayFieldAccess
      |
        mfa.getQualifier() = var.getAnAccess() and
        mfa.isModified() and
        (
          mfa.getBasicBlock() = yfa.getBasicBlock().getASuccessor*() or
          yfa.getBasicBlock() = mfa.getBasicBlock().getASuccessor+()
        ) and
        ae = mfa.getEnclosingElement() and
        ae.getAnOperand().getValue().toInt() = val
      )
    )
  )
}

/**
 * The set of all write operations to the Year field of a date struct.
 */
abstract class YearWriteOp extends Operation {
  /** Extracts the access to the Year field */
  abstract YearFieldAccess getYearAccess();

  /** Get the expression which represents the new value. */
  abstract Expr getMutationExpr();
}

/**
 * A unary operation (Crement) performed on a Year field.
 */
class YearWriteOpUnary extends YearWriteOp, UnaryArithmeticOperation {
  YearWriteOpUnary() { this.getOperand() instanceof YearFieldAccess }

  override YearFieldAccess getYearAccess() { result = this.getOperand() }

  override Expr getMutationExpr() { result = this }
}

/**
 * An assignment operation or mutation on the Year field of a date object.
 */
class YearWriteOpAssignment extends YearWriteOp, AssignExpr {
  Expr mutationExpr;

  YearWriteOpAssignment() {
    this.getLValue() instanceof YearFieldAccess and
    exists(DataFlow::Node source, DataFlow::Node sink |
      sink.asExpr() = this.getRValue() and
      OperationToYearAssignmentFlow::flow(source, sink) and
      mutationExpr = source.asExpr()
    ) and
    not this.getRValue() instanceof LikelyAToIOperation
  }

  override YearFieldAccess getYearAccess() { result = this.getLValue() }

  override Expr getMutationExpr() { result = mutationExpr }
}

class YearArithmetiWriteOpArithmeticAssignment extends YearWriteOp, AssignArithmeticOperation {
  YearArithmetiWriteOpArithmeticAssignment() {
    this.getLValue() instanceof YearFieldAccess and
    not this instanceof AssignRemExpr and
    not this.getRValue() instanceof LikelyAToIOperation
  }

  override YearFieldAccess getYearAccess() { result = this.getLValue() }

  override Expr getMutationExpr() { result = this }
}

class LikelyAToIOperation extends Operation {
  LikelyAToIOperation() {
    this.(SubExpr).getLeftOperand().getUnspecifiedType() instanceof CharType and
    this.(SubExpr).getRightOperand().(Literal).getValue().toInt() = 48
    or
    this.(SubExpr).getRightOperand().(CharLiteral).getValue().toInt() = 48
    or
    this.(MulExpr).getLeftOperand().(Literal).getValue().toInt() % 10 = 0
    or
    this instanceof UnaryMinusExpr
  }
}

/**
 * A DataFlow configuration for identifying flows from some non trivial access or literal
 * to the Year field of a date object.
 */
module OperationToYearAssignmentConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node n) {
    (
      n.asExpr() instanceof BinaryArithmeticOperation
      or
      n.asExpr() instanceof UnaryArithmeticOperation
    ) and
    not n.asExpr() instanceof LikelyAToIOperation and
    not n.asExpr().(MulExpr).getAnOperand() instanceof LikelyAToIOperation and
    not n.asExpr() instanceof RemExpr and
    not n.asExpr() instanceof UnaryMinusExpr and
    // not n.asExpr() instanceof AssignRemExpr and
    not n.getType().getUnspecifiedType() instanceof PointerType and
    // TODO: or if this is part of an operation
    not exists(SubExpr atoi, Literal zero |
      n.asExpr() = atoi and
      zero = atoi.getAnOperand() and
      zero.getValue().toInt() = 0
    )
  }

  predicate isSink(DataFlow::Node n) {
    exists(Assignment a |
      a.getLValue() instanceof YearFieldAccess and
      a.getRValue() = n.asExpr()
    )
  }

  predicate isBarrier(DataFlow::Node n) {
    exists(ArrayExpr arr | arr.getArrayOffset() = n.asExpr())
    or
    n.asExpr().getUnspecifiedType() instanceof PointerType
    or
    n.asExpr() instanceof LikelyAToIOperation
  }
}

module OperationToYearAssignmentFlow = TaintTracking::Global<OperationToYearAssignmentConfig>;

from Variable var, YearWriteOp ywo, Expr mutationExpr
where
  mutationExpr = ywo.getMutationExpr() and
  isYearModifedWithoutExplicitLeapYearCheck(var, ywo) and
  not isNormalizationOperation(mutationExpr) and
  // not ywo instanceof AddressOfExpr and
  not exists(Call c, TimeConversionFunction f | f.getACallToThisFunction() = c |
    c.getAnArgument().getAChild*() = var.getAnAccess() and
    ywo.getASuccessor*() = c
  )
select ywo,
  "$@: Field $@ on variable $@ has been modified, but no appropriate check for LeapYear was found.",
  ywo.getEnclosingFunction(), ywo.getEnclosingFunction().toString(),
  ywo.getYearAccess().getTarget(), ywo.getYearAccess().getTarget().toString(), var, var.toString()
