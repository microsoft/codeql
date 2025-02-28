private import TAst
private import Internal
private import Raw.Raw as Raw

class IndexExpr extends Expr, TIndexExpr {
  Expr getIndex() {
    synthChild(this, 0, result)
    or
    not synthChild(this, 0, _) and
    toRaw(result) = toRaw(this).(Raw::IndexExpr).getIndex()
  }

  Expr getBase() {
    synthChild(this, 1, result)
    or
    not synthChild(this, 1, _) and
    toRaw(result) = toRaw(this).(Raw::IndexExpr).getBase()
  }

  predicate isNullConditional() { toRaw(this).(Raw::IndexExpr).isNullConditional() }
}
