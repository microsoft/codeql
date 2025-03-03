private import TAst
private import Internal
private import Raw.Raw as Raw

class ScriptBlockExpr extends Expr, TScriptBlockExpr {
  override string toString() { result = "{...}" }

  ScriptBlock getBody() {
    synthChild(this, scriptBlockExprBody(), result)
    or
    not synthChild(this, scriptBlockExprBody(), _) and
    toRaw(result) = toRaw(this).(Raw::ScriptBlockExpr).getBody()
  }

  final override Ast getChild(ChildIndex i) {
    result = super.getChild(i)
    or
    i = scriptBlockExprBody() and result = this.getBody()
  }
}
