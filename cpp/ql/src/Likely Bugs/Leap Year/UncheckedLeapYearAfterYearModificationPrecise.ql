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
import semmle.code.cpp.controlflow.IRGuards

/**
 * The set of expressions which are ignorable; either because they seem to not be part of a year mutation,
 * or because they seem to be a conversion pattern of mapping date scalars.
 */
abstract class IgnorableOperation extends Expr { }

class IgnorableExprRem extends IgnorableOperation instanceof RemExpr { }

/**
 * Anything involving a sub expression with char literal 48, ignore as a likely string conversion
 */
class IgnorableExpr10MulipleComponent extends IgnorableOperation {
  IgnorableExpr10MulipleComponent() {
    this.(MulExpr).getAnOperand().getValue().toInt() in [10, 100, 100]
    or
    exists(AssignMulExpr a | a.getRValue() = this |
      a.getRValue().getValue().toInt() in [10, 100, 100]
    )
  }
}

/**
 * Anything involving a sub expression with char literal 48, ignore as a likely string conversion
 * e.g., X - '0'
 */
class IgnorableExpr48Mapping extends IgnorableOperation {
  IgnorableExpr48Mapping() {
    this.(SubExpr).getRightOperand().getValue().toInt() = 48
    or
    exists(AssignSubExpr e | e.getRValue() = this | e.getRValue().getValue().toInt() = 48)
  }
}

class IgnorableCharLiteralArithmetic extends IgnorableOperation {
  IgnorableCharLiteralArithmetic() {
    exists(this.(BinaryArithmeticOperation).getAnOperand().(TextLiteral).getValue())
    or
    exists(AssignArithmeticOperation e | e.getRValue() = this |
      exists(this.(TextLiteral).getValue())
    )
  }
}

/*
 * linux time conversions expect the year to start from 1900, so subtracting or
 * adding 1900 or anything involving 1900 as a generalization is probably
 * a conversion that is ignorable
 */

predicate isLikelyConversionConstant(int c) {
  c = 146097 or // days in 400-year Gregorian cycle
  c = 36524 or // days in 100-year Gregorian subcycle
  c = 1461 or // days in 4-year cycle (incl. 1 leap)
  c = 32044 or // Fliegel–van Flandern JDN epoch shift
  c = 1721425 or // JDN of 0001‑01‑01 (Gregorian)
  c = 1721119 or // alt epoch offset
  c = 2400000 or // MJD → JDN conversion
  c = 2400001 or
  c = 2400000 or
  c = 2141 or // fixed‑point month/day extraction
  c = 2000 or
  c = 65536 or
  c = 7834 or
  c = 256 or
  c = 1900 // struct tm base‑year offset; harmless
}

/**
 * Some constants indicate conversion that are ignorable, e.g.,
 * julian to gregorian conversion or conversions from linux time structs
 * that start at 1900, etc.
 */
class IgnorableConstantArithmetic extends IgnorableOperation {
  IgnorableConstantArithmetic() {
    exists(int i | isLikelyConversionConstant(i) |
      this.(Operation).getAnOperand().getValue().toInt() = i
      or
      exists(AssignArithmeticOperation a | this = a.getRValue() |
        a.getRValue().getValue().toInt() = i
      )
    )
  }
}

// If a unary minus assume it is some sort of conversion
class IgnorableUnaryMinus extends IgnorableOperation instanceof UnaryMinusExpr { }

class IgnorableBinaryBitwiseOperation extends IgnorableOperation instanceof BinaryBitwiseOperation {
}

class IgnorableUnaryBitwiseOperation extends IgnorableOperation instanceof UnaryBitwiseOperation { }

class IgnorableAssignmentBitwiseOperation extends IgnorableOperation instanceof AssignBitwiseOperation
{ }

/**
 * Any arithmetic operation where one of the operands is a pointer or char type, ignore it
 */
class IgnorablePointerOrCharArithmetic extends IgnorableOperation {
  IgnorablePointerOrCharArithmetic() {
    this instanceof BinaryArithmeticOperation and
    (
      this.(BinaryArithmeticOperation).getAnOperand().getUnspecifiedType() instanceof PointerType
      or
      this.(BinaryArithmeticOperation).getAnOperand().getUnspecifiedType() instanceof CharType
    )
    or
    exists(AssignArithmeticOperation a | a.getRValue() = this |
      a.getAnOperand().getUnspecifiedType() instanceof PointerType
      or
      a.getAnOperand().getUnspecifiedType() instanceof CharType
    )
  }
}

