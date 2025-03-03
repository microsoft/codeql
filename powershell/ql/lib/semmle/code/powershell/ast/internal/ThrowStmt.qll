private import TAst
private import Internal
private import Raw.Raw as Raw

class ThrowStmt extends Stmt, TThrowStmt {
  Expr getPipeline() {
    synthChild(this, throwStmtPipeline(), result)
    or
    not synthChild(this, throwStmtPipeline(), _) and
    toRaw(result) = toRaw(this).(Raw::ThrowStmt).getPipeline()
  }

  predicate hasPipeline() { exists(this.getPipeline()) }

  override string toString() {
    if this.hasPipeline() then result = "throw ..." else result = "throw"
  }

  final override Ast getChild(ChildIndex i) {
    i = throwStmtPipeline() and result = this.getPipeline()
  }
}
