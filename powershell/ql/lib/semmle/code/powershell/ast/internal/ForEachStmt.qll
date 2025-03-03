private import TAst
private import Internal
private import Raw.Raw as Raw

class ForEachStmt extends LoopStmt, TForEachStmt {
  override string toString() { result = "forach(... in ...)" }

  final override StmtBlock getBody() {
    synthChild(this, forEachStmtBody(), result)
    or
    not synthChild(this, forEachStmtBody(), _) and
    toRaw(result) = toRaw(this).(Raw::ForEachStmt).getBody()
  }

  // TODO: Should this API change?
  VarAccess getVarAccess() {
    synthChild(this, forEachStmtVar(), result)
    or
    not synthChild(this, forEachStmtVar(), _) and
    toRaw(result) = toRaw(this).(Raw::ForEachStmt).getVarAccess()
  }

  Expr getIterableExpr() {
    synthChild(this, forEachStmtIter(), result)
    or
    not synthChild(this, forEachStmtIter(), _) and
    toRaw(result) = toRaw(this).(Raw::ForEachStmt).getIterableExpr()
  }

  final override Ast getChild(ChildIndex i) {
    i = forEachStmtVar() and result = this.getVarAccess()
    or
    i = forEachStmtIter() and result = this.getIterableExpr()
    or
    i = forEachStmtBody() and result = this.getBody()
  }
}
