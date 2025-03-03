private import Ast
private import TAst
private import Internal
private import Raw.Raw as Raw

class ReturnStmt extends Stmt, TReturnStmt {
  override string toString() {
    if this.hasPipeline() then result = "return ..." else result = "return"
  }

  override Ast getChild(ChildIndex i) {
    i = returnStmtPipeline() and
    result = this.getPipeline()
  }

  predicate hasPipeline() { exists(this.getPipeline()) }

  Expr getPipeline() {
    synthChild(this, returnStmtPipeline(), result)
    or
    not synthChild(this, returnStmtPipeline(), _) and
    toRaw(result) = toRaw(this).(Raw::ReturnStmt).getPipeline()
  }
}
