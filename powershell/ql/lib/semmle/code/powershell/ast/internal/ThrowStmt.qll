private import TAst
private import Internal
private import Raw.Raw as Raw

class ThrowStmt extends Stmt, TThrowStmt {
  Expr getPipeline() {
    synthChild(this, 0, result)
    or
    not synthChild(this, 0, _) and
    toRaw(result) = toRaw(this).(Raw::ThrowStmt).getPipeline()
  }

  predicate hasPipeline() { exists(this.getPipeline()) }
}
