private import TAst
private import Internal
private import Raw.Raw as Raw

class ConvertExpr extends Expr, TConvertExpr {
  Expr getBase() {
    synthChild(this, 0, result)
    or
    not synthChild(this, 0, _) and
    toRaw(result) = toRaw(this).(Raw::ConvertExpr).getBase()
  }

  TypeConstraint getType() {
    synthChild(this, 1, result)
    or
    not synthChild(this, 1, _) and
    toRaw(result) = toRaw(this).(Raw::ConvertExpr).getType()
  }

  AttributeBase getAttribute() {
    synthChild(this, 2, result)
    or
    not synthChild(this, 2, _) and
    toRaw(result) = toRaw(this).(Raw::ConvertExpr).getAttribute()
  }
}
