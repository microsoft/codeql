private import TAst
private import Internal
private import Raw.Raw as Raw

class AttributedExpr extends AttributedExprBase, TAttributedExpr {
  final override string toString() { result = "[...]" + this.getExpr().toString() }

  final override Expr getExpr() {
    synthChild(this, attributedExprExpr(), result)
    or
    not synthChild(this, attributedExprExpr(), _) and
    toRaw(result) = toRaw(this).(Raw::AttributedExpr).getExpr()
  }

  final override Attribute getAttribute() {
    synthChild(this, attributedExprAttr(), result)
    or
    not synthChild(this, attributedExprAttr(), _) and
    toRaw(result) = toRaw(this).(Raw::AttributedExpr).getAttribute()
  }

  override Ast getChild(ChildIndex i) {
    result = super.getChild(i)
    or
    i = attributedExprExpr() and result = this.getExpr()
    or
    i = attributedExprAttr() and
    result = this.getAttribute()
  }
}
