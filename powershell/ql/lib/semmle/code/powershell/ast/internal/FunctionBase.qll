private import TAst
private import Internal
private import Raw.Raw as Raw

class FunctionBase extends Ast, TFunction {
  final override string toString() { result = this.getName() }

  string getName() { none() }

  ScriptBlock getBody() { none() }

  Parameter getParameter(int i) { none() }
}
