private import TAst
private import Internal
private import Raw.Raw as Raw

class PropertyMember extends Member, TPropertyMember {
  final override string getName() { result = toRaw(this).(Raw::PropertyMember).getName() }

  final override string toString() { result = this.getName() }
}
