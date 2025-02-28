private import TAst
private import Internal
private import Raw.Raw as Raw

class ForEachStmt extends LoopStmt, TForEachStmt {
  override string toString() { result = "forach(... in ...)" }

  final override StmtBlock getBody() {
    synthChild(this, 2, result)
    or
    not synthChild(this, 2, _) and
    toRaw(result) = toRaw(this).(Raw::ForEachStmt).getBody()
  }

  // TODO: Should this API change?
  VarAccess getVarAccess() {
    synthChild(this, 0, result)
    or
    not synthChild(this, 0, _) and
    toRaw(result) = toRaw(this).(Raw::ForEachStmt).getVarAccess()
  }

  Expr getIterableExpr() {
    synthChild(this, 1, result)
    or
    not synthChild(this, 1, _) and
    toRaw(result) = toRaw(this).(Raw::ForEachStmt).getIterableExpr()
  }

  final override Ast getChild(int i) {
    i = 0 and result = this.getVarAccess()
    or
    i = 1 and result = this.getIterableExpr()
    or
    i = 2 and result = this.getBody()
  }
}
