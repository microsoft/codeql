private import Raw

class NamedBlock extends @named_block, Ast {
  override string toString() { result = "{...}" }

  override SourceLocation getLocation() { named_block_location(this, result) }

  int getNumStatements() { named_block(this, result, _) }

  int getNumTraps() { named_block(this, _, result) }

  Stmt getStmt(int i) { named_block_statement(this, i, result) }

  Stmt getAStmt() { result = this.getStmt(_) }

  TrapStmt getTrap(int i) { named_block_trap(this, i, result) }

  TrapStmt getATrap() { result = this.getTrap(_) }

  final override Ast getChild(int i) {
    exists(int k |
      i = 2 * k and
      result = this.getStmt(k)
      or
      i = 2 * k + 1 and
      result = this.getTrap(k)
    )
  }
}

/** A `process` block. */
class ProcessBlock extends NamedBlock {
  ScriptBlock scriptBlock;

  ProcessBlock() { scriptBlock.getProcessBlock() = this }
}
