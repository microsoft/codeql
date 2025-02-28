private import Raw

class SwitchStmt extends LabeledStmt, @switch_statement {
  final override Location getLocation() { switch_statement_location(this, result) }

  PipelineBase getCondition() { switch_statement(this, result, _) }

  StmtBlock getDefault() { switch_statement_default(this, result) }

  StmtBlock getCase(int i, Expr e) { switch_statement_clauses(this, i, e, result) }

  StmtBlock getCase(int i) { result = this.getCase(i, _) }

  StmtBlock getACase() { result = this.getCase(_) }

  StmtBlock getCaseForExpr(Expr e) { result = this.getCase(_, e) }

  Expr getPattern(int i) { exists(this.getCase(i, result)) }

  Expr getAPattern() { result = this.getPattern(_) }

  int getNumberOfCases() { result = count(this.getACase()) }

  final override Ast getChild(int i) {
    i = -2 and
    result = this.getCondition()
    or
    i = -1 and
    result = this.getDefault()
    or
    result = this.getCase(i)
    or
    i >= this.getNumberOfCases() and
    result = this.getPattern(i - this.getNumberOfCases())
  }
}
