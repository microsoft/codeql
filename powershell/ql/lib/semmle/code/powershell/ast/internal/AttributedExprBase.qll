private import TAst
private import Internal
private import Raw.Raw as Raw

class AttributedExprBase extends Expr, TAttributedExprBase {
  Expr getExpr() { none() }

  AttributeBase getAttribute() { none() }
}
