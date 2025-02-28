private import TAst
private import Internal
private import Raw.Raw as Raw

class GotoStmt extends Stmt, TGotoStmt {
  Expr getLabel() {
    synthChild(this, 0, result)
    or
    not synthChild(this, 0, _) and
    toRaw(result) = toRaw(this).(Raw::GotoStmt).getLabel()
  }
}
