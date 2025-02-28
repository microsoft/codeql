private import TAst
private import Ast
private import Internal
private import Raw.Raw as Raw

class CatchClause extends Ast, TCatchClause {
  StmtBlock getBody() {
    synthChild(this, -1, result)
    or
    not synthChild(this, -1, _) and
    toRaw(result) = toRaw(this).(Raw::CatchClause).getBody()
  }

  final override Ast getChild(int i) {
    i = -1 and result = this.getBody()
    or
    result = this.getCatchType(i)
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
    synthChild(this, i, result)
    or
    not synthChild(this, i, _) and
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
