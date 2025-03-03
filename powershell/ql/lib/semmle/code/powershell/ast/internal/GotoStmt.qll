private import TAst
private import Internal
private import Raw.Raw as Raw

class GotoStmt extends Stmt, TGotoStmt {
  Expr getLabel() {
    synthChild(this, gotoStmtLabel(), result)
    or
    not synthChild(this, gotoStmtLabel(), _) and
    toRaw(result) = toRaw(this).(Raw::GotoStmt).getLabel()
  }

  final override Ast getChild(ChildIndex i) { i = gotoStmtLabel() and result = this.getLabel() }
}
