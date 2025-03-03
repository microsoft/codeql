private import TAst
private import Internal
private import Raw.Raw as Raw

class SwitchStmt extends Stmt, TSwitchStmt {
  final override string toString() { result = "switch(...) {...}" }

  Expr getCondition() {
    synthChild(this, switchStmtCond(), result)
    or
    not synthChild(this, switchStmtCond(), _) and
    toRaw(result) = toRaw(this).(Raw::SwitchStmt).getCondition()
  }

  StmtBlock getDefault() {
    synthChild(this, switchStmtDefault(), result)
    or
    not synthChild(this, switchStmtDefault(), _) and
    toRaw(result) = toRaw(this).(Raw::SwitchStmt).getDefault()
  }

  StmtBlock getCase(int i) {
    synthChild(this, switchStmtCase(i), result)
    or
    not synthChild(this, switchStmtCase(i), _) and
    toRaw(result) = toRaw(this).(Raw::SwitchStmt).getCase(i)
  }

  StmtBlock getACase() { result = this.getCase(_) }

  int getNumberOfCases() { result = toRaw(this).(Raw::SwitchStmt).getNumberOfCases() }

  Expr getPattern(int i) {
    synthChild(this, switchStmtPat(i), result)
    or
    not synthChild(this, switchStmtPat(i), _) and
    toRaw(result) = toRaw(this).(Raw::SwitchStmt).getPattern(i)
  }

  final override Ast getChild(ChildIndex i) {
    i = switchStmtCond() and
    result = this.getCondition()
    or
    i = switchStmtDefault() and
    result = this.getDefault()
    or
    exists(int index |
      i = switchStmtCase(index) and
      result = this.getCase(index)
      or
      i = switchStmtPat(index) and
      result = this.getPattern(index)
    )
  }

  Expr getAPattern() { result = this.getPattern(_) }
}
