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
    synthChild(this, pipelineComp(i), result)
    or
    not synthChild(this, pipelineComp(i), _) and
    toRaw(result) = toRaw(this).(Raw::Pipeline).getComponent(i)
  }

  final override Ast getChild(ChildIndex i) {
    result = super.getChild(i)
    or
    exists(int index |
      i = pipelineComp(index) and
      result = this.getComponent(index)
    )
  }

  Expr getAComponent() { result = this.getComponent(_) }

  int getNumberOfComponents() { result = toRaw(this).(Raw::Pipeline).getNumberOfComponents() }
}
