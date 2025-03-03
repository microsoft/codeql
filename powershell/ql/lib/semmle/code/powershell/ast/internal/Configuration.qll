private import TAst
private import Internal
private import Raw.Raw as Raw

class Configuration extends Stmt, TConfiguration {
  override string toString() { result = this.getName().toString() }

  Expr getName() {
    synthChild(this, configurationName(), result)
    or
    not synthChild(this, configurationName(), _) and
    toRaw(result) = toRaw(this).(Raw::Configuration).getName()
  }

  ScriptBlockExpr getBody() {
    synthChild(this, configurationBody(), result)
    or
    not synthChild(this, configurationBody(), _) and
    toRaw(result) = toRaw(this).(Raw::Configuration).getBody()
  }

  final override Ast getChild(ChildIndex i) {
    i = configurationName() and result = this.getName()
    or
    i = configurationBody() and result = this.getBody()
  }
}
