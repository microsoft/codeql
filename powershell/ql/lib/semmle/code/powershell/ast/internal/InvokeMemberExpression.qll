private import TAst
private import TAst
private import CallExpr
private import Expr
private import Raw.Raw as Raw

class InvokeMemberExpr extends CallExpr, TInvokeMemberExpr {
  final override string getName() { result = toRaw(this).(Raw::InvokeMemberExpr).getName() }

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
