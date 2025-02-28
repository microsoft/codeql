private import TAst
private import Internal
private import Raw.Raw as Raw

class StringConstExpr extends Expr, TStringConstExpr {
  string getValue() { result = toRaw(this).(Raw::StringConstExpr).getValue().getValue() }
}
