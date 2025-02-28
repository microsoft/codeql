private import Raw

class FunctionDefinitionStmt extends @function_definition, Stmt {
  override string toString() { result = this.getName() }

  override Location getLocation() { function_definition_location(this, result) }

  ScriptBlock getBody() { function_definition(this, result, _, _, _) }

  string getName() { function_definition(this, _, result, _, _) }

  Parameter getParameter(int i) { function_definition_parameter(this, i, result) }

  Parameter getAParameter() { result = this.getParameter(_) }

  override Ast getChild(int i) {
    i = -1 and result = this.getBody()
    or
    result = this.getParameter(i)
  }
}
