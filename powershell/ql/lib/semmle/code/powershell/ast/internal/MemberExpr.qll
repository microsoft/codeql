private import TAst
private import Internal
private import Raw.Raw as Raw

class MemberExpr extends Expr, TMemberExpr {
  Expr getQualifier() {
    synthChild(this, memberExprQual(), result)
    or
    not synthChild(this, memberExprQual(), _) and
    toRaw(result) = toRaw(this).(Raw::MemberExpr).getQualifier()
  }

  Expr getMemberExpr() {
    synthChild(this, memberExprMember(), result)
    or
    not synthChild(this, memberExprMember(), _) and
    toRaw(result) = toRaw(this).(Raw::MemberExpr).getMember()
  }

  final override Ast getChild(ChildIndex i) {
    result = super.getChild(i)
    or
    i = memberExprQual() and result = this.getQualifier()
    or
    i = memberExprMember() and result = this.getMemberExpr()
  }

  /** Gets the name of the member being looked up, if any. */
  string getMemberName() {
    result = toRaw(this).(Raw::MemberExpr).getMember().(Raw::StringConstExpr).getValue().getValue()
  }

  predicate isNullConditional() { toRaw(this).(Raw::MemberExpr).isNullConditional() }

  predicate isStatic() { toRaw(this).(Raw::MemberExpr).isStatic() }

  final override string toString() { result = this.getMemberName() }
}
