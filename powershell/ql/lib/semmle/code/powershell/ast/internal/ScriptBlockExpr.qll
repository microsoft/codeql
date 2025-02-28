private import TAst
private import Internal
private import Raw.Raw as Raw

class ScriptBlockExpr extends Expr, TScriptBlockExpr {
  override string toString() { result = "{...}" }

  ScriptBlock getBody() {
    synthChild(this, 0, result)
    or
    not synthChild(this, 0, _) and
    toRaw(result) = toRaw(this).(Raw::ScriptBlockExpr).getBody()
  }

  final override Ast getChild(int i) { i = 0 and result = this.getBody() }
}
