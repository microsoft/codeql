private import Raw

class DynamicStmt extends @dynamic_keyword_statement, Stmt {
  override SourceLocation getLocation() { dynamic_keyword_statement_location(this, result) }

  CmdElement getCmd(int i) { dynamic_keyword_statement_command_elements(this, i, result) }

  CmdElement getACmd() { result = this.getCmd(_) }

  final override Ast getChild(int i) { result = this.getCmd(i) }
}
