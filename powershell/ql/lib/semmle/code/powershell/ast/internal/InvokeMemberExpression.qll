private import TAst
private import semmle.code.powershell.ast.internal.CallExpr

class InvokeMemberExpr extends CallExpr, TInvokeMemberExpr { }
  