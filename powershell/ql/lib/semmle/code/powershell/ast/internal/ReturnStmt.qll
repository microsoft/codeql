private import Ast
private import TAst
private import semmle.code.powershell.ast.internal.Stmt
private import Raw.Raw as Raw
private import Pipeline

class ReturnStmt extends Stmt, TReturnStmt {
  override string toString() {
    if this.hasPipeline() then result = "return ..." else result = "return"
  }

  override Ast getChild(int i) {
    i = 0 and
    result = this.getPipeline()
  }

  predicate hasPipeline() { exists(this.getPipeline()) }

  Pipeline getPipeline() {
    synthChild(this, 0, result)
    or
    not synthChild(this, 0, _) and
    toRaw(result) = toRaw(this).(Raw::ReturnStmt).getPipeline()
  }
}
