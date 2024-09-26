import powershell

class MemberExpr extends @member_expression, MemberExprBase {
  final override Location getLocation() { member_expression_location(this, result) }

  Expr getBase() { member_expression(this, result, _, _, _) }

  CmdElement getMember() { member_expression(this, _, result, _, _) }

  /** Gets the name of the member being looked up, if any. */
  string getMemberName() { result = this.getMember().(StringConstExpr).getValue().getValue() }

  predicate isNullConditional() { member_expression(this, _, _, true, _) }

  predicate isStatic() { member_expression(this, _, _, _, true) }

  final override string toString() { result = this.getMember().toString() }
}

/** A `MemberExpr` that is being written to. */
class MemberExprWriteAccess extends MemberExpr {
  MemberExprWriteAccess() { this = any(AssignStmt assign).getLeftHandSide() }
}

/** A `MemberExpr` that is being read from. */
class MemberExprReadAccess extends MemberExpr {
  MemberExprReadAccess() { not this instanceof MemberExprWriteAccess }
}
