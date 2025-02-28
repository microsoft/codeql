private import Raw

class ParamBlock extends @param_block, Ast {
  override string toString() { result = "param(...)" }

  override SourceLocation getLocation() { param_block_location(this, result) }

  int getNumAttributes() { param_block(this, result, _) }

  int getNumParameters() { param_block(this, _, result) }

  Attribute getAttribute(int i) { param_block_attribute(this, i, result) }

  Attribute getAnAttribute() { result = this.getAttribute(_) }

  Parameter getParameter(int i) { param_block_parameter(this, i, result) }

  Parameter getAParameter() { result = this.getParameter(_) }

  final override Ast getChild(int i) {
    exists(int k |
      i = 2 * k and
      result = this.getAttribute(k)
      or
      i = 2 * k + 1 and
      result = this.getParameter(k)
    )
  }

  /** Gets the script block, if any. */
  ScriptBlock getScriptBlock() { result.getParamBlock() = this }
}
