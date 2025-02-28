private import Ast
private import TAst
private import Synthesis
private import Internal

class Parameter extends Ast, TParameter {
  override string toString() { result = this.getName() }

  override Location getLocation() { result = any(Synthesis s).getLocation(this) }

  string getName() { any(Synthesis s).parameterName(this, result) }

  override Ast getChild(int i) {
    i = -1 and result = this.getDefaultValue()
    or
    result = this.getAttribute(i)
  }

  Expr getDefaultValue() { synthChild(this, -1, result) }

  AttributeBase getAttribute(int i) { synthChild(this, i, result) }

  predicate hasDefaultValue() { exists(this.getDefaultValue()) }
}
