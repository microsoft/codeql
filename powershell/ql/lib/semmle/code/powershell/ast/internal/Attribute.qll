private import TAst
private import Internal
private import Raw.Raw as Raw

class Attribute extends Ast, TAttribute {
  string getName() { result = toRaw(this).(Raw::Attribute).getName() }

  NamedAttributeArgument getNamedArgument(int i) {
    exists(int k | k = -(i + 1) |
      synthChild(this, k, result)
      or
      not synthChild(this, k, _) and
      toRaw(result) = toRaw(this).(Raw::Attribute).getNamedArgument(i)
    )
  }

  NamedAttributeArgument getANamedArgument() { result = this.getNamedArgument(_) }

  int getNumberOfArguments() { result = count(this.getAPositionalArgument()) }

  Expr getPositionalArgument(int i) {
    exists(int k | k = i + 1 |
      synthChild(this, k, result)
      or
      not synthChild(this, k, _) and
      toRaw(result) = toRaw(this).(Raw::Attribute).getPositionalArgument(i)
    )
  }

  Expr getAPositionalArgument() { result = this.getPositionalArgument(_) }

  int getNumberOfPositionalArguments() { result = count(this.getAPositionalArgument()) }
}
