private import TAst
private import Raw.Raw as Raw
private import Internal

class ArrayLiteral extends Expr, TArrayLiteral {
  Expr getElement(int index) {
    synthChild(this, index, result)
    or
    not synthChild(this, index, _) and
    toRaw(result) = toRaw(this).(Raw::ArrayLiteral).getElement(index)
  }

  Expr getAnElement() { result = this.getElement(_) }
}
