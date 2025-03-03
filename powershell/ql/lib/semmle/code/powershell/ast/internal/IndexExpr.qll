private import TAst
private import Internal
private import Raw.Raw as Raw

class IndexExpr extends Expr, TIndexExpr {
  override string toString() { result = "...[...]" }

  final override Ast getChild(ChildIndex i) {
    result = super.getChild(i)
    or
    i = indexExprIndex() and result = this.getIndex()
    or
    i = indexExprBase() and result = this.getBase()
  }

  Expr getIndex() {
    synthChild(this, indexExprIndex(), result)
    or
    not synthChild(this, indexExprIndex(), _) and
    toRaw(result) = toRaw(this).(Raw::IndexExpr).getIndex()
  }

  Expr getBase() {
    synthChild(this, indexExprBase(), result)
    or
    not synthChild(this, indexExprBase(), _) and
    toRaw(result) = toRaw(this).(Raw::IndexExpr).getBase()
  }

  predicate isNullConditional() { toRaw(this).(Raw::IndexExpr).isNullConditional() }
}
