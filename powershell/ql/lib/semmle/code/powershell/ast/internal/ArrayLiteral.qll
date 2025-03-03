private import TAst
private import Raw.Raw as Raw
private import Internal

class ArrayLiteral extends Expr, TArrayLiteral {
  Expr getElement(int index) {
    exists(ChildIndex i | i = arrayLiteralElement(index) |
      synthChild(this, i, result)
      or
      not synthChild(this, i, _) and
      toRaw(result) = toRaw(this).(Raw::ArrayLiteral).getElement(index)
    )
  }

  Expr getAnElement() { result = this.getElement(_) }

  override string toString() { result = "...,..." }

  final override Ast getChild(ChildIndex i) {
    result = super.getChild(i)
    or
    exists(int index |
      i = arrayLiteralElement(index) and
      result = this.getElement(index)
    )
  }
}
