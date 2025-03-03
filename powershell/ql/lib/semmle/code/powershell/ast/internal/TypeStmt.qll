private import TAst
private import Internal
private import Raw.Raw as Raw

class TypeStmt extends Stmt, TTypeStmt {
  string getName() { result = toRaw(this).(Raw::TypeStmt).getName() }

  override string toString() { result = this.getName() }

  Member getMember(int i) {
    synthChild(this, typeStmtMember(i), result)
    or
    not synthChild(this, typeStmtMember(i), _) and
    toRaw(result) = toRaw(this).(Raw::TypeStmt).getMember(i)
  }

  Member getAMember() { result = this.getMember(_) }

  TypeConstraint getBaseType(int i) {
    synthChild(this, typeStmtBaseType(i), result)
    or
    not synthChild(this, typeStmtBaseType(i), _) and
    toRaw(result) = toRaw(this).(Raw::TypeStmt).getBaseType(i)
  }

  TypeConstraint getABaseType() { result = this.getBaseType(_) }

  TypeStmt getASubtype() { result.getABaseType().getName() = this.getName() }

  final override Ast getChild(ChildIndex i) {
    exists(int index |
      i = typeStmtMember(index) and
      result = this.getMember(index)
      or
      i = typeStmtBaseType(index) and
      result = this.getBaseType(index)
    )
  }
}
