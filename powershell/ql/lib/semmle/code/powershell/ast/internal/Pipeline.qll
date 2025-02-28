private import TAst
private import Internal
private import Raw.Raw as Raw

class Pipeline extends Expr, TPipeline {
  Expr getComponent(int i) {
    synthChild(this, i, result)
    or
    not synthChild(this, i, _) and
    toRaw(result) = toRaw(this).(Raw::Pipeline).getComponent(i)
  }

  Expr getAComponent() { result = this.getComponent(_) }

  int getNumberOfComponents() { result = toRaw(this).(Raw::Pipeline).getNumberOfComponents() }
}
