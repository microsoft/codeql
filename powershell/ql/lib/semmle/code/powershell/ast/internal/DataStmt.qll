private import TAst
private import Internal
private import Raw.Raw as Raw

class DataStmt extends Stmt, TDataStmt {
  override string toString() { result = "data {...}" }

  Expr getCmdAllowed(int i) {
    synthChild(this, i, result)
    or
    not synthChild(this, i, _) and
    toRaw(result) = toRaw(this).(Raw::DataStmt).getCmdAllowed(i)
  }

  Expr getACmdAllowed() { result = this.getCmdAllowed(_) }

  StmtBlock getBody() {
    synthChild(this, -1, result)
    or
    not synthChild(this, -1, _) and
    toRaw(result) = toRaw(this).(Raw::DataStmt).getBody()
  }

  final override Ast getChild(int i) {
    i = -1 and
    result = this.getBody()
    or
    result = this.getCmdAllowed(i)
  }
}
