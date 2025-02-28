private import Raw.Raw as Raw
private import Internal
private import TAst

class NamedBlock extends Ast, TNamedBlock {
  override string toString() { result = "{...}" }

  Stmt getStmt(int i) {
    exists(int k | k = -(i + 1) |
      synthChild(this, k, result)
      or
      not synthChild(this, k, _) and
      toRaw(result) = toRaw(this).(Raw::NamedBlock).getStmt(i)
    )
  }

  TrapStmt getTrap(int i) {
    exists(int k | k = i + 1 |
      synthChild(this, k, result)
      or
      not synthChild(this, k, _) and
      toRaw(result) = toRaw(this).(Raw::NamedBlock).getTrap(i)
    )
  }

  Stmt getAStmt() { result = this.getStmt(_) }

  final override Ast getChild(int i) {
    result = this.getStmt(-(i + 1))
    or
    result = this.getTrap(i + 1)
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
