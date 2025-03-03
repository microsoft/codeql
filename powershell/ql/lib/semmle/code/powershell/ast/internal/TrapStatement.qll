private import TAst
private import Internal
private import Raw.Raw as Raw

class TrapStmt extends Stmt, TTrapStmt {
  StmtBlock getBody() {
    synthChild(this, trapStmtBody(), result)
    or
    not synthChild(this, trapStmtBody(), _) and
    toRaw(result) = toRaw(this).(Raw::TrapStmt).getBody()
  }

  override Ast getChild(ChildIndex i) {
    i = trapStmtBody() and
    result = this.getBody()
  }
}
