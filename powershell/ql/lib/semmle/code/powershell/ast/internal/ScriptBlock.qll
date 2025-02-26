private import Ast
private import TAst
private import Raw.Raw as Raw

class ScriptBlock extends Ast, TScriptBlock {
  final override Ast getAChild() {
    result = getSynthChild(this, _)
    or
    exists(Raw::ScriptBlock block | toRaw(this) = block |
      toRaw(result) = block.getBeginBlock() or
      toRaw(result) = block.getEndBlock() or
      toRaw(result) = block.getProcessBlock()
    )
  }
}
