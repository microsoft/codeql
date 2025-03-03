private import Ast
private import TAst
private import Synthesis
private import Internal

class Parameter extends Ast, TParameter {
  override string toString() { result = this.getName() }

  override Location getLocation() { result = any(Synthesis s).getLocation(this) }

  string getName() { any(Synthesis s).parameterName(this, result) }

  override Ast getChild(ChildIndex i) {
    i = paramDefaultVal() and result = this.getDefaultValue()
    or
    exists(int index |
      i = paramAttr(index) and
      result = this.getAttribute(index)
    )
  }

  Expr getDefaultValue() { synthChild(this, paramDefaultVal(), result) }

  AttributeBase getAttribute(int i) { synthChild(this, paramAttr(i), result) }

  predicate hasDefaultValue() { exists(this.getDefaultValue()) }
}
