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
}
