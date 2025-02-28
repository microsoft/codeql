private import Raw

class ConvertExpr extends @convert_expression, Expr {
  override string toString() { result = "[...]..." }

  override SourceLocation getLocation() { convert_expression_location(this, result) }

  Expr getBase() { convert_expression(this, _, result, _, _) }

  TypeConstraint getType() { convert_expression(this, _, _, result, _) }

  AttributeBase getAttribute() { convert_expression(this, result, _, _, _) }

  final override Ast getChild(int i) {
    i = 0 and result = this.getBase()
    or
    i = 1 and result = this.getType()
    or
    i = 2 and result = this.getAttribute()
  }
}
