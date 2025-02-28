private import TAst
private import Internal
private import Raw.Raw as Raw

class ExpandableSubExpr extends Expr, TExpandableSubExpr {
  StmtBlock getExpr() {
    synthChild(this, 0, result)
    or
    not synthChild(this, 0, _) and
    toRaw(result) = toRaw(this).(Raw::ExpandableSubExpr).getExpr()
  }
}
