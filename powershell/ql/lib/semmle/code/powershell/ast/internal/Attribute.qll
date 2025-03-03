private import TAst
private import Internal
private import Raw.Raw as Raw

class Attribute extends AttributeBase, TAttribute {
  string getName() { result = toRaw(this).(Raw::Attribute).getName() }

  NamedAttributeArgument getNamedArgument(int i) {
    synthChild(this, attributeNamedArg(i), result)
    or
    not synthChild(this, attributeNamedArg(i), _) and
    toRaw(result) = toRaw(this).(Raw::Attribute).getNamedArgument(i)
  }

  NamedAttributeArgument getANamedArgument() { result = this.getNamedArgument(_) }

  int getNumberOfArguments() { result = count(this.getAPositionalArgument()) }

  Expr getPositionalArgument(int i) {
    synthChild(this, attributePosArg(i), result)
    or
    not synthChild(this, attributePosArg(i), _) and
    toRaw(result) = toRaw(this).(Raw::Attribute).getPositionalArgument(i)
  }

  Expr getAPositionalArgument() { result = this.getPositionalArgument(_) }

  int getNumberOfPositionalArguments() { result = count(this.getAPositionalArgument()) }

  override string toString() { result = this.getName() }

  final override Ast getChild(ChildIndex i) {
    exists(int index |
      i = attributeNamedArg(index) and
      result = this.getNamedArgument(index)
      or
      i = attributePosArg(index) and
      result = this.getPositionalArgument(index)
    )
  }
}
