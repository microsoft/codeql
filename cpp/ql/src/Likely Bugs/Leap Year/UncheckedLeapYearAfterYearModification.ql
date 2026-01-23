/**
 * @name Year field changed using an arithmetic operation without checking for leap year (AntiPattern 1)
 * @description A field that represents a year is being modified by an arithmetic operation, but no proper check for leap years can be detected afterwards.
 * @kind path-problem
 * @problem.severity warning
 * @id cpp/microsoft/public/leap-year/unchecked-after-arithmetic-year-modification
 * @precision medium
 * @tags leap-year
 *       correctness
 */

import cpp
import LeapYear
import semmle.code.cpp.controlflow.IRGuards
import semmle.code.cpp.dataflow.new.TaintTracking
import semmle.code.cpp.commons.DateTime

/**
 * Functions whose operations should never be considered a
 * source or sink of a dangerous leap year operation.
 * The general concept is to add conversion functions
 * that convert one time type to another. Often
 * other ignorable operation heuristics will filter these,
 * but some cases, the simplest approach is to simply filter
 * the function entirely.
 * Note that flow through these functions should still be allowed
 * we just cannot start or end flow from an operation to a
 * year assignment in one of these functions.
 */
class IgnorableFunction extends Function {
  IgnorableFunction() {
    this instanceof TimeConversionFunction
    or
    // Helper utility in postgres with string time conversions
    this.getName() = "DecodeISO8601Interval"
    or
    // helper utility for date conversions in qtbase
    this.getName() = "adjacentDay"
    or
    // Windows API function that does timezone conversions
    this.getName().matches("%SystemTimeToTzSpecificLocalTime%")
    or
    // Windows APIs that do time conversions
    this.getName().matches("%localtime%\\_s%")
    or
    // Windows APIs that do time conversions
    this.getName().matches("%SpecificLocalTimeToSystemTime%")
    or
    // postgres function for diffing timestamps, date for leap year
    // is not applicable.
    this.getName().toLowerCase().matches("%timestamp%age%")
    or
    // Reading byte streams often involves operations of some base, but that's
    // not a real source of leap year issues.
    this.getName().toLowerCase().matches("%read%bytes%")
    or
    // A postgres function for local time conversions
    // conversion operations (from one time structure to another) are generally ignorable
    this.getName() = "localsub"
    or
    // Hijri years are not applicable for gregorian leap year checks
    this.getName().toLowerCase().matches("%hijri%")
    or
    this.getFile().getBaseName().toLowerCase().matches("%hijri%")
    or
    // Persian calendar conversions are not applicable for gregorian leap year checks
    this.getName().toLowerCase().matches("%persian%")
    or
    this.getFile().getBaseName().toLowerCase().matches("%persian%")
    // or
    // // Functions with "convert" in the name are often conversion functions
    // // This is a very broad heuristic to handle a few observed false positives
    // // involving conversions with Hijri years.
    // this.getName().toLowerCase().matches("%convert%")
  }
}

/**
 * The set of expressions which are ignorable; either because they seem to not be part of a year mutation,
 * or because they seem to be a conversion pattern of mapping date scalars.
 */
abstract class IgnorableOperation extends Expr { }

class IgnorableExprRem extends IgnorableOperation instanceof RemExpr { }

/**
 * Anything involving an operation with 10, 100, 1000, 10000 is often a sign of conversion
 * or atoi.
 */
