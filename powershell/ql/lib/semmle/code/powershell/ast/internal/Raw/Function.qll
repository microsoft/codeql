private import Raw

class FunctionDefinition extends @function_definition, Stmt {
  ScriptBlock getBody() { function_definition(this, result, _, _, _) }

  string getName() { function_definition(this, _, result, _, _) }
}
