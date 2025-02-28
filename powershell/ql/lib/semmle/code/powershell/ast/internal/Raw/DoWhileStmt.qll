private import Raw

class DoWhileStmt extends @do_while_statement, LoopStmt {
  override SourceLocation getLocation() { do_while_statement_location(this, result) }

  override string toString() { result = "DoWhile" }

  PipelineBase getCondition() { do_while_statement_condition(this, result) }

  final override StmtBlock getBody() { do_while_statement(this, result) }

  final override Ast getChild(int i) {
    i = 0 and
    result = this.getCondition()
    or
    i = 1 and
    result = this.getBody()
  }
}