class IgnorableExpr10MulipleComponent extends IgnorableOperation {
  IgnorableExpr10MulipleComponent() {
    this.(Operation).getAnOperand().getValue().toInt() in [10, 100, 1000, 10000]
    or
    exists(AssignOperation a | a.getRValue() = this |
      a.getRValue().getValue().toInt() in [10, 100, 1000, 10000]
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

/**
 * Constants often used in date conversions (from one date data type to another)
 * Numerous examples exist, like 1900 or 2000 that convert years from one
 * representation to another.
 * Also '0' is sometimes observed as an atoi style conversion.
 */
bindingset[c]
predicate isLikelyConversionConstant(int c) {
  exists(int i | i = c.abs() |
    //| i >= 100)
    i = 146097 or // days in 400-year Gregorian cycle
    i = 36524 or // days in 100-year Gregorian subcycle
    i = 1461 or // days in 4-year cycle (incl. 1 leap)
    i = 32044 or // Fliegel–van Flandern JDN epoch shift
    i = 1721425 or // JDN of 0001‑01‑01 (Gregorian)
    i = 1721119 or // alt epoch offset
    i = 2400000 or // MJD → JDN conversion
    i = 2400001 or // alt MJD → JDN conversion
    i = 2141 or // fixed‑point month/day extraction
    i = 65536 or // observed in some conversions
    i = 7834 or // observed in some conversions
    i = 256 or // observed in some conversions
    i = 292275056 or // qdatetime.h Qt Core year range first year constant
    i = 292278994 or // qdatetime.h Qt Core year range last year constant
    i = 1601 or // Windows FILETIME epoch start year
    i = 1970 or // Unix epoch start year
    i = 70 or // Unix epoch start year short form
    i = 1899 or // Observed in uses with 1900 to address off by one scenarios
    i = 1900 or // Used when converting a 2 digit year
    i = 2000 or // Used when converting a 2 digit year
    i = 1400 or // Hijri base year, used when converting a 2 digit year
    i = 1980 or // FAT filesystem epoch start year
    i = 227013 or // constant observed for Hirji year conversion, and Hirji years are not applicable for gregorian leap year
    i = 10631 or // constant observed for Hirji year conversion, and Hirji years are not applicable for gregorian leap year
    i = 0
  )
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
class IgnorableUnaryMinus extends IgnorableOperation {
  IgnorableUnaryMinus() {
    this instanceof UnaryMinusExpr
    or
    this.(Operation).getAnOperand() instanceof UnaryMinusExpr
  }
}

class OperationAsArgToIgnorableFunction extends IgnorableOperation {
  OperationAsArgToIgnorableFunction() {
    exists(Call c |
      c.getAnArgument().getAChild*() = this and
      c.getTarget() instanceof IgnorableFunction
    )
  }
}

/**
 * Literal OP literal means the result is constant/known
 * and the operation is basically ignorable (it's not a real operation but
 * probably one visual simplicity what it means).
 */
class ConstantBinaryArithmeticOperation extends IgnorableOperation {
  ConstantBinaryArithmeticOperation() {
    this instanceof BinaryArithmeticOperation and
    this.(BinaryArithmeticOperation).getLeftOperand() instanceof Literal and
    this.(BinaryArithmeticOperation).getRightOperand() instanceof Literal
  }
}

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
      or
      // Operations on calls to functions that accept char or char*
      this.(BinaryArithmeticOperation)
          .getAnOperand()
          .(Call)
          .getAnArgument()
          .getUnspecifiedType()
          .stripType() instanceof CharType
      or
      // Operations on calls to functions named like "strlen", "wcslen", etc
      // NOTE: workaround for cases where the wchar_t type is not a char, but an unsigned short
      // unclear if there is a best way to filter cases like these out based on type info.
      this.(BinaryArithmeticOperation).getAnOperand().(Call).getTarget().getName().matches("%len%")
    )
    or
    exists(AssignArithmeticOperation a | a.getRValue() = this |
      a.getAnOperand().getUnspecifiedType() instanceof PointerType
      or
      a.getAnOperand().getUnspecifiedType() instanceof CharType
      or
      // Operations on calls to functions that accept char or char*
      a.getAnOperand().(Call).getAnArgument().getUnspecifiedType().stripType() instanceof CharType
      or
      // Operations on calls to functions named like "strlen", "wcslen", etc
      this.(BinaryArithmeticOperation).getAnOperand().(Call).getTarget().getName().matches("%len%")
    )
  }
}

/**
 * An expression that is a candidate source for an dataflow configuration for an Operation that could flow to a Year field.
 */
predicate isOperationSourceCandidate(Expr e) {
  not e instanceof IgnorableOperation and
  not e.getEnclosingFunction() instanceof IgnorableFunction and
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
    // If the candidate came from an ignorable operation, ignore the candidate
    // NOTE: we cannot easily flow the candidate to an ignorable operation as that can
    // be tricky in practice, e.g., a mod operation on a year would be part of a leap year check
    // but a mod operation ending in a year is more indicative of something to ignore (a conversion)
    not exists(IgnorableOperationToOperationSourceCandidateFlow::PathNode sink |
      sink.getNode().asExpr() = this and
      sink.isSink()
    )
  }
}

