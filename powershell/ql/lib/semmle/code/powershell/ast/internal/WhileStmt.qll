private import TAst
private import Internal
private import Raw.Raw as Raw

class WhileStmt extends LoopStmt, TWhileStmt {
  override string toString() { result = "while(...) {...}" }

  Expr getCondition() {
    synthChild(this, whileStmtCond(), result)
    or
    not synthChild(this, whileStmtCond(), _) and
    toRaw(result) = toRaw(this).(Raw::WhileStmt).getCondition()
  }

  final override StmtBlock getBody() {
    synthChild(this, whileStmtBody(), result)
    or
    not synthChild(this, whileStmtBody(), _) and
    toRaw(result) = toRaw(this).(Raw::WhileStmt).getBody()
  }

  final override Ast getChild(ChildIndex i) {
    i = whileStmtCond() and
    result = this.getCondition()
    or
    i = whileStmtBody() and
    result = this.getBody()
  }
}
