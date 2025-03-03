private import TAst
private import Internal
private import Raw.Raw as Raw

class ForStmt extends LoopStmt, TForStmt {
  override string toString() { result = "for(...;...;...)" }

  Ast getInitializer() {
    // TODO: I think this is always an assignment?
    synthChild(this, forStmtInit(), result)
    or
    not synthChild(this, forStmtInit(), _) and
    toRaw(result) = toRaw(this).(Raw::ForStmt).getInitializer()
  }

  Expr getCondition() {
    synthChild(this, forStmtCond(), result)
    or
    not synthChild(this, forStmtCond(), _) and
    toRaw(result) = toRaw(this).(Raw::ForStmt).getCondition()
  }

  Ast getIterator() {
    synthChild(this, forStmtIter(), result)
    or
    not synthChild(this, forStmtIter(), _) and
    toRaw(result) = toRaw(this).(Raw::ForStmt).getIterator()
  }

  final override StmtBlock getBody() {
    synthChild(this, forStmtBody(), result)
    or
    not synthChild(this, forStmtBody(), _) and
    toRaw(result) = toRaw(this).(Raw::ForStmt).getBody()
  }

  final override Ast getChild(ChildIndex i) {
    i = forStmtInit() and
    result = this.getInitializer()
    or
    i = forStmtCond() and
    result = this.getCondition()
    or
    i = forStmtIter() and
    result = this.getIterator()
    or
    i = forStmtBody() and
    result = this.getBody()
  }
}
