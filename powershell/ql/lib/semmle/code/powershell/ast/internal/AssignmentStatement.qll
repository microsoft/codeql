private import TAst
private import Raw.Raw as Raw
private import Internal

class AssignStmt extends Stmt, TAssignStmt {
  Expr getRightHandSide() {
    synthChild(this, 1, result)
    or
    not synthChild(this, 1, _) and
    toRaw(result) = toRaw(this).(Raw::AssignStmt).getRightHandSide()
  }

  Expr getLeftHandSide() {
    synthChild(this, 0, result)
    or
    not synthChild(this, 0, _) and
    toRaw(result) = toRaw(this).(Raw::AssignStmt).getLeftHandSide()
  }

  override Ast getChild(int i) {
    i = 0 and
    result = this.getLeftHandSide()
    or
    i = 1 and
    result = this.getRightHandSide()
  }

  override string toString() { result = "...=..." }
}
