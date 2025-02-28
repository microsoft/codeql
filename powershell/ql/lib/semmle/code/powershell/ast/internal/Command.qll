private import TAst
private import CallExpr
private import Expr
private import Raw.Raw as Raw

class CmdCall extends CallExpr, TCmd {
  final override string getName() { result = toRaw(this).(Raw::Cmd).getCommandName() }

  final override Expr getArgument(int i) { toRaw(result) = toRaw(this).(Raw::Cmd).getArgument(i) }

  final override Expr getPositionalArgument(int i) {
    toRaw(result) = toRaw(this).(Raw::Cmd).getPositionalArgument(i)
  }

  final override Expr getNamedArgument(string name) {
    toRaw(result) = toRaw(this).(Raw::Cmd).getNamedArgument(name)
  }
}
