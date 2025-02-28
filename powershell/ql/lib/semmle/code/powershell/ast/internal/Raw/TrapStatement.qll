private import Raw

class TrapStmt extends @trap_statement, Stmt {
  override SourceLocation getLocation() { trap_statement_location(this, result) }
}
