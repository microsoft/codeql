private import TAst
private import Internal
private import Raw.Raw as Raw

class ParenExpr extends Expr, TParenExpr {
  Expr getExpr() {
    synthChild(this, 0, result)
    or
    not synthChild(this, 0, _) and
    toRaw(result) = toRaw(this).(Raw::ParenExpr).getBase()
  }

  override string toString() { result = "(...)" }

  final override Ast getChild(int i) { i = 0 and result = this.getExpr() }
}
