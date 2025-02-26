private import Ast
private import TAst
private import semmle.code.powershell.ast.internal.Stmt
private import Raw.Raw as Raw

class ReturnStmt extends Stmt, TReturnStmt {
  override Ast getAChild() {
    result = getSynthChild(this, _)
    or
    exists(Raw::ReturnStmt stmt | toRaw(this) = stmt |
      toRaw(result) = stmt.getPipeline()
    )
  }
}
