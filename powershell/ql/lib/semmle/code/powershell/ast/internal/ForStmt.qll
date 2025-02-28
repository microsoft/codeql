private import TAst
private import Internal
private import Raw.Raw as Raw

class ForStmt extends LoopStmt, TForStmt {
  Ast getInitializer() { // TODO: I think this is always an assignmnet?
    synthChild(this, 0, result)
    or
    not synthChild(this, 0, _) and
    toRaw(result) = toRaw(this).(Raw::ForStmt).getInitializer()
  }

  Expr getCondition() {
    synthChild(this, 1, result)
    or
    not synthChild(this, 1, _) and
    toRaw(result) = toRaw(this).(Raw::ForStmt).getCondition()
  }

  Ast getIterator() { // TODO: This is not always an assignment for sure
    synthChild(this, 2, result)
    or
    not synthChild(this, 2, _) and
    toRaw(result) = toRaw(this).(Raw::ForStmt).getIterator()
  }

  final override StmtBlock getBody() {
    synthChild(this, 3, result)
    or
    not synthChild(this, 3, _) and
    toRaw(result) = toRaw(this).(Raw::ForStmt).getBody()
  }
}
