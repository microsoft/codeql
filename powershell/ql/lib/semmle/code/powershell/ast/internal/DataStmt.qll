private import TAst
private import Internal
private import Raw.Raw as Raw

class DataStmt extends Stmt, TDataStmt {
  override string toString() { result = "data {...}" }

  Expr getCmdAllowed(int i) {
    synthChild(this, dataStmtCmdAllowed(i), result)
    or
    not synthChild(this, dataStmtCmdAllowed(i), _) and
    toRaw(result) = toRaw(this).(Raw::DataStmt).getCmdAllowed(i)
  }

  Expr getACmdAllowed() { result = this.getCmdAllowed(_) }

  StmtBlock getBody() {
    synthChild(this, dataStmtBody(), result)
    or
    not synthChild(this, dataStmtBody(), _) and
    toRaw(result) = toRaw(this).(Raw::DataStmt).getBody()
  }

  final override Ast getChild(ChildIndex i) {
    i = dataStmtBody() and
    result = this.getBody()
    or
    exists(int index |
      i = dataStmtCmdAllowed(index) and
      result = this.getCmdAllowed(index)
    )
  }
}
