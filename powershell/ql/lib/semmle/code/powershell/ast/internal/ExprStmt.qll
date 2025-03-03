private import Ast
private import TAst
private import Synthesis
private import Internal

class ExprStmt extends Stmt, TExprStmt {
  override string toString() { result = "[Stmt] " + this.getExpr().toString() }

  override Location getLocation() { result = this.getExpr().getLocation() }

  string getName() { result = any(Synthesis s).toString(this) }

  override Ast getChild(ChildIndex i) {
    i = exprStmtExpr() and
    result = this.getExpr()
  }

  Expr getExpr() { any(Synthesis s).exprStmtExpr(this, result) } // TODO: Replace with normal child call
}
