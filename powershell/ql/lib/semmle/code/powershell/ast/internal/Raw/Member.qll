private import Raw

class Member extends @member, Ast {
  TypeStmt getDeclaringType() { result.getAMember() = this }

  string getName() { none() }

  predicate isHidden() { none() }

  predicate isPrivate() { none() }

  predicate isPublic() { none() }

  predicate isStatic() { none() }
}

/**
 * A method definition. That is, a function defined inside a class definition.
 */
class Method extends Member {
  Method() { function_member(this, _, _, _, _, _, _, _, _) }

  ScriptBlock getBody() { function_member(this, result, _, _, _, _, _, _, _) }

  final override predicate isStatic() { function_member(this, _, _, _, _, _, true, _, _) }

  final override string getName() { function_member(this, _, _, _, _, _, _, result, _) }

  predicate isConstructor() { function_member(this, _, true, _, _, _, _, _, _) }

  override Location getLocation() { function_member_location(this, result) }
}
