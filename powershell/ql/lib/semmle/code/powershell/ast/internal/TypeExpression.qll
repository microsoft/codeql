private import AstImport

class TypeNameExpr extends Expr, TTypeNameExpr {
  private predicate parseName(string namespace, string typename) {
    exists(string fullName | fullName = this.getPossiblyQualifiedName() |
      if fullName.matches("%.%")
      then
        namespace =
          fullName.regexpCapture("([a-zA-Z0-9\\.]+)\\.([^\\.\\[]+)(?:\\[([^\\]]+)\\]?)", 1) and
        typename = fullName.regexpCapture("([a-zA-Z0-9\\.]+)\\.([^\\.\\[]+)(?:\\[([^\\]]+)\\]?)", 2)
      else (
        namespace = "" and
        typename = fullName
      )
    )
  }

  /** Gets the name of this type without the namespace. Note: Also strips away type parameters */
  string getName() { this.parseName(_, result) }

  /** If any */
  string getPossiblyQualifiedName() { result = getRawAst(this).(Raw::TypeNameExpr).getName() }

  // TODO: What to do when System is omitted?
  string getNamespace() { this.parseName(result, _) }

  override string toString() { result = this.getName() }

  predicate isQualified() { this.getNamespace() != "" }

  /**
   * Holds if this `TypeNameExpr` constructs a type with the name `typename`
   * from the namespace `namespace`.
   *
   * Note: Also strips away type parameters on `typename`.
   */
  predicate hasQualifiedName(string namespace, string typename) {
    this.isQualified() and
    this.parseName(namespace, typename)
  }
}

class QualifiedTypeNameExpr extends TypeNameExpr {
  QualifiedTypeNameExpr() { this.isQualified() }
}
