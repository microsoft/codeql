private import TAst
private import Internal
private import Raw.Raw as Raw

class FunctionDefinitionStmt extends Stmt, TFunctionDefinitionStmt {
  ScriptBlock getBody() {
    synthChild(this, 0, result)
    or
    not synthChild(this, 0, _) and
    toRaw(result) = toRaw(this).(Raw::FunctionDefinitionStmt).getBody()
  }

  string getName() { result = toRaw(this).(Raw::FunctionDefinitionStmt).getName() }

  Parameter getParameter(int i) { result = this.getBody().getParameter(i) }

  Parameter getAParameter() { result = this.getParameter(_) }

  final override Ast getChild(int i) { i = 0 and result = this.getBody() }
}
