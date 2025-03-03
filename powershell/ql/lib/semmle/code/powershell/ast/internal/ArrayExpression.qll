private import TAst
private import Internal
private import Raw.Raw as Raw

class ArrayExpr extends Expr, TArrayExpr {
  StmtBlock getStmtBlock() {
    synthChild(this, arrayExprStmtBlock(), result)
    or
    not synthChild(this, arrayExprStmtBlock(), result) and
    toRaw(result) = toRaw(this).(Raw::ArrayExpr).getStmtBlock()
  }

  override string toString() { result = "@(...)" }

  final override Ast getChild(ChildIndex i) {
    result = super.getChild(i)
    or
    i = arrayExprStmtBlock() and result = this.getStmtBlock()
  }
  // /**
  //  * Gets the i'th element of this `ArrayExpr`, if this can be determined statically.
  //  *
  //  * See `getStmtBlock` when the array elements are not known statically.
  //  */
  // Expr getElement(int i) {
  //   result =
  //     unique( | | this.getStmtBlock().getAStmt()).(CmdExpr).getExpr().(ArrayLiteral).getElement(i)
  // }
  // /**
  //  * Gets an element of this `ArrayExpr`, if this can be determined statically.
  //  *
  //  * See `getStmtBlock` when the array elements are not known statically.
  //  */
  // Expr getAnElement() { result = this.getElement(_) }
}
