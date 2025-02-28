private import TAst
private import Internal
private import Raw.Raw as Raw

class Type extends Stmt, TType {
  string getName() { result = toRaw(this).(Raw::Type).getName() }

  Member getMember(int i) {
    synthChild(this, i, result)
    or
    not synthChild(this, i, _) and
    toRaw(result) = toRaw(this).(Raw::Type).getMember(i)
  }

  Member getAMember() { result = this.getMember(_) }

  TypeConstraint getBaseType(int i) {
    exists(int k | k = -(i + 1) |
      synthChild(this, k, result)
      or
      not synthChild(this, k, _) and
      toRaw(result) = toRaw(this).(Raw::Type).getBaseType(i)
    )
  }

  TypeConstraint getABaseType() { result = this.getBaseType(_) }

  Type getASubtype() { result.getABaseType().getName() = this.getName() }
}