class YearFieldAssignmentNode extends DataFlow::Node {
  YearFieldAssignmentNode() {
    not this.getEnclosingCallable().getUnderlyingCallable() instanceof IgnorableFunction and
    (
      this.asExpr() instanceof YearFieldAssignment or
      this.asDefiningArgument() instanceof YearFieldOutArgAssignment
    )
  }
}

/**
 * An assignment to a year field, which will be a sink
 */
abstract class YearFieldAssignment extends Expr {
  abstract YearFieldAccess getYearFieldAccess();
}

class YearFieldOutArgAssignment extends YearFieldAssignment {
  YearFieldAccess access;

  YearFieldOutArgAssignment() {
    exists(Call c | c.getAnArgument() = access and this = access)
    or
    exists(Call c, AddressOfExpr aoe |
      c.getAnArgument() = aoe and
      aoe.getOperand() = access and
      this = aoe
    )
  }

  override YearFieldAccess getYearFieldAccess() { result = access }
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
    n.getType().getUnspecifiedType() instanceof PointerType
    or
    n.getType().getUnspecifiedType() instanceof CharType
    or
    // If a type resembles "string" ignore flow (likely string conversion, currently ignored)
    n.getType().getUnspecifiedType().stripType().getName().toLowerCase().matches("%string%")
    or
    n.asExpr() instanceof IgnorableOperation
    or
    // Hijri or Persian  years are not applicable for gregorian leap year checks
    exists(Variable v |
      v.getName().toLowerCase().matches(["%hijri%, %persian%"]) and
      v.getAnAccess() = [n.asIndirectExpr(), n.asExpr()]
    )
    or
    isLeapYearCheckSink(n)
  }

  /** Block flow out of an operation source to get the "closest" operation to the sink */
  predicate isBarrierIn(DataFlow::Node n) { isSource(n) }

  predicate isBarrierOut(DataFlow::Node n) { isSink(n) }
}

module OperationToYearAssignmentFlow = TaintTracking::Global<OperationToYearAssignmentConfig>;

predicate isLeapYearCheckSink(DataFlow::Node sink) {
  exists(LeapYearGuardCondition lgc |
    lgc.checkedYearAccess() = [sink.asExpr(), sink.asIndirectExpr()]
  )
  or
  isLeapYearCheckCall(_, [sink.asExpr(), sink.asIndirectExpr()])
}

/**
 * A flow configuration from a Year field access to some Leap year check or guard
 */
module YearFieldAccessToLeapYearCheckConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) { source instanceof YearFieldAssignmentNode }

  predicate isSink(DataFlow::Node sink) { isLeapYearCheckSink(sink) }

  predicate isAdditionalFlowStep(DataFlow::Node node1, DataFlow::Node node2) {
    // flow from a YearFieldAccess to the qualifier
    node2.asExpr() = node1.asExpr().(YearFieldAccess).getQualifier*()
    or
    // Pass through any intermediate struct
    exists(Assignment a, DataFlow::PostUpdateNode pun |
      a.getLValue().(YearFieldAccess).getQualifier*() = pun.getPreUpdateNode().asExpr() and
      a.getRValue() = node1.asExpr() and
      node2.asExpr() = a.getLValue().(YearFieldAccess).getQualifier*()
    )
    or
    // flow from a year access qualifier to a year field
    exists(YearFieldAccess yfa | node2.asExpr() = yfa and node1.asExpr() = yfa.getQualifier())
  }

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
  // If the time flows to a time conversion whose value/result is checked,
  // assume the leap year is being handled.
  exists(TimeStructToCheckedTimeConversionFlow::PathNode timeQualSrc |
    timeQualSrc.isSource() and
    timeQualSrc.getNode().asExpr() = fa.getQualifier*()
  )
  // or
  // isUsedInFeb29Check(fa)
}

