private import TAst
private import Internal
private import Raw.Raw as Raw

class Method extends Member, FunctionBase, TMethod {
  final override string getName() { result = toRaw(this).(Raw::Method).getName() }

  final override ScriptBlock getBody() {
    synthChild(this, 0, result)
    or
    not synthChild(this, 0, _) and
    toRaw(result) = toRaw(this).(Raw::Method).getBody()
  }

  final override Parameter getParameter(int i) { result = this.getBody().getParameter(i) }
}
