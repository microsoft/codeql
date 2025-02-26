private import TAst
private import Ast
private import Constant

/**
 * An expression.
 *
 * This is the topmost class in the hierachy of all expression in PowerShell.
 */
class Expr extends Ast, TExpr {
  /** Gets the constant value of this expression, if this is known. */
  final ConstantValue getValue() { result.getAnExpr() = this }
}
