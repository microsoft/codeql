private import TAst
private import Location
private import semmle.code.powershell.controlflow.internal.Scope
private import Synthesis
private import Internal

class Ast extends TAst {
  string toString() { none() }

  final Ast getParent() { this = getChild(result, _) }

  Location getLocation() { result = toRaw(this).getLocation() } // This is an okay default, I think

  Ast getChild(int i) { none() }

  Scope getEnclosingScope() { result = scopeOf(this) } // TODO: Scope of synth?
}
