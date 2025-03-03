private import TAst
private import Raw.Raw as Raw
private import Internal

class StmtBlock extends Stmt, TStmtBlock {
  Stmt getStmt(int index) {
    synthChild(this, stmtBlockStmt(index), result)
    or
    not synthChild(this, stmtBlockStmt(index), _) and
    toRaw(result) = toRaw(this).(Raw::StmtBlock).getStmt(index)
  }

  Stmt getAStmt() { result = this.getStmt(_) }

  TrapStmt getTrapStmt(int index) {
    synthChild(this, stmtBlockTrapStmt(index), result)
    or
    not synthChild(this, stmtBlockTrapStmt(index), _) and
    toRaw(result) = toRaw(this).(Raw::StmtBlock).getTrapStmt(index)
  }

  TrapStmt getATrapStmt() { result = this.getTrapStmt(_) }

  int getNumberOfStmts() { result = count(this.getAStmt()) }

  final override Ast getChild(ChildIndex i) {
    exists(int index |
      i = stmtBlockStmt(index) and
      result = this.getStmt(index)
      or
      i = stmtBlockTrapStmt(index) and
      result = this.getTrapStmt(index)
    )
  }

  override string toString() { result = "{...}" }
}
