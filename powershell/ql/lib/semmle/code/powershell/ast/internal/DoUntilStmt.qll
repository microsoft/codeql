private import TAst
private import Internal
private import Raw.Raw as Raw

class DoUntilStmt extends LoopStmt, TDoUntilStmt {
  Expr getCondition() {
    // TODO: Check return types here
    synthChild(this, 0, result)
    or
    not synthChild(this, 0, _) and
    toRaw(result) = toRaw(this).(Raw::DoUntilStmt).getCondition()
  }

  final override StmtBlock getBody() {
    synthChild(this, 1, result)
    or
    not synthChild(this, 1, _) and
    toRaw(result) = toRaw(this).(Raw::DoUntilStmt).getBody()
  }
}
