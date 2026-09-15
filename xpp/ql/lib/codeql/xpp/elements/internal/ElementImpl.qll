/**
 * This module provides a hand-modifiable wrapper around the generated class `Element`.
 *
 * INTERNAL: Do not use.
 */

private import codeql.xpp.elements.internal.generated.Element

/**
 * INTERNAL: This module contains the customizable definition of `Element` and should not
 * be referenced directly.
 */
module Impl {
  class Element extends Generated::Element {
    /**
     * Elements print as their most specific QL class by default. Subclasses carrying a useful
     * name or value override this in their own `...Impl.qll`.
     */
    override string toStringImpl() { result = this.getAPrimaryQlClass() }
  }
}
