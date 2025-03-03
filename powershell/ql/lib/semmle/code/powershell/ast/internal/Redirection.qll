private import TAst
private import Internal
private import Raw.Raw as Raw

class Redirection extends Ast, TRedirection {
  Expr getExpr() {
    synthChild(this, redirectionExpr(), result)
    or
    not synthChild(this, redirectionExpr(), _) and
    toRaw(result) = toRaw(this).(Raw::Redirection).getExpr()
  }

  override Ast getChild(ChildIndex i) { i = redirectionExpr() and result = this.getExpr() }
}
