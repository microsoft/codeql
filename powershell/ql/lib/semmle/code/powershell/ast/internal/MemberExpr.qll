private import TAst
private import Internal
private import Raw.Raw as Raw

class MemberExpr extends Expr, TMemberExpr {
  Expr getQualifier() {
    synthChild(this, 0, result)
    or
    not synthChild(this, 0, _) and
    toRaw(result) = toRaw(this).(Raw::MemberExpr).getQualifier()
  }

  /** Gets the name of the member being looked up, if any. */
  string getMemberName() {
    result = toRaw(this).(Raw::MemberExpr).getMember().(Raw::StringConstExpr).getValue().getValue()
  }

  predicate isNullConditional() { toRaw(this).(Raw::MemberExpr).isNullConditional() }

  predicate isStatic() { toRaw(this).(Raw::MemberExpr).isStatic() }
}
