private import TAst
private import Location
private import semmle.code.powershell.controlflow.internal.Scope
private import Synthesis
private import Internal

class Ast extends TAst {
  string toString() { none() }

  final Ast getParent() { result.getChild(_) = this }

  Location getLocation() { result = toRaw(this).getLocation() } // This is an okay default, I think

  Ast getChild(ChildIndex i) { none() }

  Scope getEnclosingScope() { result = scopeOf(this) } // TODO: Scope of synth?
}
