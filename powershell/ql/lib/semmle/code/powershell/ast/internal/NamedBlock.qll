private import Raw.Raw as Raw
private import Internal
private import TAst

class NamedBlock extends Ast, TNamedBlock {
  override Ast getChild(int i) { result = this.getStmt(i) }

  Stmt getStmt(int i) {
    synthChild(this, i, result)
    or
    not synthChild(this, i, _) and
    toRaw(result) = toRaw(this).(Raw::NamedBlock).getStmt(i)
  }

  Stmt getAStmt() { result = this.getStmt(_) }
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
