import powershell

class BinaryExpr extends @binary_expression, Expr {
  override SourceLocation getLocation() { binary_expression_location(this, result) }

  int getKind() { binary_expression(this, result, _, _) }

  Expr getLeft() { binary_expression(this, _, result, _) }

  Expr getRight() { binary_expression(this, _, _, result) }
}

abstract private class AbstractArithmeticExpr extends BinaryExpr { }

final class ArithmeticExpr = AbstractArithmeticExpr;

class AddExpr extends AbstractArithmeticExpr {
  AddExpr() { this.getKind() = 40 }

  final override string toString() { result = "...+..." }
}

class SubExpr extends AbstractArithmeticExpr {
  SubExpr() { this.getKind() = 41 }

  final override string toString() { result = "...-..." }
}

class MulExpr extends AbstractArithmeticExpr {
  MulExpr() { this.getKind() = 37 }

  final override string toString() { result = "...*..." }
}

class DivExpr extends AbstractArithmeticExpr {
  DivExpr() { this.getKind() = 38 }

  final override string toString() { result = ".../..." }
}

class RemExpr extends AbstractArithmeticExpr {
  RemExpr() { this.getKind() = 39 }

  final override string toString() { result = "...%..." }
}

abstract private class AbstractBitwiseExpr extends BinaryExpr { }

final class BitwiseExpr = AbstractBitwiseExpr;

class BitwiseAndExpr extends AbstractBitwiseExpr {
  BitwiseAndExpr() { this.getKind() = 56 }

  final override string toString() { result = "...&..." }
}

class BitwiseOrExpr extends AbstractBitwiseExpr {
  BitwiseOrExpr() { this.getKind() = 57 }

  final override string toString() { result = "...|..." }
}

class BitwiseXorExpr extends AbstractBitwiseExpr {
  BitwiseXorExpr() { this.getKind() = 58 }

  final override string toString() { result = "...^..." }
}

class ShiftLeftExpr extends AbstractBitwiseExpr {
  ShiftLeftExpr() { this.getKind() = 97 }

  final override string toString() { result = "...<<..." }
}

class ShiftRightExpr extends AbstractBitwiseExpr {
  ShiftRightExpr() { this.getKind() = 98 }

  final override string toString() { result = "...>>..." }
}

abstract private class AbstractComparisonExpr extends BinaryExpr { }

final class ComparisonExpr = AbstractComparisonExpr;

abstract private class AbstractCaseInsensitiveComparisonExpr extends AbstractComparisonExpr { }

final class CaseInsensitiveComparisonExpr = AbstractCaseInsensitiveComparisonExpr;

class EqExpr extends AbstractCaseInsensitiveComparisonExpr {
  EqExpr() { this.getKind() = 60 }

  final override string toString() { result = "... -eq ..." }
}

class NeExpr extends AbstractCaseInsensitiveComparisonExpr {
  NeExpr() { this.getKind() = 61 }

  final override string toString() { result = "... -ne ..." }
}

abstract private class AbstractRelationalExpr extends AbstractComparisonExpr { }

final class RelationalExpr = AbstractRelationalExpr;

abstract private class AbstractCaseInsensitiveRelationalExpr extends AbstractRelationalExpr { }

class GeExpr extends AbstractCaseInsensitiveRelationalExpr {
  GeExpr() { this.getKind() = 62 }

  final override string toString() { result = "... -ge ..." }
}

class GtExpr extends AbstractCaseInsensitiveRelationalExpr {
  GtExpr() { this.getKind() = 63 }

  final override string toString() { result = "... -gt ..." }
}

class LtExpr extends AbstractCaseInsensitiveRelationalExpr {
  LtExpr() { this.getKind() = 64 }

  final override string toString() { result = "... -lt ..." }
}

class LeExpr extends AbstractCaseInsensitiveRelationalExpr {
  LeExpr() { this.getKind() = 65 }

  final override string toString() { result = "... -le ..." }
}

