private import TAst
private import Internal
private import Raw.Raw as Raw

class SwitchStmt extends Stmt, TSwitchStmt {
  final override string toString() { result = "switch(...) {...}" }

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

  final override Ast getChild(int i) {
    i = -2 and
    result = this.getCondition()
    or
    i = -1 and
    result = this.getDefault()
    or
    result = this.getCase(i)
    or
    i >= this.getNumberOfCases() and
    result = this.getPattern(i - this.getNumberOfCases())
  }

  Expr getAPattern() { result = this.getPattern(_) }
}
