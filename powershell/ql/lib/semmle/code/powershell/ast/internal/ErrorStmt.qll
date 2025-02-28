private import TAst
private import semmle.code.powershell.ast.internal.Stmt

class ErrorStmt extends Stmt, TErrorStmt {
  final override string toString() { result = "error" }
}
