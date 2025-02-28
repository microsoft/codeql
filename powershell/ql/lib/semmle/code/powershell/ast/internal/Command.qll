private import TAst
private import Internal
private import Synthesis
private import Raw.Raw as Raw

class CmdCall extends CallExpr, TCmd {
  final override string getName() { result = toRaw(this).(Raw::Cmd).getCommandName() }

  final override Expr getArgument(int i) { synthChild(this, i, result) }

  private predicate isNamedArgument(int i, string name) {
    any(Synthesis s).isNamedArgument(this, i, name)
  }

  private predicate isPositionalArgument(int i) {
    exists(this.getArgument(i)) and
    not this.isNamedArgument(i, _)
  }

  /** Gets the `i`th positional argument to this command. */
  final override Expr getPositionalArgument(int i) {
    result =
      rank[i + 1](Expr e | this.isPositionalArgument(i) and e = this.getArgument(i) | e order by i)
  }

  /** Holds if this call has an argument named `name`. */
  predicate hasNamedArgument(string name) { exists(this.getNamedArgument(name)) }

  /** Gets the named argument with the given name. */
  final override Expr getNamedArgument(string name) {
    exists(int i |
      result = this.getArgument(i) and
      this.isNamedArgument(i, name)
    )
  }

  final override Ast getChild(int i) { result = this.getArgument(i) }
}
