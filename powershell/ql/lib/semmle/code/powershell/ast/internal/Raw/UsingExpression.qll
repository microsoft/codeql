private import Raw

class UsingExpr extends @using_expression, Expr {

  override SourceLocation getLocation() { using_expression_location(this, result) }
}
