private import Raw

class TypeNameExpr extends @type_expression, Expr {
  string getName() { type_expression(this, result, _) }

  string getFullyQualifiedName() { type_expression(this, _, result) }

  override SourceLocation getLocation() { type_expression_location(this, result) }

  /** Gets the type referred to by this `TypeNameExpr`. */
  Type getType() { result.getName() = this.getName() }
}
