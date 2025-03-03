private import TAst
private import Internal
private import Raw.Raw as Raw

class ExpandableStringExpr extends Expr, TExpandableStringExpr {
  string getUnexpandedValue() {
    result = toRaw(this).(Raw::ExpandableStringExpr).getUnexpandedValue().getValue()
  }

  override string toString() { result = this.getUnexpandedValue() }

  Expr getExpr(int i) {
    synthChild(this, expandableStringExprExpr(i), result)
    or
    not synthChild(this, expandableStringExprExpr(i), _) and
    toRaw(result) = toRaw(this).(Raw::ExpandableStringExpr).getExpr(i)
  }

  Expr getAnExpr() { result = this.getExpr(_) }

  final override Ast getChild(ChildIndex i) {
    result = super.getChild(i)
    or
    exists(int index |
      i = expandableStringExprExpr(index) and
      result = this.getExpr(index)
    )
  }
}
