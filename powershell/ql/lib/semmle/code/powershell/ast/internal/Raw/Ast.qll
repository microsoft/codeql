private import Raw
import Location

class Ast extends @ast {
  string toString() { none() }

  Ast getParent() { parent(this, result) }

  Location getLocation() { none() }
}
