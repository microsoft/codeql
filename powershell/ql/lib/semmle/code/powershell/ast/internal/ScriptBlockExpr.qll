private import TAst
private import Internal
private import Raw.Raw as Raw

class ScriptBlockExpr extends Expr, TScriptBlockExpr {
  ScriptBlock getBody() {
    synthChild(this, 0, result)
    or
    not synthChild(this, 0, _) and
    toRaw(result) = toRaw(this).(Raw::ScriptBlockExpr).getBody()
  }
}

// TODO: Finish all the other classes after ScriptBlockExpr