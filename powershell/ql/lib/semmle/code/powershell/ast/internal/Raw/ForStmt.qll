private import Raw

class ForStmt extends @for_statement, LoopStmt {
  override SourceLocation getLocation() { for_statement_location(this, result) }

  PipelineBase getInitializer() { for_statement_initializer(this, result) }

  PipelineBase getCondition() { for_statement_condition(this, result) }

  PipelineBase getIterator() { for_statement_iterator(this, result) }

  final override StmtBlock getBody() { for_statement(this, result) }

  final override Ast getChild(int i) {
    i = 0 and
    result = this.getInitializer()
    or
    i = 1 and
    result = this.getCondition()
    or
    i = 2 and
    result = this.getIterator()
    or
    i = 3 and
    result = this.getBody()
  }
}
