private import TAst
private import Internal
private import Raw.Raw as Raw

class ParenExpr extends Expr, TParenExpr {
  Expr getExpr() {
    synthChild(this, parenExprExpr(), result)
    or
    not synthChild(this, parenExprExpr(), _) and
    toRaw(result) = toRaw(this).(Raw::ParenExpr).getBase()
  }

  override string toString() { result = "(...)" }

  final override Ast getChild(ChildIndex i) {
    result = super.getChild(i)
    or
    i = parenExprExpr() and result = this.getExpr()
  }
}
