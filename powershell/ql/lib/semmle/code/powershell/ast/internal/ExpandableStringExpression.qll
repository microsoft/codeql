private import TAst
private import Internal
private import Raw.Raw as Raw

class ExpandableStringExpr extends Expr, TExpandableStringExpr {
  string getUnexpandedValue() {
    result = toRaw(this).(Raw::ExpandableStringExpr).getUnexpandedValue().getValue()
  }

  Expr getExpr(int i) {
    synthChild(this, i, result)
    or
    not synthChild(this, i, _) and
    toRaw(result) = toRaw(this).(Raw::ExpandableStringExpr).getExpr(i)
  }

  Expr getAnExpr() { result = this.getExpr(_) }
}
