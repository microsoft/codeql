private import TAst
private import Raw.Raw as Raw
private import Internal

class StmtBlock extends Stmt, TStmtBlock {
  Stmt getStmt(int index) {
    synthChild(this, index, result)
    or
    not synthChild(this, index, _) and
    toRaw(result) = toRaw(this).(Raw::StmtBlock).getStmt(index)
  }

  Stmt getAStmt() { result = this.getStmt(_) }

  int getNumberOfStmts() { result = count(this.getAStmt()) }
}
