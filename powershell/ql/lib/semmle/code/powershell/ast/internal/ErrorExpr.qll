private import TAst
private import semmle.code.powershell.ast.internal.Expr

class ExrprExpr extends Expr, TErrorExpr {
  final override string toString() { result = "error" }
}
