private import TAst
private import Internal
private import Raw.Raw as Raw

class ConvertExpr extends AttributedExprBase, TConvertExpr {
  override string toString() { result = "[...]..." }

  final override Expr getExpr() {
    synthChild(this, convertExprExpr(), result)
    or
    not synthChild(this, convertExprExpr(), _) and
    toRaw(result) = toRaw(this).(Raw::ConvertExpr).getExpr()
  }

  TypeConstraint getType() {
    synthChild(this, convertExprType(), result)
    or
    not synthChild(this, convertExprType(), _) and
    toRaw(result) = toRaw(this).(Raw::ConvertExpr).getType()
  }

  final override AttributeBase getAttribute() {
    synthChild(this, convertExprAttr(), result)
    or
    not synthChild(this, convertExprAttr(), _) and
    toRaw(result) = toRaw(this).(Raw::ConvertExpr).getAttribute()
  }

  final override Ast getChild(ChildIndex i) {
    result = super.getChild(i)
    or
    i = convertExprExpr() and result = this.getExpr()
    or
    i = convertExprType() and result = this.getType()
    or
    i = convertExprAttr() and result = this.getAttribute()
  }
}
