private import TAst
private import Internal
private import Raw.Raw as Raw

class UsingExpr extends Expr, TUsingExpr {
  override string toString() { result = "$using..." }

  Expr getExpr() {
    synthChild(this, usingExprExpr(), result)
    or
    not synthChild(this, usingExprExpr(), _) and
    toRaw(result) = toRaw(this).(Raw::UsingExpr).getExpr()
  }

  override Ast getChild(ChildIndex i) {
    result = super.getChild(i)
    or
    i = usingExprExpr() and
    result = this.getExpr()
  }
}
