private import Raw.Raw as Raw
private import Ast
private import TAst

class NamedBlock extends Ast, TNamedBlock {
  override Ast getAChild() {
    result = getSynthChild(this, _)
    or
    exists(Raw::NamedBlock block | toRaw(this) = block | toRaw(result) = block.getAStmt())
  }
}
