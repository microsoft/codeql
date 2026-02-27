/**
 * @name SQL injection from user input
 * @description Building SQL queries from user-controlled sources enables SQL injection.
 * @kind problem
 * @problem.severity error
 * @security-severity 9.8
 * @id php/sql-injection
 * @tags security
 *       external/cwe/cwe-089
 */

import codeql.php.ast.internal.TreeSitter

/** An access to a PHP superglobal that contains user input. */
class UserInputAccess extends Php::SubscriptExpression {
  string superglobalName;

  UserInputAccess() {
    exists(Php::VariableName vn |
      vn = this.getChild(0) and
      superglobalName = vn.getChild().getValue() and
      superglobalName = ["_GET", "_POST", "_REQUEST", "_COOKIE"]
    )
  }

  /** Gets the name of the superglobal being accessed. */
  string getSuperglobalName() { result = superglobalName }
}

/** A call to a function known to execute SQL queries. */
class SqlFunctionCall extends Php::FunctionCallExpression {
  string funcName;

  SqlFunctionCall() {
    funcName = this.getFunction().(Php::Name).getValue() and
    funcName =
      [
        "mysql_query", "mysqli_query", "pg_query", "pg_query_params", "sqlite_query",
        "mysql_db_query", "mysql_unbuffered_query", "mssql_query"
      ]
  }

  /** Gets the name of the SQL function being called. */
  string getFunctionName() { result = funcName }
}

/** A method call known to execute SQL queries (e.g., `$pdo->query(...)`). */
class SqlMethodCall extends Php::MemberCallExpression {
  string methodName;

  SqlMethodCall() {
    methodName = this.getName().(Php::Name).getValue() and
    methodName = ["query", "exec", "prepare"]
  }

  /** Gets the name of the SQL method being called. */
  string getMethodName() { result = methodName }
}

/**
 * Holds if `varName` is directly assigned user input from a superglobal.
 * This provides simple one-level taint tracking through variable assignments.
 */
predicate taintedVar(string varName) {
  exists(Php::AssignmentExpression assign, UserInputAccess src |
    isDescendantOrSelf(src, assign.getRight()) and
    varName = assign.getLeft().(Php::VariableName).getChild().getValue()
  )
}

/** Holds if `descendant` is `ancestor` itself, or a descendant of it in the AST. */
predicate isDescendantOrSelf(Php::AstNode descendant, Php::AstNode ancestor) {
  descendant = ancestor
  or
  descendant.getParent() = ancestor
  or
  isDescendantOrSelf(descendant.getParent(), ancestor)
}

/** Holds if `node` carries tainted data from user input. */
predicate isTainted(Php::AstNode node) {
  node instanceof UserInputAccess
  or
  exists(Php::VariableName vn | vn = node |
    taintedVar(vn.getChild().getValue())
  )
}

/** Gets a description of the taint source for `node`. */
string sourceDescription(Php::AstNode node) {
  node instanceof UserInputAccess and
  result = "$" + node.(UserInputAccess).getSuperglobalName()
  or
  node instanceof Php::VariableName and
  taintedVar(node.(Php::VariableName).getChild().getValue()) and
  result = "$" + node.(Php::VariableName).getChild().getValue() + " (tainted by superglobal)"
}

from Php::AstNode taintedNode, Php::Arguments args, string sinkName, string sourceDesc
where
  sourceDesc = sourceDescription(taintedNode) and
  isTainted(taintedNode) and
  isDescendantOrSelf(taintedNode, args) and
  (
    exists(SqlFunctionCall call |
      args = call.getArguments() and
      sinkName = call.getFunctionName() + "()"
    )
    or
    exists(SqlMethodCall call |
      args = call.getArguments() and
      sinkName = "->" + call.getMethodName() + "()"
    )
  )
select taintedNode,
  "User input from " + sourceDesc + " is used in a SQL query passed to " + sinkName + "."
