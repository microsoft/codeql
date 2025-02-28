private import TAst
private import Internal
private import Raw.Raw as Raw

class HashTableExpr extends Expr, THashTableExpr {
  private int getIndex(Expr key) { this.hasEntry(result, key, _) }

  Stmt getElement(Expr key) {
    exists(int i | i = this.getIndex(key) |
      synthChild(this, i, result)
      or
      not synthChild(this, i, _) and
      toRaw(result) = toRaw(this).(Raw::HashTableExpr).getElement(toRaw(key))
    )
  }

  Stmt getElementFromConstant(string key) {
    toRaw(result) = toRaw(this).(Raw::HashTableExpr).getElementFromConstant(key)
  }

  predicate hasKey(Expr key) { exists(this.getElement(key)) }

  Stmt getAnElement() { result = this.getElement(_) }

  predicate hasEntry(int index, Expr key, Stmt value) {
    toRaw(this).(Raw::HashTableExpr).hasEntry(index, toRaw(key), toRaw(value))
  }
}
