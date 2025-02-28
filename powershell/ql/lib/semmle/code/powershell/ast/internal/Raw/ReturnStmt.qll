private import Raw

class ReturnStmt extends @return_statement, Stmt {
  override SourceLocation getLocation() { return_statement_location(this, result) }

  PipelineBase getPipeline() { return_statement_pipeline(this, result) }

  predicate hasPipeline() { exists(this.getPipeline()) }

  final override Ast getChild(int i) { i = 0 and result = this.getPipeline() }
}
