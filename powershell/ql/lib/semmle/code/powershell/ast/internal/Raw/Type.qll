private import Raw

class Type extends @type_definition, Stmt {
  override SourceLocation getLocation() { type_definition_location(this, result) }

  override string toString() { result = this.getName() }

  string getName() { type_definition(this, result, _, _, _, _) }

  Member getMember(int i) { type_definition_members(this, i, result) }

  Member getAMember() { result = this.getMember(_) }

  TypeConstraint getBaseType(int i) { type_definition_base_type(this, i, result) }

  TypeConstraint getABaseType() { result = this.getBaseType(_) }

  Type getASubtype() { result.getABaseType().getName() = this.getName() }

  final override Ast getChild(int i) {
    result = this.getMember(i) or
    result = this.getBaseType(-(i + 1))
  }
}