/**
 * An expression that is a candidate source for an dataflow configuration for an Operation that could flow to a Year field.
 */
predicate isOperationSourceCandidate(Expr e) {
  not e instanceof IgnorableOperation and
  (
    e instanceof SubExpr
    or
    e instanceof AddExpr
    or
    e instanceof CrementOperation
    or
    exists(AssignSubExpr a | a.getRValue() = e)
    or
    exists(AssignAddExpr a | a.getRValue() = e)
  )
}

/**
 * A Dataflow that identifies flows from an Operation (addition, subtraction, etc) to some ignorable operation (bitwise operations for example) that disqualify it
 */
module OperationSourceCandidateToIgnorableOperationConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node n) { isOperationSourceCandidate(n.asExpr()) }

  predicate isSink(DataFlow::Node n) { n.asExpr() instanceof IgnorableOperation }

  // looking for sources and sinks in the same function
  DataFlow::FlowFeature getAFeature() {
    result instanceof DataFlow::FeatureEqualSourceSinkCallContext
  }

  predicate isBarrierOut(DataFlow::Node n) { isSink(n) }
}

module OperationSourceCandidateToIgnorableOperationFlow =
  TaintTracking::Global<OperationSourceCandidateToIgnorableOperationConfig>;

/**
 * A dataflow that tracks an ignorable operation (eg. bitwise op) to a operation source, so we may disqualify it.
 */
module IgnorableOperationToOperationSourceCandidateConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node n) { n.asExpr() instanceof IgnorableOperation }

  predicate isSink(DataFlow::Node n) { isOperationSourceCandidate(n.asExpr()) }

  // looking for sources and sinks in the same function
  DataFlow::FlowFeature getAFeature() {
    result instanceof DataFlow::FeatureEqualSourceSinkCallContext
  }
}

module IgnorableOperationToOperationSourceCandidateFlow =
  TaintTracking::Global<IgnorableOperationToOperationSourceCandidateConfig>;

/**
 * The set of all expressions which is a candidate expression and also does not flow from to to some ignorable expression (eg. bitwise op)
 * ```
 * a = something <<< 2;
 * myDate.year = a + 1;        // invalid
 * ...
 * a = someDate.year + 1;
 * myDate.year = a;            // valid
 * ```
 */
class OperationSource extends Expr {
  OperationSource() {
    isOperationSourceCandidate(this) and
    not exists(OperationSourceCandidateToIgnorableOperationFlow::PathNode src |
      src.getNode().asExpr() = this and
      src.isSource()
    ) and
    not exists(IgnorableOperationToOperationSourceCandidateFlow::PathNode sink |
      sink.getNode().asExpr() = this and
      sink.isSink()
    )
  }
}

class YearFieldAssignmentNode extends DataFlow::Node {
  YearFieldAssignmentNode() {
    this.asExpr() instanceof YearFieldAssignment
    // or
    // this.asDefiningArgument() instanceof YearFieldAccess
    // or
    // // TODO: is there a better way to do this?
    // // i.e., without having to be cognizant of the addressof
    // // occurring, especially if this occurs on a dataflow
    // exists(AddressOfExpr aoe |
    //   aoe = this.asDefiningArgument() and
    //   aoe.getOperand() instanceof YearFieldAccess
    // )
  }

  YearFieldAccess getYearFieldAccess() {
    result = this.asDefiningArgument() or
    result = this.asExpr().(YearFieldAssignment).getYearFieldAccess()
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
 * A DataFlow configuration for identifying flows from some non trivial access or literal
 * to the Year field of a date object.
 */
module OperationToYearAssignmentConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node n) { n.asExpr() instanceof OperationSource }

  predicate isSink(DataFlow::Node n) { n instanceof YearFieldAssignmentNode }

  predicate isBarrier(DataFlow::Node n) {
    exists(ArrayExpr arr | arr.getArrayOffset() = n.asExpr())
    or
    n.asExpr().getUnspecifiedType() instanceof PointerType
    or
    n.asExpr().getUnspecifiedType() instanceof CharType
    or
    n.asExpr() instanceof IgnorableOperation
    or
    isLeapYearCheckSink(n)
  }

  // Block flow out of an operation source to get the "closest" operation to the sink
  predicate isBarrierIn(DataFlow::Node n) { isSource(n) }

