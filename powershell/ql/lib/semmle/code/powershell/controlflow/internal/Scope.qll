private import powershell
private import ControlFlowGraphImpl

/** Gets the enclosing scope of `n`. */
Scope scopeOf(Ast n) {
  exists(Ast m | m = n.getParent() |
    m = result
    or
    not m instanceof Scope and result = scopeOf(m)
  )
}

private predicate foo(StmtBlock n, int k, Ast m) {
  n.getLocation().getStartLine() = 0 and
  n.getLocation().getFile().getBaseName() = "test.ps1" and
  strictcount(n.getParent()) = k and
  k > 1 and
  m = n.getParent()
}

/**
 * A variable scope. This is either a top-level (file), a module, a class,
 * or a callable.
 */
class Scope extends Ast, ScriptBlock {
  /** Gets the outer scope, if any. */
  Scope getOuterScope() { result = scopeOf(this) }
}