class LikeExpr extends AbstractCaseInsensitiveComparisonExpr {
  LikeExpr() { this.getKind() = 66 }

  final override string toString() { result = "... -like ..." }
}

class NotLikeExpr extends AbstractCaseInsensitiveComparisonExpr {
  NotLikeExpr() { this.getKind() = 67 }

  final override string toString() { result = "... -notlike ..." }
}

class MatchExpr extends AbstractCaseInsensitiveComparisonExpr {
  MatchExpr() { this.getKind() = 68 }

  final override string toString() { result = "... -match ..." }
}

class NotMatchExpr extends AbstractCaseInsensitiveComparisonExpr {
  NotMatchExpr() { this.getKind() = 69 }

  final override string toString() { result = "... -notmatch ..." }
}

class ReplaceExpr extends AbstractCaseInsensitiveComparisonExpr {
  ReplaceExpr() { this.getKind() = 70 }

  final override string toString() { result = "... -replace ..." }
}

abstract class AbstractTypeExpr extends BinaryExpr { }

final class TypeExpr = AbstractTypeExpr;

abstract class AbstractTypeComparisonExpr extends AbstractTypeExpr { }

final class TypeComparisonExpr = AbstractTypeComparisonExpr;

class IsExpr extends AbstractTypeComparisonExpr {
  IsExpr() { this.getKind() = 92 }

  final override string toString() { result = "... -is ..." }
}

class IsNotExpr extends AbstractTypeComparisonExpr {
  IsNotExpr() { this.getKind() = 93 }

  final override string toString() { result = "... -isnot ..." }
}

class AsExpr extends AbstractTypeExpr {
  AsExpr() { this.getKind() = 94 }

  final override string toString() { result = "... -as ..." }
}

abstract private class AbstractContainmentExpr extends BinaryExpr { }

final class ContainmentExpr = AbstractContainmentExpr;

abstract private class AbstractCaseInsensitiveContainmentExpr extends AbstractContainmentExpr { }

final class CaseInsensitiveContainmentExpr = AbstractCaseInsensitiveContainmentExpr;

class ContainsExpr extends AbstractCaseInsensitiveContainmentExpr {
  ContainsExpr() { this.getKind() = 71 }

  final override string toString() { result = "... -contains ..." }
}

class NotContainsExpr extends AbstractCaseInsensitiveContainmentExpr {
  NotContainsExpr() { this.getKind() = 72 }

  final override string toString() { result = "... -notcontains ..." }
}

class InExpr extends AbstractCaseInsensitiveContainmentExpr {
  InExpr() { this.getKind() = 73 }

  final override string toString() { result = "... -in ..." }
}

class NotInExpr extends AbstractCaseInsensitiveContainmentExpr {
  NotInExpr() { this.getKind() = 74 }

  final override string toString() { result = "... -notin ..." }
}

abstract private class AbstractLogicalBinaryExpr extends BinaryExpr { }

final class LogicalBinaryExpr = AbstractLogicalBinaryExpr;

class AndExpr extends AbstractLogicalBinaryExpr {
  AndExpr() { this.getKind() = 53 }

  final override string toString() { result = "... -and ..." }
}

class OrExpr extends AbstractLogicalBinaryExpr {
  OrExpr() { this.getKind() = 54 }

  final override string toString() { result = "... -or ..." }
}

class XorExpr extends AbstractLogicalBinaryExpr {
  XorExpr() { this.getKind() = 55 }

  final override string toString() { result = "... -xor ..." }
}

abstract private class AbstractStringExpr extends BinaryExpr { }

final class StringExpr = AbstractStringExpr;

class JoinExpr extends AbstractStringExpr {
  JoinExpr() { this.getKind() = 59 }

  final override string toString() { result = "... -join ..." }
}

class SplitExpr extends AbstractStringExpr {
  SplitExpr() { this.getKind() = 75 }

  final override string toString() { result = "... -split ..." }
}
