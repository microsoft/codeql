private import TAst
private import Internal
private import Raw.Raw as Raw

class ConditionalExpr extends Expr, TConditionalExpr {
  override string toString() { result = "...?...:..." }

  final override Ast getChild(ChildIndex i) {
    result = super.getChild(i)
    or
    i = condExprCond() and
    result = this.getCondition()
    or
    i = condExprTrue() and
    result = this.getIfTrue()
    or
    i = condExprFalse() and
    result = this.getIfFalse()
  }

  Expr getCondition() {
    synthChild(this, condExprCond(), result)
    or
    not synthChild(this, condExprCond(), _) and
    toRaw(result) = toRaw(this).(Raw::ConditionalExpr).getCondition()
  }

  Expr getIfFalse() {
    synthChild(this, condExprFalse(), result)
    or
    not synthChild(this, condExprCond(), _) and
    toRaw(result) = toRaw(this).(Raw::ConditionalExpr).getIfFalse()
  }

  Expr getIfTrue() {
    synthChild(this, condExprTrue(), result)
    or
    not synthChild(this, condExprTrue(), _) and
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
