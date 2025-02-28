private import TAst
private import Internal
private import Raw.Raw as Raw

class ConditionalExpr extends Expr, TConditionalExpr {
  Expr getCondition() {
    synthChild(this, 0, result)
    or
    not synthChild(this, 0, _) and
    toRaw(result) = toRaw(this).(Raw::ConditionalExpr).getCondition()
  }

  Expr getIfFalse() {
    synthChild(this, 1, result)
    or
    not synthChild(this, 1, _) and
    toRaw(result) = toRaw(this).(Raw::ConditionalExpr).getIfFalse()
  }

  Expr getIfTrue() {
    synthChild(this, 2, result)
    or
    not synthChild(this, 2, _) and
    toRaw(result) = toRaw(this).(Raw::ConditionalExpr).getIfTrue()
  }

  Expr getBranch(boolean value) {
    value = true and
    result = this.getIfTrue()
    or
    value = false and
    result = this.getIfFalse()
  }

  Expr getABranch() { result = this.getBranch(_) }
}
