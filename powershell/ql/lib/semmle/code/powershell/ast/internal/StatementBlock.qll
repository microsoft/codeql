private import TAst
private import Raw.Raw as Raw
private import Internal

class StmtBlock extends Stmt, TStmtBlock {
  Stmt getStmt(int index) {
    exists(int k | k = -(index + 1) |
      synthChild(this, k, result)
      or
      not synthChild(this, k, _) and
      toRaw(result) = toRaw(this).(Raw::StmtBlock).getStmt(index)
    )
  }

  Stmt getAStmt() { result = this.getStmt(_) }

  TrapStmt getTrapStmt(int index) {
    exists(int k | k = index + 1 |
      synthChild(this, k, result)
      or
      not synthChild(this, k, _) and
      toRaw(result) = toRaw(this).(Raw::StmtBlock).getTrapStmt(index)
    )
  }

  TrapStmt getATrapStmt() { result = this.getTrapStmt(_) }

  int getNumberOfStmts() { result = count(this.getAStmt()) }

  final override Ast getChild(int i) {
    exists(int k |
      k = -(i + 1) and
      result = this.getStmt(k)
      or
      k = i + 1 and
      result = this.getTrapStmt(k)
    )
  }

  override string toString() { result = "{...}" }
}

