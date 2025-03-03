private import TAst
private import Internal
private import Raw.Raw as Raw

class DynamicStmt extends Stmt, TDynamicStmt {
  override string toString() { result = "&..." }

  Expr getName() {
    synthChild(this, dynamicStmtName(), result)
    or
    not synthChild(this, dynamicStmtName(), _) and
    toRaw(result) = toRaw(this).(Raw::DynamicStmt).getName()
  }

  ScriptBlockExpr getScriptBlock() {
    synthChild(this, dynamicStmtBody(), result)
    or
    not synthChild(this, dynamicStmtBody(), _) and
    toRaw(result) = toRaw(this).(Raw::DynamicStmt).getScriptBlock()
  }

  HashTableExpr getHashTableExpr() {
    synthChild(this, dynamicStmtBody(), result)
    or
    not synthChild(this, dynamicStmtBody(), _) and
    toRaw(result) = toRaw(this).(Raw::DynamicStmt).getHashTableExpr()
  }

  predicate hasScriptBlock() { exists(this.getScriptBlock()) }

  predicate hasHashTableExpr() { exists(this.getHashTableExpr()) }

  final override Ast getChild(ChildIndex i) {
    i = dynamicStmtName() and result = this.getName()
    or
    i = dynamicStmtBody() and
    (result = this.getScriptBlock() or result = this.getHashTableExpr())
  }
}
