private import TAst
private import Internal
private import Raw.Raw as Raw

class ConstExpr extends Expr, TConstExpr {
  string getValue() { result = toRaw(this).(Raw::ConstExpr).getValue().getValue() }

  override string toString() { result = this.getValue() }
}
