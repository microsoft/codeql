private import TAst
private import Internal
private import Raw.Raw as Raw

class WhileStmt extends LoopStmt, TWhileStmt {
  Expr getCondition() {
    synthChild(this, 0, result)
    or
    not synthChild(this, 0, _) and
    toRaw(result) = toRaw(this).(Raw::WhileStmt).getCondition()
  }

  final override StmtBlock getBody() {
    synthChild(this, 1, result)
    or
    not synthChild(this, 1, _) and
    toRaw(result) = toRaw(this).(Raw::WhileStmt).getBody()
  }
}
