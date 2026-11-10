"""
Hand-written base of the X++ schema.

`ast.py` is generated from the X++ compiler's own AST hierarchy and layers on top of the
classes defined here. Keep this file simple: only class definitions with annotations and
`include` calls.
"""

from misc.codegen.lib.schemadefs import *

include("prefix.dbscheme")


@qltest.skip
class Element:
    is_unknown: predicate


@qltest.collapse_hierarchy
class File(Element):
    name: string


@qltest.skip
@qltest.collapse_hierarchy
class Location(Element):
    file: File
    start_line: int
    start_column: int
    end_line: int
    end_column: int


@qltest.skip
class Locatable(Element):
    location: optional[Location] | doc("location associated with this element in the code")


@qltest.skip
@qltest.collapse_hierarchy
class ErrorElement(Locatable):
    """The superclass of all elements indicating some kind of error."""

    pass


@use_for_null
class UnspecifiedElement(ErrorElement):
    """A node that could not be extracted, for example because of a syntax error."""

    parent: optional[Element]
    property: string
    index: optional[int]
    error: string


class Comment(Locatable):
    """A comment in X++ source."""

    text: optional[string]


@qltest.skip
class Ast(Locatable):
    """
    Root of the X++ abstract syntax tree.

    This mirrors `Microsoft.Dynamics.AX.Metadata.XppCompiler.Ast`, the base class of the
    X++ compiler's own AST.
    """

    pass


@qltest.skip
class XppTuple(Locatable):
    """
    Base of the classes standing in for tuples in the compiler's AST.

    The X++ compiler uses CLR tuples for a handful of grouped values, such as a `catch`
    together with its handler body. The schema has no tuple type, so the generator emits a
    named class per tuple-valued property instead.
    """

    pass
