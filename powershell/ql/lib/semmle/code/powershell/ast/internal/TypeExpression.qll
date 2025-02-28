private import TAst
private import Internal
private import Raw.Raw as Raw

class TypeNameExpr extends Expr, TTypeNameExpr {
  string getName() { result = toRaw(this).(Raw::TypeNameExpr).getName() }
}
