private import TAst
private import semmle.code.powershell.ast.internal.Expr

class UsingExpr extends Expr, TUsingExpr {
  override string toString() { result = "$using..." }
}
