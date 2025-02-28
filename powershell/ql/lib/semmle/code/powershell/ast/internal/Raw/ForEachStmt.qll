private import Raw

class ForEachStmt extends @foreach_statement, LoopStmt {
  override SourceLocation getLocation() { foreach_statement_location(this, result) }

  final override StmtBlock getBody() { foreach_statement(this, _, _, result, _) }

  VarAccess getVarAccess() { foreach_statement(this, result, _, _, _) }

  PipelineBase getIterableExpr() { foreach_statement(this, _, result, _, _) }

  predicate isParallel() { foreach_statement(this, _, _, _, 1) }

  final override Ast getChild(int i) {
    i = 0 and result = this.getVarAccess()
    or
    i = 1 and result = this.getIterableExpr()
    or
    i = 2 and result = this.getBody()
  }
}
