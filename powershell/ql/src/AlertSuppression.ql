/**
 * @name Alert suppression
 * @description Generates information about alert suppressions.
 * @kind alert-suppression
 * @id powershell/alert-suppression
 */

private import codeql.util.suppression.AlertSuppression as AS
private import powershell as P

class AstNode extends P::Ast {
  predicate hasLocationInfo(
    string filepath, int startline, int startcolumn, int endline, int endcolumn
  ) {
    this.getLocation().hasLocationInfo(filepath, startline, startcolumn, endline, endcolumn)
  }
}

class SingleLineComment extends P::SingleLineComment {
  private string text;

  SingleLineComment() {
    // Strip the leading '#' from single-line PowerShell comments
    text = this.getCommentContents().getValue().suffix(1)
  }

  predicate hasLocationInfo(
    string filepath, int startline, int startcolumn, int endline, int endcolumn
  ) {
    this.getLocation().hasLocationInfo(filepath, startline, startcolumn, endline, endcolumn)
  }

  string getText() { result = text }
}

import AS::Make<AstNode, SingleLineComment>
