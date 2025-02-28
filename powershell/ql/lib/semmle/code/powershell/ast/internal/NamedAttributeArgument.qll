private import TAst
private import Raw.Raw as Raw
private import Internal

class NamedAttributeArgument extends Ast, TNamedAttributeArgument {
  string getName() { result = toRaw(this).(Raw::NamedAttributeArgument).getName() }

  predicate hasName(string s) { this.getName() = s }

  Expr getValue() {
    synthChild(this, 0, result)
    or
    not synthChild(this, 0, _) and
    toRaw(result) = toRaw(this).(Raw::NamedAttributeArgument).getValue()
  }
}
