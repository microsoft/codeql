private import Raw

class PipelineChain extends @pipeline_chain, Chainable {
  final override SourceLocation getLocation() { pipeline_chain_location(this, result) }

  predicate isBackground() { pipeline_chain(this, true, _, _, _) }

  Chainable getLeft() { pipeline_chain(this, _, _, result, _) }

  Pipeline getRight() { pipeline_chain(this, _, _, _, result) }

  final override Ast getChild(int i) {
    i = 0 and result = this.getLeft()
    or
    i = 1 and result = this.getRight()
  }
}
