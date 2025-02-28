private import Raw

class IfStmt extends @if_statement, Stmt {
  override SourceLocation getLocation() { if_statement_location(this, result) }

  PipelineBase getCondition(int i) { if_statement_clause(this, i, result, _) }

  PipelineBase getACondition() { result = this.getCondition(_) }

  StmtBlock getThen(int i) { if_statement_clause(this, i, _, result) }

  int getNumberOfConditions() { result = count(this.getACondition()) }

  StmtBlock getAThen() { result = this.getThen(_) }

  /** ..., if any. */
  StmtBlock getElse() { if_statement_else(this, result) }

  predicate hasElse() { exists(this.getElse()) }

  final override Ast getChild(int i) {
    i = 0 and
    result = this.getElse()
    or
    result = this.getCondition(-(i + 1))
    or
    result = this.getThen(i + 1)
  }
}
