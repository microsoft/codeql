private import TAst
private import Internal
private import Raw.Raw as Raw

class HashTableExpr extends Expr, THashTableExpr {
  final override string toString() { result = "${...}" }

  Expr getKey(int i) {
    synthChild(this, hashTableExprKey(i), result)
    or
    not synthChild(this, hashTableExprKey(i), _) and
    toRaw(result) = toRaw(this).(Raw::HashTableExpr).getKey(i)
  }

  Expr getAKey() { result = this.getKey(_) }

  Expr getValue(int i) {
    synthChild(this, hashTableExprStmt(i), result)
    or
    not synthChild(this, hashTableExprStmt(i), _) and
    toRaw(result) = toRaw(this).(Raw::HashTableExpr).getStmt(i)
  }

  Expr getAValue() { result = this.getValue(_) }

  final override Ast getChild(ChildIndex i) {
    result = super.getChild(i)
    or
    exists(int index |
      i = hashTableExprKey(index) and
      result = this.getKey(index)
      or
      i = hashTableExprStmt(index) and
      result = this.getValue(index)
    )
  }
}
