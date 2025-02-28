private import TAst
private import semmle.code.powershell.ast.internal.Stmt

class Configuration extends Stmt, TConfiguration {
  override string toString() { result = "Configuration" }
}
