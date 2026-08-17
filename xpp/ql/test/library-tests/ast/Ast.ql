/**
 * Checks that the core X++ language constructs are extracted: the class and its methods, the
 * control-flow statements, and the database statements that have no equivalent in other
 * languages.
 */

import codeql.xpp.elements

query predicate classes(string name) { name = any(Class c).getName() }

query predicate methods(string name) { name = any(Method m).getName() }

query predicate statementCounts(string kind, int n) {
  kind = "ForStatement" and n = count(ForStatement s)
  or
  kind = "IfThenElseStatement" and n = count(IfThenElseStatement s)
  or
  kind = "WhileStatement" and n = count(WhileStatement s)
  or
  kind = "ReturnStatement" and n = count(ReturnStatement s)
  or
  kind = "SearchStatement" and n = count(SearchStatement s)
  or
  kind = "FindStatement" and n = count(FindStatement s)
  or
  kind = "TtsBeginStatement" and n = count(TtsBeginStatement s)
  or
  kind = "TtsEndStatement" and n = count(TtsEndStatement s)
  or
  kind = "TtsAbortStatement" and n = count(TtsAbortStatement s)
  or
  kind = "TryStatement" and n = count(TryStatement s)
  or
  kind = "SwitchStatement" and n = count(SwitchStatement s)
  or
  // Switch cases and catch clauses are held in CLR tuples in the compiler's AST, so these
  // confirm the extractor looks through tuple slots when walking the tree.
  kind = "SwitchStatementCaseEntry" and n = count(SwitchStatementCaseEntry e)
  or
  kind = "TryStatementCatchEntry" and n = count(TryStatementCatchEntry e)
}
