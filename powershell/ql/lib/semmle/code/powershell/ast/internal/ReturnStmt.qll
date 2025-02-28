private import Ast
private import TAst
private import semmle.code.powershell.ast.internal.Stmt
private import Raw.Raw as Raw
private import Pipeline

class ReturnStmt extends Stmt, TReturnStmt {
  override Ast getChild(int i) {
    i = 0 and
    result = this.getPipeline()
  }

  Pipeline getPipeline() {
    synthChild(this, 0, result)
    or
    not synthChild(this, 0, _) and
    toRaw(result) = toRaw(this).(Raw::ReturnStmt).getPipeline()
  }
}
