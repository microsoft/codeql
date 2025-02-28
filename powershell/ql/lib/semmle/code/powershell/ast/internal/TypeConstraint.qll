private import Ast
private import TAst
private import Raw.Raw as Raw

class TypeConstraint extends Ast, TTypeConstraint {
  string getName() { result = toRaw(this).(Raw::TypeConstraint).getName() }
}
