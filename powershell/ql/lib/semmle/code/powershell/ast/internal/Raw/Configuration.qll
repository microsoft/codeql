private import Raw

class Configuration extends @configuration_definition, Stmt {
  override SourceLocation getLocation() { configuration_definition_location(this, result) }

  Expr getName() { configuration_definition(this, _, _, result) }

  ScriptBlockExpr getBody() { configuration_definition(this, result, _, _) }

  final override Ast getChild(int i) {
    i = 0 and result = this.getName()
    or
    i = 1 and result = this.getBody()
  } // TODO: Name?

  predicate isMeta() { configuration_definition(this, _, 1, _) }

  predicate isResource() { configuration_definition(this, _, 0, _) }
}