// /**
//  * If there is a flow from a date struct year field access/assignment to a Feb 29 check
//  */
// predicate isUsedInFeb29Check(YearFieldAccess fa) {
//   exists(DateFebruary29Check check |
//     DataFlow::localExprFlow(fa.getQualifier(), check.getDateQualifier())
//     or
//     DataFlow::localExprFlow(check.getDateQualifier(), fa.getQualifier())
//   )
// }
/**
 * An expression which checks the value of a Month field `a->month == 1`.
 */
class MonthEqualityCheck extends EqualityOperation {
  MonthEqualityCheck() { this.getAnOperand() instanceof MonthFieldAccess }

  Expr getExprCompared() {
    exists(Expr e |
      e = this.getAnOperand() and
      not e instanceof MonthFieldAccess and
      result = e
    )
  }
}

class MonthEqualityCheckGuard extends GuardCondition instanceof MonthEqualityCheck { }

/**
 * Verifies if the expression is guarded by a check on the Month property of a date struct, that is NOT February.
 */
bindingset[e]
pragma[inline_late]
predicate isControlledByMonthEqualityCheckNonFebruary(Expr e) {
  exists(MonthEqualityCheckGuard monthGuard |
    monthGuard.controls(e.getBasicBlock(), true) and
    not monthGuard.(MonthEqualityCheck).getExprCompared().getValueText() = "2"
  )
}

/**
 * Flow from a year field access through a time conversion function
 * where the call's result is used to check error. The result must
 * be used as a guard for an if or ternary operator. If so,
 * assume some sort of error handling is occurring that could be used
 * to detect bad dates due to leap year.
 */
module TimeStructToCheckedTimeConversionConfig implements DataFlow::StateConfigSig {
  class FlowState = boolean;

  predicate isSource(DataFlow::Node source, FlowState state) {
    exists(YearFieldAccess yfa | source.asExpr() = yfa.getQualifier()) and
    state = false
  }

  predicate isSink(DataFlow::Node sink, FlowState state) {
    state = true and
    (
      exists(IfStmt ifs | ifs.getCondition().getAChild*() = [sink.asExpr(), sink.asIndirectExpr()])
      or
      exists(ConditionalExpr ce |
        ce.getCondition().getAChild*() = [sink.asExpr(), sink.asIndirectExpr()]
      )
      or
      exists(Loop l | l.getCondition().getAChild*() = [sink.asExpr(), sink.asIndirectExpr()])
    )
  }

  predicate isAdditionalFlowStep(
    DataFlow::Node node1, FlowState state1, DataFlow::Node node2, FlowState state2
  ) {
    state1 in [true, false] and
    state2 = true and
    exists(Call c |
      c.getTarget() instanceof TimeConversionFunction and
      c.getAnArgument().getAChild*() = [node1.asExpr(), node1.asIndirectExpr()] and
      node2.asExpr() = c
    )
  }

  predicate isAdditionalFlowStep(DataFlow::Node node1, DataFlow::Node node2) {
    // flow from a YearFieldAccess to the qualifier
    node2.asExpr() = node1.asExpr().(YearFieldAccess).getQualifier*()
    or
    // Pass through any intermediate struct
    exists(Assignment a, DataFlow::PostUpdateNode pun |
      a.getLValue().(YearFieldAccess).getQualifier*() = pun.getPreUpdateNode().asExpr() and
      a.getRValue() = node1.asExpr() and
      node2.asExpr() = a.getLValue().(YearFieldAccess).getQualifier*()
    )
    or
    // flow from a year access qualifier to a year field
    exists(YearFieldAccess yfa | node2.asExpr() = yfa and node1.asExpr() = yfa.getQualifier())
  }

  DataFlow::FlowFeature getAFeature() { result instanceof DataFlow::FeatureHasSourceCallContext }
}

module TimeStructToCheckedTimeConversionFlow =
  DataFlow::GlobalWithState<TimeStructToCheckedTimeConversionConfig>;

