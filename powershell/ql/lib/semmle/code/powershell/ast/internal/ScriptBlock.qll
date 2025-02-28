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
    synthChild(this, -2, result)
    or
    not synthChild(this, -2, _) and
    toRaw(result) = toRaw(this).(Raw::ScriptBlock).getProcessBlock()
  }

  NamedBlock getBeginBlock() {
    synthChild(this, -3, result)
    or
    not synthChild(this, -3, _) and
    toRaw(result) = toRaw(this).(Raw::ScriptBlock).getBeginBlock()
  }

  NamedBlock getEndBlock() {
    synthChild(this, -1, result)
    or
    not synthChild(this, -1, _) and
    toRaw(result) = toRaw(this).(Raw::ScriptBlock).getEndBlock()
  }

  final override Ast getChild(int i) {
    i = -3 and
    result = this.getBeginBlock()
    or
    i = -2 and
    result = this.getProcessBlock()
    or
    i = -1 and
    result = this.getEndBlock()
    or
    result = this.getParameter(i)
    or
    result = this.getAttribute(i - this.getNumberOfParameters())
  }

  Parameter getParameter(int i) { synthChild(this, i, result) }

  Parameter getAParameter() { result = this.getParameter(_) }

  int getNumberOfParameters() { result = count(this.getAParameter()) }

  predicate isTopLevel() { not exists(this.getParent()) }

  Attribute getAttribute(int i) {
    exists(int k | k = this.getNumberOfParameters() + i |
      synthChild(this, k, result)
      or
      not synthChild(this, k, _) and
      // We attach the attributes to the function since we have gotten rid of parameter blocks
      toRaw(result) = toRaw(this).(Raw::ScriptBlock).getParamBlock().getAttribute(i)
    )
  }
}
