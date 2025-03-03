private import Ast
private import TAst
private import Internal
private import Raw.Raw as Raw

class ScriptBlock extends Ast, TScriptBlock {
  override string toString() {
    if this.isTopLevel()
    then result = this.getLocation().getFile().getBaseName()
    else result = "{...}"
  }

  NamedBlock getProcessBlock() {
    synthChild(this, scriptBlockProcessBlock(), result)
    or
    not synthChild(this, scriptBlockProcessBlock(), _) and
    toRaw(result) = toRaw(this).(Raw::ScriptBlock).getProcessBlock()
  }

  NamedBlock getBeginBlock() {
    synthChild(this, scriptBlockBeginBlock(), result)
    or
    not synthChild(this, scriptBlockBeginBlock(), _) and
    toRaw(result) = toRaw(this).(Raw::ScriptBlock).getBeginBlock()
  }

  NamedBlock getEndBlock() {
    synthChild(this, scriptBlockEndBlock(), result)
    or
    not synthChild(this, scriptBlockEndBlock(), _) and
    toRaw(result) = toRaw(this).(Raw::ScriptBlock).getEndBlock()
  }

  NamedBlock getDynamicBlock() {
    synthChild(this, scriptBlockDynParamBlock(), result)
    or
    not synthChild(this, scriptBlockDynParamBlock(), _) and
    toRaw(result) = toRaw(this).(Raw::ScriptBlock).getDynamicParamBlock()
  }

  final override Ast getChild(ChildIndex i) {
    i = scriptBlockBeginBlock() and
    result = this.getBeginBlock()
    or
    i = scriptBlockProcessBlock() and
    result = this.getProcessBlock()
    or
    i = scriptBlockEndBlock() and
    result = this.getEndBlock()
    or
    i = scriptBlockDynParamBlock() and
    result = this.getDynamicBlock()
    or
    exists(int index |
      i = scriptBlockAttr(index) and
      result = this.getAttribute(index)
    )
    or
    exists(int index |
      i = funParam(index) and
      result = this.getParameter(index)
    )
    or
    i = dontCareParam() and
    result = this.getDontCareParameter()
  }

  Parameter getParameter(int i) { synthChild(this, funParam(i), result) }

  Parameter getDontCareParameter() { synthChild(this, dontCareParam(), result) }

  /**
   * Gets a parameter of this block.
   * Note: This predicate does not return the dont-care parameter (i.e., `_` or
   * `PSItem`).
   */
  Parameter getAParameter() { result = this.getParameter(_) }

  int getNumberOfParameters() { result = count(this.getAParameter()) }

  predicate isTopLevel() { not exists(this.getParent()) }

  Attribute getAttribute(int i) {
    synthChild(this, scriptBlockAttr(i), result)
    or
    not synthChild(this, scriptBlockAttr(i), _) and
    // We attach the attributes to the function since we got rid of parameter blocks
    toRaw(result) = toRaw(this).(Raw::ScriptBlock).getParamBlock().getAttribute(i)
  }
}
