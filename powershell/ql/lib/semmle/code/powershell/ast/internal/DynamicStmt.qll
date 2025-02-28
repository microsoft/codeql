private import TAst
private import semmle.code.powershell.ast.internal.Stmt

class DynamicStmt extends Stmt, TDynamicStmt {
  override string toString() { result = "&..." }
  // TODO
}
