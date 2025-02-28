private import Raw

class Parameter extends @parameter, Ast {
  string getName() {
    exists(@variable_expression va |
      parameter(this, va, _, _) and
      variable_expression(va, result, _, _, _, _, _, _, _, _, _, _)
    )
  }

  override string toString() { result = this.getName() }

  override SourceLocation getLocation() { parameter_location(this, result) }

  Attribute getAttribute(int i) { parameter_attribute(this, i, result) }

  Attribute getAnAttribute() { result = this.getAttribute(_) }

  Expr getDefaultValue() { parameter_default_value(this, result) }

  final override Ast getChild(int i) {
    result = this.getAttribute(i)
    or
    i = -1 and
    result = this.getDefaultValue()
  }
}
