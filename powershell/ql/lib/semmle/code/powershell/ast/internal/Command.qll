private import TAst
private import Internal
private import Synthesis
private import Raw.Raw as Raw

class CmdCall extends CallExpr, TCmd {
  final override string getName() { result = toRaw(this).(Raw::Cmd).getCommandName() }

  final override Expr getArgument(int i) { synthChild(this, cmdArgument(i), result) }

  final override Expr getCallee() {
    synthChild(this, cmdCallee(), result)
    or
    not synthChild(this, cmdCallee(), _) and
    toRaw(result) = toRaw(this).(Raw::Cmd).getCallee()
  }

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

  override Redirection getRedirection(int i) {
    // TODO: Is this weird given that there's also another redirection on Expr?
    synthChild(this, cmdRedirection(i), result)
    or
    not synthChild(this, cmdRedirection(i), _) and
    toRaw(result) = toRaw(this).(Raw::Cmd).getRedirection(i)
  }

  final override Ast getChild(ChildIndex i) {
    result = super.getChild(i)
    or
    i = cmdCallee() and
    result = this.getCallee()
    or
    exists(int index |
      i = cmdArgument(index) and
      result = this.getArgument(index)
      or
      i = cmdRedirection(index) and
      result = this.getRedirection(index)
    )
  }
}
