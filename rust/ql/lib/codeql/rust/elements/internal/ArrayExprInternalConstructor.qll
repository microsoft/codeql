// generated by codegen, remove this comment if you wish to edit this file
/**
 *  This module defines the hook used internally to tweak the characteristic predicate of
 *  `ArrayExprInternal` synthesized instances.
 *  INTERNAL: Do not use.
 */

private import codeql.rust.elements.internal.generated.Raw
private import codeql.rust.elements.internal.generated.PureSynthConstructors

/**
 *  The characteristic predicate of `ArrayExprInternal` synthesized instances.
 *  INTERNAL: Do not use.
 */
predicate constructArrayExprInternal(Raw::ArrayExprInternal id) {
  not constructArrayListExpr(id) and not constructArrayRepeatExpr(id)
}
