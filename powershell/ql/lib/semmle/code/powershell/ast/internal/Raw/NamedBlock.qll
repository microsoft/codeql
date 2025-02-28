private import Raw

class NamedBlock extends @named_block, Ast {
  override SourceLocation getLocation() { named_block_location(this, result) }

  int getNumStatements() { named_block(this, result, _) }

  int getNumTraps() { named_block(this, _, result) }

  Stmt getStmt(int i) { named_block_statement(this, i, result) }

  Stmt getAStmt() { result = this.getStmt(_) }

  TrapStmt getTrap(int i) { named_block_trap(this, i, result) }

  TrapStmt getATrap() { result = this.getTrap(_) }

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
}
