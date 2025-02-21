import powershell

class LoopStmt extends @loop_statement, LabeledStmt {
  /** Gets the body of this loop, if any. */
  StmtBlock getBody() { none() }
}
