private import TAst
private import Internal
private import Raw.Raw as Raw

class DoWhileStmt extends LoopStmt, TDoWhileStmt {
  override string toString() { result = "do...while..." }

  Expr getCondition() {
    synthChild(this, 0, result)
    or
    not synthChild(this, 0, _) and
    toRaw(result) = toRaw(this).(Raw::DoWhileStmt).getCondition()
  }

  final override StmtBlock getBody() {
    synthChild(this, 1, result)
    or
    not synthChild(this, 1, _) and
    toRaw(result) = toRaw(this).(Raw::DoWhileStmt).getBody()
  }

  final override Ast getChild(int i) {
    i = 0 and
    result = this.getCondition()
    or
    i = 1 and
    result = this.getBody()
  }
}