  predicate isBarrierOut(DataFlow::Node n) { isSink(n) }
  // DataFlow::FlowFeature getAFeature() { result instanceof DataFlow::FeatureHasSourceCallContext }
}

module OperationToYearAssignmentFlow = TaintTracking::Global<OperationToYearAssignmentConfig>;

predicate isLeapYearCheckSink(DataFlow::Node sink) {
  exists(ExprCheckLeapYear e | sink.asExpr() = e.getAChild*())
  or
  // Local leap year check
  sink.asExpr().(LeapYearFieldAccess).isUsedInCorrectLeapYearCheck()
  or
  // passed to function that seems to check for leap year
  exists(ChecksForLeapYearFunctionCall fc |
    sink.asExpr() = fc.getAnArgument()
    or
    sink.asExpr() = fc.getAnArgument().(FieldAccess).getQualifier()
    or
    exists(AddressOfExpr aoe |
      fc.getAnArgument() = aoe and
      aoe.getOperand() = sink.asExpr()
    )
  )
}

/**
 * A flow configuration from a Year field access to some Leap year check or guard
 */
module YearFieldAccessToLeapYearCheckConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) { source instanceof YearFieldAssignmentNode }

  predicate isSink(DataFlow::Node sink) { isLeapYearCheckSink(sink) }

  predicate isAdditionalFlowStep(DataFlow::Node node1, DataFlow::Node node2) {
    // flow from a YearFieldAccess to the qualifier
    node2.asExpr() = node1.asExpr().(YearFieldAccess).getQualifier()
  }

  // Use this to make the sink for leap year check intra-proc only
  // i.e., the sink must be in the same scope (function) as the source.
  // DataFlow::FlowFeature getAFeature() {
  //   result instanceof DataFlow::FeatureEqualSourceSinkCallContext
  // }
  /**
   * Enforcing the check must occur in the same call context as the source,
   * i.e., do not return from the source function and check in a caller.
   */
  DataFlow::FlowFeature getAFeature() { result instanceof DataFlow::FeatureHasSourceCallContext }
}

module YearFieldAccessToLeapYearCheckFlow =
  TaintTracking::Global<YearFieldAccessToLeapYearCheckConfig>;

/** Does there exist a flow from the given YearFieldAccess to a Leap Year check or guard? */
predicate isYearModifiedWithCheck(YearFieldAccess fa) {
  exists(YearFieldAccessToLeapYearCheckFlow::PathNode src |
    src.isSource() and
    src.getNode().asExpr().(YearFieldAssignment).getYearFieldAccess() = fa
  )
  or
  isUsedInFeb29Check(fa)
}

/**
 * If there is a flow from a date struct year field access/assignment to a Feb 29 check
 */
predicate isUsedInFeb29Check(YearFieldAccess fa) {
  exists(DateFebruary29Check check |
    DataFlow::localExprFlow(fa.getQualifier(), check.getDateQualifier())
    or
    DataFlow::localExprFlow(check.getDateQualifier(), fa.getQualifier())
  )
}

class MonthEqualityCheck extends EqualityOperation{
  MonthEqualityCheck(){
    this.getAnOperand() instanceof MonthFieldAccess
  }

  Expr getExprCompared(){
    exists(Expr e |
      e = this.getAnOperand() and
      not e instanceof MonthFieldAccess and
      result = e
    )
  }

  MonthFieldAccess getMonthFieldAccess(){
    result = this.getAnOperand()
  }
}

class MonthEqualityCheckGuard extends GuardCondition instanceof MonthEqualityCheck{
  MonthEqualityCheckGuard(){ any() }
}

bindingset[e]
pragma[inline_late]
predicate isControlledByMonthEqualityCheckNonFebruary(Expr e){
  exists(MonthEqualityCheckGuard monthGuard |
    monthGuard.controls(e.getBasicBlock(), true) and
    not monthGuard.(MonthEqualityCheck).getExprCompared().getValueText() = "2"
  )
}

import OperationToYearAssignmentFlow::PathGraph

from OperationToYearAssignmentFlow::PathNode src, OperationToYearAssignmentFlow::PathNode sink
where
  OperationToYearAssignmentFlow::flowPath(src, sink) and
  not isYearModifiedWithCheck(sink.getNode().asExpr().(YearFieldAssignment).getYearFieldAccess()) and
  not isControlledByMonthEqualityCheckNonFebruary(sink.getNode().asExpr())
select sink, src, sink, "TEST"
