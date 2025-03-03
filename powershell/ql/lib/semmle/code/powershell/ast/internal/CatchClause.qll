private import TAst
private import Ast
private import Internal
private import Raw.Raw as Raw

class CatchClause extends Ast, TCatchClause {
  StmtBlock getBody() {
    synthChild(this, catchClauseBody(), result)
    or
    not synthChild(this, catchClauseBody(), _) and
    toRaw(result) = toRaw(this).(Raw::CatchClause).getBody()
  }

  final override Ast getChild(ChildIndex i) {
    i = catchClauseBody() and result = this.getBody()
    or
    exists(int index |
      i = catchClauseType(index) and
      result = this.getCatchType(index)
    )
  }

  override string toString() { result = "catch {...}" }

  TryStmt getTryStmt() { result.getACatchClause() = this }

  predicate isLast() {
    exists(TryStmt ts, int last |
      ts = this.getTryStmt() and
      last = max(int i | exists(ts.getCatchClause(i))) and
      this = ts.getCatchClause(last)
    )
  }

  TypeConstraint getCatchType(int i) {
    synthChild(this, catchClauseType(i), result)
    or
    not synthChild(this, catchClauseType(i), _) and
    toRaw(result) = toRaw(this).(Raw::CatchClause).getCatchType(i)
  }

  int getNumberOfCatchTypes() { result = count(this.getACatchType()) }

  TypeConstraint getACatchType() { result = this.getCatchType(_) }

  predicate isCatchAll() { not exists(this.getACatchType()) }
}

class GeneralCatchClause extends CatchClause {
  GeneralCatchClause() { this.isCatchAll() }

  override string toString() { result = "catch {...}" }
}

class SpecificCatchClause extends CatchClause {
  SpecificCatchClause() { not this.isCatchAll() }

  override string toString() { result = "catch[...] {...}" }
}
