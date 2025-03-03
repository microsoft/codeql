private import TAst
private import Internal
private import Raw.Raw as Raw

class TryStmt extends Stmt, TTryStmt {
  CatchClause getCatchClause(int i) {
    synthChild(this, tryStmtCatchClause(i), result)
    or
    not synthChild(this, tryStmtCatchClause(i), _) and
    toRaw(result) = toRaw(this).(Raw::TryStmt).getCatchClause(i)
  }

  CatchClause getACatchClause() { result = this.getCatchClause(_) }

  /** ..., if any. */
  StmtBlock getFinally() {
    synthChild(this, tryStmtFinally(), result)
    or
    not synthChild(this, tryStmtFinally(), _) and
    toRaw(result) = toRaw(this).(Raw::TryStmt).getFinally()
  }

  predicate hasFinally() { exists(this.getFinally()) }

  StmtBlock getBody() {
    synthChild(this, tryStmtBody(), result)
    or
    not synthChild(this, tryStmtBody(), _) and
    toRaw(result) = toRaw(this).(Raw::TryStmt).getBody()
  }

  override string toString() { result = "try {...}" }

  final override Ast getChild(ChildIndex i) {
    i = tryStmtBody() and
    result = this.getBody()
    or
    exists(int index |
      i = tryStmtCatchClause(index) and
      result = this.getCatchClause(index)
    )
    or
    i = tryStmtFinally() and
    result = this.getFinally()
  }
}
