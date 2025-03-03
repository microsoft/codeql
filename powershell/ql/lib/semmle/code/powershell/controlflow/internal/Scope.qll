private import powershell
private import semmle.code.powershell.ast.internal.Raw.Scope as Raw

class Scope instanceof Raw::Scope {
  string toString() { result = super.toString() }
}

Scope scopeOf(Ast a) {
  none() // TODO
}
