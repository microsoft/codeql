// generated by codegen, do not edit
/**
 * This module provides the public class `PathExpr`.
 */

private import internal.PathExprImpl
import codeql.rust.elements.Attr
import codeql.rust.elements.PathAstNode
import codeql.rust.elements.PathExprBase

/**
 * A path expression. For example:
 * ```rust
 * let x = variable;
 * let x = foo::bar;
 * let y = <T>::foo;
 * let z = <TypeRepr as Trait>::foo;
 * ```
 */
final class PathExpr = Impl::PathExpr;
