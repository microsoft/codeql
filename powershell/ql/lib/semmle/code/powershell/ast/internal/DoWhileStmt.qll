private import TAst
private import Internal
private import Raw.Raw as Raw

class DoWhileStmt extends LoopStmt, TDoWhileStmt {
  override string toString() { result = "do...while..." }

  Expr getCondition() {
    synthChild(this, doWhileStmtCond(), result)
    or
    not synthChild(this, doWhileStmtCond(), _) and
    toRaw(result) = toRaw(this).(Raw::DoWhileStmt).getCondition()
  }

  final override StmtBlock getBody() {
    synthChild(this, doWhileStmtBody(), result)
    or
    not synthChild(this, doWhileStmtBody(), _) and
    toRaw(result) = toRaw(this).(Raw::DoWhileStmt).getBody()
  }

  final override Ast getChild(ChildIndex i) {
    i = doWhileStmtCond() and
    result = this.getCondition()
    or
    i = doWhileStmtBody() and
    result = this.getBody()
  }
}
