private import TAst
private import semmle.code.powershell.ast.internal.Stmt

class BreakStmt extends Stmt, TBreakStmt {
  override string toString() { result = "break" }
}
