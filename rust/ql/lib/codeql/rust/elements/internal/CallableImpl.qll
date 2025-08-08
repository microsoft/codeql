/**
 * This module provides a hand-modifiable wrapper around the generated class `Callable`.
 *
 * INTERNAL: Do not use.
 */

private import codeql.rust.elements.internal.generated.Callable

/**
 * INTERNAL: This module contains the customizable definition of `Callable` and should not
 * be referenced directly.
 */
module Impl {
  // the following QLdoc is generated: if you need to edit it, do it in the schema file
  /**
   * A callable. Either a `Function` or a `ClosureExpr`.
   */
  class Callable extends Generated::Callable {
    override Param getParam(int index) { result = this.getParamList().getParam(index) }
  }
}
