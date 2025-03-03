private import Raw.Raw as Raw
private import Internal
private import TAst

class NamedBlock extends Ast, TNamedBlock {
  override string toString() { result = "{...}" }

  Stmt getStmt(int i) {
    synthChild(this, namedBlockStmt(i), result)
    or
    not synthChild(this, namedBlockStmt(i), _) and
    toRaw(result) = toRaw(this).(Raw::NamedBlock).getStmt(i)
  }

  TrapStmt getTrap(int i) {
    synthChild(this, namedBlockTrap(i), result)
    or
    not synthChild(this, namedBlockTrap(i), _) and
    toRaw(result) = toRaw(this).(Raw::NamedBlock).getTrap(i)
  }

  Stmt getAStmt() { result = this.getStmt(_) }

  final override Ast getChild(ChildIndex i) {
    exists(int index |
      i = namedBlockStmt(index) and
      result = this.getStmt(index)
      or
      i = namedBlockTrap(index) and
      result = this.getTrap(index)
    )
  }
}

/** A `process` block. */
class ProcessBlock extends NamedBlock {
  ScriptBlock scriptBlock;

  ProcessBlock() { scriptBlock.getProcessBlock() = this }

  ScriptBlock getScriptBlock() { result = scriptBlock }
  // PipelineParameter getPipelineParameter() {
  //   result = scriptBlock.getEnclosingFunction().getAParameter()
  // }
  // PipelineByPropertyNameParameter getAPipelineByPropertyNameParameter() {
  //   result = scriptBlock.getEnclosingFunction().getAParameter()
  // }
}
