private import Raw

class CatchClause extends @catch_clause, Ast {
  override SourceLocation getLocation() { catch_clause_location(this, result) }

  override string toString() { result = "catch {...}" }

  StmtBlock getBody() { catch_clause(this, result, _) }

  final override Ast getChild(int i) {
    i = -1 and result = this.getBody()
    or
    result = this.getCatchType(i)
  }

  TypeConstraint getCatchType(int i) { catch_clause_catch_type(this, i, result) }

  int getNumberOfCatchTypes() { result = count(this.getACatchType()) }

  TypeConstraint getACatchType() { result = this.getCatchType(_) }

  predicate isCatchAll() { not exists(this.getACatchType()) }
}
