private import Raw

class Parameter extends @parameter, Ast {
  string getName() {
    exists(@variable_expression va |
      parameter(this, va, _, _) and
      variable_expression(va, result, _, _, _, _, _, _, _, _, _, _)
    )
  }

  override SourceLocation getLocation() { parameter_location(this, result) }

  AttributeBase getAttribute(int i) { parameter_attribute(this, i, result) }

  AttributeBase getAnAttribute() { result = this.getAttribute(_) }

  Expr getDefaultValue() { parameter_default_value(this, result) }

  final override Ast getChild(ChildIndex i) {
    exists(int index |
      i = ParamAttr(index) and
      result = this.getAttribute(index)
    )
    or
    i = ParamDefaultVal() and
    result = this.getDefaultValue()
  }
}
