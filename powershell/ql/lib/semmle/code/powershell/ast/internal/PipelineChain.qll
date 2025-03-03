private import TAst
private import Internal
private import Raw.Raw as Raw

class PipelineChain extends Expr, TPipelineChain {
  predicate isBackground() { toRaw(this).(Raw::PipelineChain).isBackground() }

  Expr getLeft() {
    synthChild(this, pipelineChainLeft(), result)
    or
    not synthChild(this, pipelineChainLeft(), _) and
    toRaw(result) = toRaw(this).(Raw::PipelineChain).getLeft()
  }

  Pipeline getRight() {
    synthChild(this, pipelineChainRight(), result)
    or
    not synthChild(this, pipelineChainRight(), _) and
    toRaw(result) = toRaw(this).(Raw::PipelineChain).getRight()
  }

  final override Ast getChild(ChildIndex i) {
    result = super.getChild(i)
    or
    i = pipelineChainLeft() and result = this.getLeft()
    or
    i = pipelineChainRight() and result = this.getRight()
  }
}
