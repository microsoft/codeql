private import Ast
private import TAst
private import Internal
private import Raw.Raw as Raw

class ScriptBlock extends Ast, TScriptBlock {
  NamedBlock getProcessBlock() {
    synthChild(this, 1, result)
    or
    not synthChild(this, 1, _) and
    toRaw(result) = toRaw(this).(Raw::ScriptBlock).getProcessBlock()
  }

  NamedBlock getBeginBlock() {
    synthChild(this, 0, result)
    or
    not synthChild(this, 0, _) and
    toRaw(result) = toRaw(this).(Raw::ScriptBlock).getBeginBlock()
  }

  NamedBlock getEndBlock() {
    synthChild(this, 2, result)
    or
    not synthChild(this, 2, _) and
    toRaw(result) = toRaw(this).(Raw::ScriptBlock).getEndBlock()
  }

  final override Ast getChild(int i) {
    i = 0 and
    result = this.getBeginBlock()
    or
    i = 1 and
    result = this.getProcessBlock()
    or
    i = 2 and
    result = this.getEndBlock()
  }

  Parameter getParameter(int i) { synthChild(this, i, result) }

  Parameter getAParameter() { result = this.getParameter(_) }

  int getNumberOfParameters() { result = count(this.getAParameter()) }

  predicate isTopLevel() { not exists(this.getParent()) }
}