/**
 * Finds flow from a parameter of a function to a leap year check.
 * This is necessary to handle for scenarios like this:
 *
 *    year = DANGEROUS_OP // source
 *    isLeap = isLeapYear(year);
 *    // logic based on isLeap
 *    struct.year = year; // sink
 *
 * In this case, we may flow a dangerous op to a year assignment, failing
 * to barrier the flow through a leap year check, as the leap year check
 * is nested, and dataflow does not progress down into the check and out.
 * Instead, the point of this flow is to detect isLeapYear's argument
 * is checked for leap year, making the isLeapYear call a barrier for
 * the dangerous flow if we flow through the parameter identified to
 * be checked.
 */
module ParameterToLeapYearCheckConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) { exists(source.asParameter()) }

  predicate isSink(DataFlow::Node sink) {
    exists(LeapYearGuardCondition lgc |
      lgc.checkedYearAccess() = [sink.asExpr(), sink.asIndirectExpr()]
    )
  }

  predicate isAdditionalFlowStep(DataFlow::Node node1, DataFlow::Node node2) {
    // flow from a YearFieldAccess to the qualifier
    node2.asExpr() = node1.asExpr().(YearFieldAccess).getQualifier*()
    or
    // flow from a year access qualifier to a year field
    exists(YearFieldAccess yfa | node2.asExpr() = yfa and node1.asExpr() = yfa.getQualifier())
  }

  /**
   * Enforcing the check must occur in the same call context as the source,
   * i.e., do not return from the source function and check in a caller.
   */
  DataFlow::FlowFeature getAFeature() { result instanceof DataFlow::FeatureHasSourceCallContext }
}

// NOTE: I do not believe taint flow is necessary here as we should
// be flowing directyly from some parameter to a leap year check.
module ParameterToLeapYearCheckFlow = DataFlow::Global<ParameterToLeapYearCheckConfig>;

predicate isLeapYearCheckCall(Call c, Expr arg) {
  exists(ParameterToLeapYearCheckFlow::PathNode src, Function f, int i |
    src.isSource() and
    f.getParameter(i) = src.getNode().asParameter() and
    c.getTarget() = f and
    c.getArgument(i) = arg
  )
}

class LeapYearGuardCondition extends GuardCondition {
  Expr yearSinkDiv4;
  Expr yearSinkDiv100;
  Expr yearSinkDiv400;

  LeapYearGuardCondition() {
    exists(
      LogicalAndExpr andExpr, LogicalOrExpr orExpr, GuardCondition div4Check,
      GuardCondition div100Check, GuardCondition div400Check, GuardValue gv
    |
      // Cannonical case:
      // form: `(year % 4 == 0) && (year % 100 != 0 || year % 400 == 0)`
      // or : `!(year % 4 == 0) && (year % 100 != 0 || year % 400 == 0)`
      this = andExpr and
      andExpr.hasOperands(div4Check, orExpr) and
      orExpr.hasOperands(div100Check, div400Check) and
      exists(RemExpr e |
        div4Check.comparesEq(e, 0, true, gv) and
        e.getRightOperand().getValue().toInt() = 4 and
        yearSinkDiv4 = e.getLeftOperand()
      ) and
      exists(RemExpr e |
        div100Check.comparesEq(e, 0, false, gv) and
        e.getRightOperand().getValue().toInt() = 100 and
        yearSinkDiv100 = e.getLeftOperand()
      ) and
      exists(RemExpr e |
        div400Check.comparesEq(e, 0, true, gv) and
        e.getRightOperand().getValue().toInt() = 400 and
        yearSinkDiv400 = e.getLeftOperand()
      )
      or
      // Inverted logic case:
      //  `year % 400 == 0 || (year % 100 != 0 && year % 4 == 0)`
      this = orExpr and
      orExpr.hasOperands(div4Check, andExpr) and
      andExpr.hasOperands(div100Check, div400Check) and
      exists(RemExpr e |
        div4Check.comparesEq(e, 0, false, gv) and
        e.getRightOperand().getValue().toInt() = 4 and
        yearSinkDiv4 = e.getLeftOperand()
      ) and
      exists(RemExpr e |
        div100Check.comparesEq(e, 0, true, gv) and
        e.getRightOperand().getValue().toInt() = 100 and
        yearSinkDiv100 = e.getLeftOperand()
      ) and
      exists(RemExpr e |
        div400Check.comparesEq(e, 0, false, gv) and
        e.getRightOperand().getValue().toInt() = 400 and
        yearSinkDiv400 = e.getLeftOperand()
      )
    )
  }

