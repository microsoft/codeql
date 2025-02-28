private import Ast
private import TAst
private import Synthesis
private import Stmt
private import Expr
private import Location

class ExprStmt extends Stmt, TExprStmt {
  override string toString() { result = "[Stmt] " + this.getExpr().toString() }

  override Location getLocation() { result = this.getExpr().getLocation() }

  string getName() { result = any(Synthesis s).toString(this) }

  override Ast getChild(int i) {
    i = 0 and
    result = this.getExpr()
  }

  Expr getExpr() { any(Synthesis s).exprStmtExpr(this, result) }
}
