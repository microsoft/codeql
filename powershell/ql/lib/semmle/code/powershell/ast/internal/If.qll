private import TAst
private import Raw.Raw as Raw
private import Internal

class If extends Expr, TIf {
  override string toString() {
    if this.hasElse() then result = "if (...) {...} else {...}" else result = "if (...) {...}"
  }

  final override Ast getChild(ChildIndex i) {
    result = super.getChild(i)
    or
    i = ifStmtElse() and
    result = this.getElse()
    or
    exists(int index |
      i = ifStmtCond(index) and
      result = this.getCondition(index)
      or
      i = ifStmtThen(index) and
      result = this.getThen(index)
    )
  }

  Expr getCondition(int i) {
    synthChild(this, ifStmtCond(i), result)
    or
    not synthChild(this, ifStmtCond(i), _) and
    toRaw(result) = toRaw(this).(Raw::IfStmt).getCondition(i)
  }

  Expr getACondition() { result = this.getCondition(_) }

  int getNumberOfConditions() { result = count(this.getACondition()) }

  StmtBlock getThen(int i) {
    synthChild(this, ifStmtThen(i), result)
    or
    not synthChild(this, ifStmtThen(i), _) and
    toRaw(result) = toRaw(this).(Raw::IfStmt).getThen(i)
  }

  StmtBlock getAThen() { result = this.getThen(_) }

  StmtBlock getElse() {
    synthChild(this, ifStmtElse(), result)
    or
    not synthChild(this, ifStmtElse(), _) and
    toRaw(result) = toRaw(this).(Raw::IfStmt).getElse()
  }

  predicate hasElse() { exists(this.getElse()) }
}
