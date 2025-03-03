private import TAst
private import Raw.Raw as Raw
private import Internal

class AssignStmt extends Stmt, TAssignStmt {
  Expr getRightHandSide() {
    synthChild(this, assignStmtRightHandSide(), result)
    or
    not synthChild(this, assignStmtRightHandSide(), _) and
    toRaw(result) = toRaw(this).(Raw::AssignStmt).getRightHandSide()
  }

  Expr getLeftHandSide() {
    synthChild(this, assignStmtLeftHandSide(), result)
    or
    not synthChild(this, assignStmtLeftHandSide(), _) and
    toRaw(result) = toRaw(this).(Raw::AssignStmt).getLeftHandSide()
  }

  override Ast getChild(ChildIndex i) {
    i = assignStmtLeftHandSide() and
    result = this.getLeftHandSide()
    or
    i = assignStmtRightHandSide() and
    result = this.getRightHandSide()
  }

  override string toString() { result = "...=..." }
}
