private import Ast
private import TAst
private import Synthesis
private import Expr
private import Location

class Parameter extends Ast, TParameter {
  override string toString() { result = this.getName() }

  override Location getLocation() { result = any(Synthesis s).getLocation(this) }

  string getName() { result = any(Synthesis s).toString(this) }

  override Ast getChild(int i) { i = 0 and result = this.getDefaultValue() }

  Expr getDefaultValue() { any(Synthesis s).parameterDefaultValue(this, result) }

  predicate hasDefaultValue() { exists(this.getDefaultValue()) }
}
