private import TAst
private import Internal
private import Raw.Raw as Raw
private import Synthesis

class Function extends FunctionBase, TFunctionSynth {
  final override string getName() { any(Synthesis s).functionName(this, result) }

  final override ScriptBlock getBody() { any(Synthesis s).functionScriptBlock(this, result) }

  final override Parameter getParameter(int i) { result = this.getBody().getParameter(i) }

  final override Location getLocation() { result = any(Synthesis s).getLocation(this) }

  final override Ast getChild(ChildIndex i) { i = functionBody() and result = this.getBody() }
}
