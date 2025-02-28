private import TAst
private import Location
private import semmle.code.powershell.controlflow.internal.Scope
private import Synthesis

class Ast extends TAst {
  string toString() { result = toRaw(this).toString() } // This is an okay default, I think

  final Ast getParent() { this = getChild(result, _) }

  Location getLocation() { result = toRaw(this).getLocation() } // This is an okay default, I think

  Ast getChild(int i) { toRaw(result) = toRaw(this).getChild(i) } // This is an okay default, I think

  Scope getEnclosingScope() { result = scopeOf(this) } // TODO: Scope of synth?
}
