private import TAst
private import Internal
private import Raw.Raw as Raw

class InvokeMemberExpr extends CallExpr, TInvokeMemberExpr {
  final override string getName() { result = toRaw(this).(Raw::InvokeMemberExpr).getName() }

  final override Ast getChild(int i) {
    i = -1 and
    result = this.getQualifier()
    or
    result = this.getArgument(i)
  }

  final override Expr getArgument(int i) {
    toRaw(result) = toRaw(this).(Raw::InvokeMemberExpr).getArgument(i)
  }

  final override Expr getPositionalArgument(int i) {
    toRaw(result) = toRaw(this).(Raw::InvokeMemberExpr).getArgument(i)
  }

  final override Expr getNamedArgument(string name) { none() }

  final override Expr getQualifier() {
    toRaw(result) = toRaw(this).(Raw::InvokeMemberExpr).getQualifier()
  }
}
