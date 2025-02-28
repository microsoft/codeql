private import TAst
private import Internal
private import Raw.Raw as Raw

class PipelineChain extends Expr, TPipelineChain {
  predicate isBackground() { toRaw(this).(Raw::PipelineChain).isBackground() }

  Expr getLeft() {
    synthChild(this, 0, result)
    or
    not synthChild(this, 0, _) and
    toRaw(result) = toRaw(this).(Raw::PipelineChain).getLeft()
  }

  Pipeline getRight() {
    synthChild(this, 1, result)
    or
    not synthChild(this, 1, _) and
    toRaw(result) = toRaw(this).(Raw::PipelineChain).getRight()
  }

  final override Ast getChild(int i) {
    i = 0 and result = this.getLeft()
    or
    i = 1 and result = this.getRight()
  }
}
