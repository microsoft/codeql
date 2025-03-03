private import TAst
private import Internal
private import Raw.Raw as Raw

class DoUntilStmt extends LoopStmt, TDoUntilStmt {
  override string toString() { result = "do...until..." }

  Expr getCondition() {
    synthChild(this, doUntilStmtCond(), result)
    or
    not synthChild(this, doUntilStmtCond(), _) and
    toRaw(result) = toRaw(this).(Raw::DoUntilStmt).getCondition()
  }

  final override StmtBlock getBody() {
    synthChild(this, doUntilStmtBody(), result)
    or
    not synthChild(this, doUntilStmtBody(), _) and
    toRaw(result) = toRaw(this).(Raw::DoUntilStmt).getBody()
  }

  final override Ast getChild(ChildIndex i) {
    i = doUntilStmtCond() and result = this.getCondition()
    or
    i = doUntilStmtBody() and result = this.getBody()
  }
}
