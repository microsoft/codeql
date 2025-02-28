private import TAst
private import Internal
private import Raw.Raw as Raw

class Pipeline extends Expr, TPipeline {
  override string toString() {
    if this.getNumberOfComponents() = 1
    then result = this.getComponent(0).toString()
    else result = "...|..."
  }

  Expr getComponent(int i) {
    synthChild(this, i, result)
    or
    not synthChild(this, i, _) and
    toRaw(result) = toRaw(this).(Raw::Pipeline).getComponent(i)
  }
  
  final override Ast getChild(int i) { result = this.getComponent(i) }

  Expr getAComponent() { result = this.getComponent(_) }

  int getNumberOfComponents() { result = toRaw(this).(Raw::Pipeline).getNumberOfComponents() }
}
