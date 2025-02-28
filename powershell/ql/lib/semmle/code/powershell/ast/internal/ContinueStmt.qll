private import TAst
private import semmle.code.powershell.ast.internal.Stmt

class ContinueStmt extends Stmt, TContinueStmt {
  override string toString() { result = "continue" }
}
