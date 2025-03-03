private import TAst
private import Internal
private import Raw.Raw as Raw

class ExpandableSubExpr extends Expr, TExpandableSubExpr {
  StmtBlock getExpr() {
    synthChild(this, expandableSubExprExpr(), result)
    or
    not synthChild(this, expandableSubExprExpr(), _) and
    toRaw(result) = toRaw(this).(Raw::ExpandableSubExpr).getExpr()
  }

  final override string toString() { result = "$(...)" }

  final override Ast getChild(ChildIndex i) {
    result = super.getChild(i)
    or
    i = expandableSubExprExpr() and result = this.getExpr()
  }
}
