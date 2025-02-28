private import Raw

class ArrayExpr extends @array_expression, Expr {
  override SourceLocation getLocation() { array_expression_location(this, result) }

  StmtBlock getStmtBlock() { array_expression(this, result) }

  final override Ast getChild(int i) { i = 0 and result = this.getStmtBlock() }

  override string toString() { result = "@(...)" }
}
