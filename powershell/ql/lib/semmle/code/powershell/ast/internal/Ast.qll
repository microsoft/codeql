private import TAst
private import Location

class Ast extends TAst {
  string toString() { result = toRaw(this).toString() } // This is an okay default, I think

  final Ast getParent() { result.getAChild() = this }

  Location getLocation() { result = toRaw(this).getLocation() } // This is an okay default, I think

  Ast getAChild() { none() }
}
