private import TAst
private import Internal
private import Raw.Raw as Raw

class SwitchStmt extends Stmt, TSwitchStmt {
  Expr getCondition() {
    synthChild(this, -2, result)
    or
    not synthChild(this, -2, _) and
    toRaw(result) = toRaw(this).(Raw::SwitchStmt).getCondition()
  }

  StmtBlock getDefault() {
    synthChild(this, -1, result)
    or
    not synthChild(this, -1, _) and
    toRaw(result) = toRaw(this).(Raw::SwitchStmt).getDefault()
  }

  StmtBlock getCase(int i) {
    synthChild(this, i, result)
    or
    not synthChild(this, i, _) and
    toRaw(result) = toRaw(this).(Raw::SwitchStmt).getCase(i)
  }

  StmtBlock getACase() { result = this.getCase(_) }

  int getNumberOfCases() { result = toRaw(this).(Raw::SwitchStmt).getNumberOfCases() }

  Expr getPattern(int i) {
    exists(int k | k = i - this.getNumberOfCases() |
      synthChild(this, k, result)
      or
      not synthChild(this, k, _) and
      toRaw(result) = toRaw(this).(Raw::SwitchStmt).getPattern(i)
    )
  }

  Expr getAPattern() { result = this.getPattern(_) }
}
