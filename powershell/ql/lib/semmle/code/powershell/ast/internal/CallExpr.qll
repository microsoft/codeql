private import TAst
private import semmle.code.powershell.ast.internal.Expr

class CallExpr extends Expr, TCallExpr {
  /** Gets the i'th argument to this call. */
  Expr getArgument(int i) { none() }

  /** Gets the name that is used to select the callee. */
  string getName() { none() }

  /** Gets the i'th positional argument to this call. */
  Expr getPositionalArgument(int i) { none() }

  /** Holds if an argument with name `name` is provided to this call. */
  final predicate hasNamedArgument(string name) { exists(this.getNamedArgument(name)) }

  /** Gets the argument to this call with the name `name`. */
  Expr getNamedArgument(string name) { none() }

  /** Gets any argument to this call. */
  final Expr getAnArgument() { result = this.getArgument(_) }

  /** Gets the qualifier of this call, if any. */
  Expr getQualifier() { none() }
}
