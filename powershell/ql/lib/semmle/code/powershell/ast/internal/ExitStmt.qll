private import TAst
private import Internal
private import Raw.Raw as Raw

class ExitStmt extends Stmt, TExitStmt {
  Expr getPipeline() {
    synthChild(this, exitStmtPipeline(), result)
    or
    not synthChild(this, exitStmtPipeline(), _) and
    toRaw(result) = toRaw(this).(Raw::ExitStmt).getPipeline()
  }

  predicate hasPipeline() { exists(this.getPipeline()) }

  override string toString() { if this.hasPipeline() then result = "exit ..." else result = "exit" }

  final override Ast getChild(ChildIndex i) { i = exitStmtPipeline() and result = this.getPipeline() }
}
