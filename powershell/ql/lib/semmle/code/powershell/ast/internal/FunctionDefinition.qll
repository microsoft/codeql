private import TAst
private import Internal
private import Raw.Raw as Raw

class FunctionDefinitionStmt extends Stmt, TFunctionDefinitionStmt {
  private FunctionBase getFunction() { synthChild(this, funDefFun(), result) }

  string getName() { result = toRaw(this).(Raw::FunctionDefinitionStmt).getName() }

  final override string toString() { result = "def of " + this.getName() }

  final override Ast getChild(ChildIndex i) { i = funDefFun() and result = this.getFunction() }
}
