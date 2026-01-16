import csharp
import experimental.code.csharp.String_Concatenation.ConcatenateString

from DataFlow::Node node
where node.asExpr().fromSource()
select node, node.asExpr().getLocation().getStartLine(),
  node.(ConcatenatedStringValue).getAConcatenatedString()