  Expr getYearSinkDiv4() { result = yearSinkDiv4 }

  Expr getYearSinkDiv100() { result = yearSinkDiv100 }

  Expr getYearSinkDiv400() { result = yearSinkDiv400 }

  /**
   * The variable access that is used in all 3 components of the leap year check
   * e.g., see getYearSinkDiv4/100/400..
   * If a field access is used, the qualifier and the field access are both returned
   * in checked condition.
   * NOTE: if the year is not checked using the same access in all 3 components, no result is returned.
   * The typical case observed is a consistent variable access is used. If not, this may indicate a bug.
   * We could check more accurately with a dataflow analysis, but this is likely sufficient for now.
   */
  VariableAccess checkedYearAccess() {
    exists(Variable var |
      (
        this.getYearSinkDiv4().getAChild*() = var.getAnAccess() and
        this.getYearSinkDiv100().getAChild*() = var.getAnAccess() and
        this.getYearSinkDiv400().getAChild*() = var.getAnAccess() and
        result = var.getAnAccess() and
        (
          result = this.getYearSinkDiv4().getAChild*() or
          result = this.getYearSinkDiv100().getAChild*() or
          result = this.getYearSinkDiv400().getAChild*()
        )
      )
    )
  }
}

/**
 * A difficult case to detect is if a year modification is tied to a month modification
 * and the month is safe for leap year.
 *    e.g.,
 *          year++;
 *          month = 1;
 *        ... values eventually used in the same time struct
 * If this is even more challenging if the struct the values end up in are not
 * local (set inter-procedurally).
 * This flow flows constants 1-12 (but not 2 as this likely means february) to a month assignment.
 * It is assumed a user of this flow will check if the month/day source and month/day sink
 * are in the same basic blocks as a year modification source and a year modification sink.
 * It is also assumed a user will check if the constant source is a value that is ignorable
 * e.g., if it is 2 and the sink is a month assignment, then it isn't ignorable.
 *
 * Obviously this does not handle all conditions (e.g., the month set in another block).
 * It is meant to capture the most common cases of false positives.
 */
module NonFebConstantToMonthAssignmentConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) {
    source.asExpr().getValue().toInt() in [1 .. 12] and
    source.asExpr().getValue().toInt() != 2
  }

  predicate isSink(DataFlow::Node sink) {
    exists(Assignment a |
      a.getLValue() instanceof MonthFieldAccess and
      a.getRValue() = sink.asExpr()
    )
  }
}

// NOTE: only data flow here (no taint tracking) as we want the exact
// constant flowing to the month assignment
module NonFebConstantToMonthAssignmentFlow =
  DataFlow::Global<NonFebConstantToMonthAssignmentConfig>;

import OperationToYearAssignmentFlow::PathGraph

from OperationToYearAssignmentFlow::PathNode src, OperationToYearAssignmentFlow::PathNode sink
where
  OperationToYearAssignmentFlow::flowPath(src, sink) and
  not isYearModifiedWithCheck(sink.getNode().asExpr().(YearFieldAssignment).getYearFieldAccess()) and
  not isControlledByMonthEqualityCheckNonFebruary(sink.getNode().asExpr()) and
  // Check if a month is set in the same block as the year operation source
  // to a month that would be considered safe.
  not exists(DataFlow::Node monthValSrc, DataFlow::Node monthValSink |
    NonFebConstantToMonthAssignmentFlow::flow(monthValSrc, monthValSink) and
    monthValSrc.asExpr().getBasicBlock() = src.getNode().asExpr().getBasicBlock() and
    monthValSink.asExpr().getBasicBlock() = sink.getNode().asExpr().getBasicBlock()
  )
select sink, src, sink,
  "Year field has been modified, but no appropriate check for LeapYear was found."
