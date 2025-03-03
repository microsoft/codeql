private import TAst
private import Internal

/**
 * An expression.
 *
 * This is the topmost class in the hierachy of all expression in PowerShell.
 */
class Expr extends Ast, TExpr {
  /** Gets the constant value of this expression, if this is known. */
  final ConstantValue getValue() { result.getAnExpr() = this }

  Redirection getRedirection(int i) { synthChild(this, exprRedirection(i), result) }

  override Ast getChild(ChildIndex i) {
    exists(int index |
      i = exprRedirection(index) and
      result = this.getRedirection(index)
    )
  }
}
