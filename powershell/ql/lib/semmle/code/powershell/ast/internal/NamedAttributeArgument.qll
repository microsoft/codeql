private import TAst
private import Raw.Raw as Raw
private import Internal

class NamedAttributeArgument extends Ast, TNamedAttributeArgument {
  final override string toString() { result = this.getName() }

  string getName() { result = toRaw(this).(Raw::NamedAttributeArgument).getName() }

  predicate hasName(string s) { this.getName() = s }

  Expr getValue() {
    synthChild(this, namedAttributeArgVal(), result)
    or
    not synthChild(this, namedAttributeArgVal(), _) and
    toRaw(result) = toRaw(this).(Raw::NamedAttributeArgument).getValue()
  }

  final override Ast getChild(ChildIndex i) {
    i = namedAttributeArgVal() and result = this.getValue()
  }
}
