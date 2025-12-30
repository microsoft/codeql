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

class IgnorableExprRem extends IgnorableOperation instanceof RemExpr { }

/**
 * Anything involving a sub expression with char literal 48, ignore as a likely string conversion
 */
class IgnorableExpr10MulipleComponent extends IgnorableOperation {
  IgnorableExpr10MulipleComponent() {
    this.(MulExpr).getAnOperand().(Literal).getValue().toInt() in [10, 100, 100]
    or
    exists(AssignMulExpr a | a.getRValue() = this |
      a.getRValue().(Literal).getValue().toInt() in [10, 100, 100]
    )
  }
}

/**
 * Anything involving a sub expression with char literal 48, ignore as a likely string conversion
 * e.g., X - '0'
 */
class IgnorableExpr48Mapping extends IgnorableOperation {
  IgnorableExpr48Mapping() {
    this.(SubExpr).getRightOperand().(Literal).getValue().toInt() = 48
    or
    exists(AssignSubExpr e | e.getRValue() = this | e.getRValue().(Literal).getValue().toInt() = 48)
  }
}

/*
 * linux time conversions expect the year to start from 1900, so subtracting or
 * adding 1900 or anything involving 1900 as a generalization is probably
 * a conversion that is ignorable
 */

class IgnorableExprExpr1900Mapping extends IgnorableOperation {
  IgnorableExprExpr1900Mapping() {
    this.(Operation).getAnOperand().(Literal).getValue().toInt() = 1900
    or
    exists(AssignArithmeticOperation a | this = a.getRValue() |
      a.getRValue().(Literal).getValue().toInt() = 1900
    )
  }
}

class IgnorableBinaryBitwiseOperation extends IgnorableOperation instanceof BinaryBitwiseOperation {
}

class IgnorableUnaryBitwiseOperation extends IgnorableOperation instanceof UnaryBitwiseOperation { }

class IgnorableAssignmentBitwiseOperation extends IgnorableOperation instanceof AssignBitwiseOperation
{ }

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

  predicate isSink(DataFlow::Node n) { n.asExpr() instanceof YearFieldAssignment }

  predicate isBarrier(DataFlow::Node n) {
    exists(ArrayExpr arr | arr.getArrayOffset() = n.asExpr())
    or
    n.asExpr().getUnspecifiedType() instanceof PointerType
    or
    n.asExpr() instanceof IgnorableOperation
  }
}

module OperationToYearAssignmentFlow = TaintTracking::Global<OperationToYearAssignmentConfig>;

/**
 * A Dataflow configuration for tracing from one OperationToYearAssignmentFlow source to another OperationToYearAssignmentFlow source.
 */
module KnownYearOpSourceToKnownYearOpSourceConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node n) {
    exists(OperationToYearAssignmentFlow::PathNode src |
      src.getNode().asExpr() = n.asExpr() and
      src.isSource()
    )
  }

  predicate isSink(DataFlow::Node n) {
    exists(OperationToYearAssignmentFlow::PathNode src |
      src.getNode().asExpr() = n.asExpr() and
      src.isSource()
    )
  }
}

module KnownYearOpSourceToKnownYearOpSourceFlow =
  TaintTracking::Global<KnownYearOpSourceToKnownYearOpSourceConfig>;

/**
 * There does not exist an OperationSource that flows through this given OperationSource expression.
 */
predicate isRootOperationSource(OperationSource e) {
  not exists(DataFlow::Node src, DataFlow::Node sink |
    src != sink and
    KnownYearOpSourceToKnownYearOpSourceFlow::flow(src, sink) and
    sink.asExpr() = e
  )
}

/**
 * A flow configuration from a Year field access to some Leap year check or guard
 */
module YearFieldAccessToLeapYearCheckConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) { source.asExpr() instanceof YearFieldAccess }

  predicate isSink(DataFlow::Node sink) {
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

  predicate isAdditionalFlowStep(DataFlow::Node node1, DataFlow::Node node2) {
    // flow from a YearFieldAccess to the qualifier
    node1.asExpr() instanceof YearFieldAccess and
    node2.asExpr() = node1.asExpr().(YearFieldAccess).getQualifier()
  }
  // Use this to make the sink for leap year check intra-proc only
  // i.e., the sink must be in the same scope (function) as the source.
  // DataFlow::FlowFeature getAFeature() {
  //   result instanceof DataFlow::FeatureEqualSourceSinkCallContext
  // }
}

module YearFieldAccessToLeapYearCheckFlow =
  TaintTracking::Global<YearFieldAccessToLeapYearCheckConfig>;

/** Does there exist a flow from the given YearFieldAccess to a Leap Year check or guard? */
predicate isYearModifiedWithCheck(YearFieldAccess fa) {
  exists(YearFieldAccessToLeapYearCheckFlow::PathNode src |
    src.isSource() and
    src.getNode().asExpr() = fa
  )
}

import OperationToYearAssignmentFlow::PathGraph

from OperationToYearAssignmentFlow::PathNode src, OperationToYearAssignmentFlow::PathNode sink
where
  OperationToYearAssignmentFlow::flowPath(src, sink) and
  isRootOperationSource(src.getNode().asExpr()) and
  not isYearModifiedWithCheck(sink.getNode().asExpr().(YearFieldAssignment).getYearFieldAccess())
select sink, src, sink, "TEST"
