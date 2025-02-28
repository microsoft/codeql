private import TAst
private import Internal
private import Raw.Raw as Raw

class TryStmt extends Stmt, TTryStmt {
  CatchClause getCatchClause(int i) {
    synthChild(this, i, result)
    or
    not synthChild(this, i, _) and
    toRaw(result) = toRaw(this).(Raw::TryStmt).getCatchClause(i)
  }

  CatchClause getACatchClause() { result = this.getCatchClause(_) }

  /** ..., if any. */
  StmtBlock getFinally() {
    synthChild(this, -2, result)
    or
    not synthChild(this, -2, _) and
    toRaw(result) = toRaw(this).(Raw::TryStmt).getFinally()
  }

  predicate hasFinally() { exists(this.getFinally()) }

  StmtBlock getBody() {
    synthChild(this, -1, result)
    or
    not synthChild(this, -1, _) and
    toRaw(result) = toRaw(this).(Raw::TryStmt).getBody()
  }
}
