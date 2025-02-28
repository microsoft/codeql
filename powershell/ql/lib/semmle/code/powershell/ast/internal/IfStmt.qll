private import TAst
private import Raw.Raw as Raw
private import Internal

class IfStmt extends Stmt, TIfStmt {
  override string toString() {
    if this.hasElse() then result = "if (...) {...} else {...}" else result = "if (...) {...}"
  }

  final override Ast getChild(int i) {
    i = 0 and
    result = this.getElse()
    or
    result = this.getCondition(-(i + 1))
    or
    result = this.getThen(i + 1)
  }

  Expr getCondition(int i) {
    exists(int k | k = -(i + 1) |
      synthChild(this, k, result)
      or
      not synthChild(this, k, _) and
      toRaw(result) = toRaw(this).(Raw::IfStmt).getCondition(i)
    )
  }

  Expr getACondition() { result = this.getCondition(_) }

  int getNumberOfConditions() { result = count(this.getACondition()) }

  StmtBlock getThen(int i) {
    exists(int k | k = i + 1 |
      synthChild(this, k, result)
      or
      not synthChild(this, k, _) and
      toRaw(result) = toRaw(this).(Raw::IfStmt).getThen(i)
    )
  }

  StmtBlock getAThen() { result = this.getThen(_) }

  StmtBlock getElse() {
    synthChild(this, 0, result)
    or
    not synthChild(this, 0, _) and
    toRaw(result) = toRaw(this).(Raw::IfStmt).getElse()
  }

  predicate hasElse() { exists(this.getElse()) }
}
