private import TAst
private import Internal
private import Raw.Raw as Raw

class InvokeMemberExpr extends CallExpr, TInvokeMemberExpr {
  final override string getName() { result = toRaw(this).(Raw::InvokeMemberExpr).getName() }

  final override Ast getChild(ChildIndex i) {
    result = super.getChild(i)
    or
    i = invokeMemberExprQual() and
    result = this.getQualifier()
    or
    i = invokeMemberExprCallee() and
    result = this.getCallee()
    or
    exists(int index |
      i = invokeMemberExprArg(index) and
      result = this.getArgument(index)
    )
  }

  final override Expr getCallee() {
    synthChild(this, invokeMemberExprCallee(), result)
    or
    not synthChild(this, invokeMemberExprCallee(), _) and
    toRaw(result) = toRaw(this).(Raw::InvokeMemberExpr).getCallee()
  }

  final override Expr getArgument(int i) {
    synthChild(this, invokeMemberExprArg(i), result)
    or
    not synthChild(this, invokeMemberExprArg(i), _) and
    toRaw(result) = toRaw(this).(Raw::InvokeMemberExpr).getArgument(i)
  }

  final override Expr getPositionalArgument(int i) {
    // All arguments are positional in an InvokeMemberExpr
    result = this.getArgument(i)
  }

  final override Expr getNamedArgument(string name) { none() }

  final override Expr getQualifier() {
    synthChild(this, invokeMemberExprQual(), result)
    or
    not synthChild(this, invokeMemberExprQual(), _) and
    toRaw(result) = toRaw(this).(Raw::InvokeMemberExpr).getQualifier()
  }
}
