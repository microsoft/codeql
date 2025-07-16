import csharp

/*
 * This library builds the actual string value from the following string concatenation methods:
 *  Interpolated strings   `$"https://{host}/{path}?a=b"`
 *  string addition        `"https://" + host + "/" + path + "?a=b"`
 *  StringBuilder          `StringBuilder sb = new StringBuilder("https://host/"); sb.Append("path").Append("?a=b")`
 *  StringBuilder          `StringBuilder sb = new StringBuilder("https://host/"); sb.Append("path"); sb.Append("?a=b")`
 *  String.Concat          `string.Concat("https://", host, "/", path)`
 *  String.Concat          `string.Concat(new String[]{"https://", host, "/", path})`
 *  String.Format          `string.format("https://{0}/path", "host")`
 *  String.Join            `string.Join("/", new String[]{$"https://{host}", path})`
 *
 * TODO: String.Format for array argument
 * TODO: String() constructor
 * TODO: String.Insert, String.Remove, String.Replace, String.Split
 * TODO: StringBuilder.Insert, StringBuilder.Remove, StringBuilder.Replace
 * TODO: CastExpr for String/int/ByteType, like `(int)response.StatusCode`
 * TODO: https://learn.microsoft.com/en-us/dotnet/api/system.linq.enumerable.concat for arrays
 * TODO: nameof() -> `NameOfExpr`
 * TODO: format for log messages https://learn.microsoft.com/en-us/dotnet/api/microsoft.extensions.logging.loggerextensions
 * TODO: String.Split, if the original string is Literal and the array needs to be concatenated later
 *    example: "a;b"
 *    note: the delimiter can be an array, and all are applied to the string
 * TODO: read array element for getStringValue
 *
 * TODO Maybe a v2 version where it returns the nodes of concat Exprs?
 * Then that can be used as the source in data flows?
 * After the flow, then it can grab the relevant concatenated values, instead of all in the repo.
 * - How to restrict the low-level evaluated predicates though so it doesn't concatenate the whole repo though?
 *
 * There are private recursive helper predicates to build the full string value for each concatenation method
 *
 * There are public predicates to build the full string value
 *
 * There is a public predicate to capture the `Literal` values of Variables/Parameters/etc.,
 *    It will return `<unknown>` if the value is not available, like untrusted input.
 *
 * The Range pattern is also used. It creates an abstract base class that is extended.
 *      The base class ConcatenatedStringValue::Range has predicate `concatenatedStringMatches` to filter on a specific pattern. This will apply to all extensions.
 *      There are extensions of ConcatenatedStringValue::Range for each concatenation method. They are type DataFlow::Node and capture the full string in predicate `getAConcatenatedString`
 *
 * Note: There is an artificial restriction of 10 elements on each concatenation type, or the permutations to build the full string value from variable/property/parameter assignments can exceed the 32-bit stringpool
 *
 * Note: There is an artificial restriction of 120 characters on the string value of a single element, or building the full string value can exceed the maxium string length
 *
 * Example taint flow:
 *   override predicate isSource(DataFlow::Node source) { source.(ConcatenatedStringValue).concatenatedStringMatches("%pattern") }
 *
 * Example to get all nodes where the concatenated string matches a pattern:
 * string stringPattern(){ result = ["%pattern1","%pattern2"] }
 *
 * from DataFlow::Node node
 * where node.asExpr().fromSource()
 * and node.(ConcatenatedStringValue).concatenatedStringMatches(stringPattern())
 * select node, node.(ConcatenatedStringValue).getAConcatenatedString()
 */

/**
 * Holds for string concat method
 */
class StringConcatMethodCall extends MethodCall {
  StringConcatMethodCall() {
    this.fromSource() and
    this.getTarget().hasFullyQualifiedName("System.String", "Concat")
  }
}

/**
 * Holds for string format method
 */
class StringFormatMethodCall extends MethodCall {
  StringFormatMethodCall() {
    this.fromSource() and
    this.getTarget().hasFullyQualifiedName("System.String", "Format")
  }
}

/**
 * Holds for string join method
 */
class StringJoinMethodCall extends MethodCall {
  StringJoinMethodCall() {
    this.fromSource() and
    this.getTarget().hasFullyQualifiedName("System.String", "Join")
  }
}

/**
 * Holds for StringBuilder constructor call
 */
class StringBuilderConstructorCall extends Call {
  StringBuilderConstructorCall() {
    this.fromSource() and
    exists(Constructor c | this = c.getACall() |
      c.hasFullyQualifiedName("System.Text.StringBuilder", "StringBuilder")
    )
  }
}

/**
 * Holds for StringBuilder append method
 */
private class StringBuilderAppendMethodCall extends MethodCall {
  StringBuilderAppendMethodCall() {
    this.fromSource() and
    this.getTarget().hasFullyQualifiedName("System.Text.StringBuilder", "Append")
  }
}

/**
 * Holds for StringBuilder appendFormat method
 */
private class StringBuilderAppendFormatMethodCall extends MethodCall {
  StringBuilderAppendFormatMethodCall() {
    this.fromSource() and
    this.getTarget().hasFullyQualifiedName("System.Text.StringBuilder", "AppendFormat")
  }
}

/**
 * Holds for StringBuilder appendJoin method
 */
private class StringBuilderAppendJoinMethodCall extends MethodCall {
  StringBuilderAppendJoinMethodCall() {
    this.fromSource() and
    this.getTarget().hasFullyQualifiedName("System.Text.StringBuilder", "AppendJoin")
  }
}

/**
 * Holds for StringBuilder appendLine method
 */
private class StringBuilderAppendLineMethodCall extends MethodCall {
  StringBuilderAppendLineMethodCall() {
    this.fromSource() and
    this.getTarget().hasFullyQualifiedName("System.Text.StringBuilder", "AppendLine")
  }
}

/**
 * Holds for StringBuilder object creation
 */
class StringBuilderObjectCreation extends ObjectCreation {
  StringBuilderObjectCreation() {
    this.fromSource() and
    this.getType().hasFullyQualifiedName("System.Text", "StringBuilder")
  }
}

/**
 * Holds for ArrayCreation of type string, int, char, byte
 */
class ArrayCreationOfInterest extends ArrayCreation {
  ArrayCreationOfInterest() {
    this.fromSource() and
    exists(Type t | t = this.getArrayType().getElementType() |
      t instanceof SimpleType
      or
      t instanceof StringType
      or
      t instanceof ByteType
    )
  }
}

/**
 * Holds for AddExpr in source
 */
class AddExprOfInterest extends AddExpr {
  AddExprOfInterest() { this.fromSource() }
}

/**
 * Holds for InterpolatedStringExpr in source
 */
class IpsExprOfInterest extends InterpolatedStringExpr {
  IpsExprOfInterest() { this.fromSource() }
}

/**
 * Holds for string format methods
 */
class FormatMethodCall extends MethodCall {
  FormatMethodCall() {
    this instanceof StringFormatMethodCall
    or
    this instanceof StringBuilderAppendFormatMethodCall
  }
}

/**
 * Holds for string concatenation join methods
 */
class JoinMethodCall extends MethodCall {
  JoinMethodCall() {
    this instanceof StringJoinMethodCall
    or
    this instanceof StringBuilderAppendJoinMethodCall
  }
}

/**
 * Holds for string builder append methods
 */
class StringBuilderMethodCall extends MethodCall {
  StringBuilderMethodCall() {
    this instanceof StringBuilderAppendMethodCall
    or
    this instanceof StringBuilderAppendFormatMethodCall
    or
    this instanceof StringBuilderAppendJoinMethodCall
    or
    this instanceof StringBuilderAppendLineMethodCall
  }
}

/**
 * Get the restricted number of elements for each concatenation type
 * Otherwise, the permutations to build the full string value from variable/property/parameter assignments can exceed the 32-bit stringpool
 */
int elementRestiction() { result = 10 }

/**
 * Holds for the types of Expr that can be used to build the actual string value
 */
abstract private class ExtractExpr extends Expr { }

/**
 * Holds when the Expr is an access to a variable, parameter, or property
 */
private class AccessExpr extends ExtractExpr {
  AccessExpr() {
    this instanceof VariableAccess
    or
    this instanceof ParameterAccess
    or
    this instanceof PropertyAccess
  }
}

/**
 * Holds when the Expr is a Literal, ByteType, InterpolatedStringExpr, or AddExpr
 */
private class ValueExpr extends ExtractExpr {
  ValueExpr() {
    this instanceof CharLiteral
    or
    this instanceof IntegerLiteral
    or
    this instanceof StringLiteral
    or
    this.getType() instanceof ByteType
    or
    this instanceof IpsExprOfInterest
    or
    this instanceof AddExprOfInterest
  }
}

/**
 * Holds when the `MethodCall` is one of the string concatenation calls
 */
private class MethodCallOfInterest extends MethodCall {
  MethodCallOfInterest() {
    this instanceof StringConcatMethodCall
    or
    this instanceof StringFormatMethodCall
    or
    this instanceof StringJoinMethodCall
    or
    this instanceof StringBuilderMethodCall
  }
}

/**
 * Gets the value of a `PropertyRead` from assigned proprty values
 * 
 */
Expr getValueforPropRead(PropertyRead pr) {
  exists(VariableAccess va_pr, Variable v, ObjectCreation oc|
    va_pr = pr.getQualifier() and
    v.getInitializer() = oc and
    va_pr.getTarget() = v
    |
    result = getAValueForProp(oc, pr.getTarget().getName())
  )
}

/**
 * Gets value set on the property 'prop' either with initializer of with a property setter on the object created with ObjectCreation 'create'
 */
Expr getAValueForProp(ObjectCreation create, string prop) {
  // values set in object init
  exists(MemberInitializer init |
    init = create.getInitializer().(ObjectInitializer).getAMemberInitializer() and
    init.getLValue().(PropertyAccess).getTarget().hasName(prop) and
    result = init.getRValue()
  )
  or
  // values set on var that create is assigned to
  exists(Assignment propAssign |
    DataFlow::localFlow(DataFlow::exprNode(create),
      DataFlow::exprNode(propAssign.getLValue().(PropertyAccess).getQualifier())) and
    propAssign.getLValue().(PropertyAccess).getTarget().hasName(prop) and
    result = propAssign.getRValue()
  )
  or
  // property assignment in constructor
  exists(Assignment propAssign |
    propAssign.getEnclosingCallable() = create.getTarget() and
    propAssign.getLValue().(PropertyAccess).getTarget().hasName(prop) and
    result = propAssign.getRValue()
  )
}

/**
 * Holds for arguments or array elements of string concatenation, except for `AddExprOfInterest` and `IpsExprOfInterest` which are recursive
 */
private Expr getExprOfInterest0() {
  exists(MethodCallOfInterest mc | result = mc.getAnArgument())
  or
  exists(StringBuilderConstructorCall call | result = call.getAnArgument())
  or
  exists(ArrayCreationOfInterest arr | result = arr.getInitializer().getAnElement())
}

/**
 * Holds for arguments or array elements of string concatenation
 */
private Expr getExprOfInterest() {
  result = getExprOfInterest0()
  or
  exists(AddExprOfInterest expr | result = expr.getAnOperand())
  or
  exists(IpsExprOfInterest expr, int i | result = getIseChild(expr, i))
}

/**
 * Holds when the Expr is an initialized, default, or assigned value
 * of a variable, parameter, or property access
 */
private ValueExpr getExprFromAccess0(AccessExpr e) {
  e = getExprOfInterest() and
  (
    result = e.(VariableAccess).getTarget().getInitializer()
    or
    exists(ValueExpr ve |
      ve = e.(VariableAccess).getTarget().getAnAssignedValue() and
      getExprFromAssignedValue(e, ve) and
      result = ve
    )
    or
    result = e.(ParameterAccess).getTarget().getDefaultValue()
    or
    result = e.(PropertyRead).getTarget().getInitializer()
    or
    result = e.(PropertyRead).getTarget().getExpressionBody()
    or
    e instanceof PropertyRead and
    exists(ValueExpr ve |
      ve = getValueforPropRead(e) and
      getExprFromAssignedValue(e, ve) and
      result = ve
    )
  )
}

/**
 * Holds when the Expr is an assigned value of a variable, parameter, or property access
 */
bindingset[e, ve]
pragma[inline_late]
private predicate getExprFromAssignedValue(AccessExpr e, ValueExpr ve) {
  e = getExprOfInterest() and
  (
    ve.getEnclosingCallable() instanceof Constructor
    or
    ve.getEnclosingCallable() instanceof Getter
    or
    ve.getEnclosingCallable() instanceof Setter
  ) and
  not exists(ValueExpr ve2 | DataFlow::localFlow(DataFlow::exprNode(ve2), DataFlow::exprNode(e)))
  or
  DataFlow::localFlow(DataFlow::exprNode(ve), DataFlow::exprNode(e))
}

/**
 * Return actual string value of an `AccessExpr` (if any), otherwise return `<unknown>`
 */
private string getStringFromAccessExpr(AccessExpr e) {
  e = getExprOfInterest() and
  (
    exists(ValueExpr value | value = getExprFromAccess0(e) |
      value instanceof Literal and
      result = value.(Literal).getValue()
      or
      value.getType() instanceof ByteType and
      result = value.getValue()
      or
      // TODO need to use this for accuracy. However, the recursive calls for `getInterpolatedStringValue` and `getAddExprValue` are causing performance issues.
      // The test cases for these scenarios are also marked with TODO
      // result = getStringFromValueExpr(value)
      value instanceof InterpolatedStringExpr and
      result = "<recursion_skipped>"
      or
      value instanceof AddExpr and
      result = "<recursion_skipped>"
    )
    or
    not exists(ValueExpr value | value = getExprFromAccess0(e)) and
    result = "<unknown>"
  )
}

/**
 * Return actual string value of a `ValueExpr`
 */
private string getStringFromValueExpr(ValueExpr e) {
  e = getExprOfInterest() and
  (
    e instanceof Literal and
    result = e.(Literal).getValue()
    or
    e.getType() instanceof ByteType and
    result = e.getValue()
    or
    // InterpolatedStringExpr may be used inside other string concatenation methods
    e instanceof IpsExprOfInterest and
    result = getInterpolatedStringValue(e)
    or
    // AddExpr may be used inside other string concatenation methods
    e instanceof AddExprOfInterest and
    result = getAddExprValue(e)
  )
}

/**
 * Return actual string value of an `ExtractExpr`
 */
pragma[inline]
string getStringValue(Expr e) {
  exists(string s |
    e instanceof ValueExpr and
    s = getStringFromValueExpr(e)
    or
    e instanceof AccessExpr and
    s = getStringFromAccessExpr(e)
    or
    not e instanceof ExtractExpr and
    s = "<unknown>"
  |
    // TODO ConditionalExpr
    // restrict string length or total concatenated string can hit max string length
    // if s.length() <= 120 then result = s else result = s.substring(0, 120) + "<trimmed>"
    result = s.substring(0, s.length().minimum(128))
  )
}

/**
 * Holds for `ArrayCreation` that uses a direct or local variable argument of a method call
 *
 * Example: `new String[]{"a", "b", "c"}` from `string.Concat(new String[]{"a", "b", "c"})`
 * Example: `new String[]{"a", "b", "c"}` from `var arr = new String[]{"a", "b", "c"}; string.Concat(arr)`
 */
pragma[inline]
private ArrayCreationOfInterest getAnArrayCreationArg(MethodCallOfInterest mc) {
  result = mc.getAnArgument()
  or
  // Array variable
  exists(Variable v | mc.getAnArgument() = v.getAnAccess() |
    result = v.getInitializer()
    or
    result = v.getAnAssignedValue()
  )
}

/**
 * Concentate an array with actual string values
 *
 * Example: `abc` from `new String[]{var_a, "b", "c"}`
 */
string getConcatenatedArrayValue(ArrayCreationOfInterest arr) {
  // restrict elements or number of permutations with `getStringFromAccessExpr` can exceed 32-bit stringpool
  if arr.getInitializer().getNumberOfElements() < elementRestiction()
  then
    result =
      concat(string s, int i | s = getStringValue(arr.getInitializer().getElement(i)) | s order by i) and
    result.length() > 0
  else result = "exceeds elements limitation"
}

/**
 * Concentate an array with actual string values using a separator
 *
 * Example: `a;b;c` from `new String[]{var_a, "b", "c"}` and separator `;`
 */
pragma[inline]
string getConcatenatedArrayValueWithSeparator(ArrayCreationOfInterest arr, ExtractExpr separator) {
  // restrict elements or number of permutations with `getStringFromAccessExpr` can exceed 32-bit stringpool
  if arr.getInitializer().getNumberOfElements() < elementRestiction()
  then
    result =
      concat(string s, int i |
        s = getStringValue(arr.getInitializer().getElement(i))
      |
        s, getStringValue(separator) order by i
      ) and
    result.length() > 0
  else result = "exceeds elements limitation"
}

/**
 * Regex for a valid insert.
 *
 * Example: `{0}`
 *
 * Copied from semmle.code.csharp.frameworks.Format
 */
private string getFormatInsertRegex() { result = "\\{(\\d+)\\s*(,\\s*-?\\d+\\s*)?(:[^{}]+)?\\}" }

/**
 * Regex for a valid token in the string.
 *
 * Note that the format string can be tokenised using this regex.
 *
 * Copied from semmle.code.csharp.frameworks.Format
 */
private string getValidFormatTokenRegex() {
  result = "[^{}]|\\{\\{|\\}\\}|" + getFormatInsertRegex()
}

/**
 * Gets the token at the given position in the string.
 *
 * Example: from `{0]/{1}` it will return `{0}`, `/`, `{1}`
 *
 * Based on semmle.code.csharp.frameworks.Format.ValidFormatString
 */
bindingset[formatString]
pragma[inline_late]
private string getToken(string formatString, int outPosition) {
  result = formatString.regexpFind(getValidFormatTokenRegex(), _, outPosition)
}

/**
 * Gets the insert number at the given position in the string.
 *
 * Based on semmle.code.csharp.frameworks.Format.ValidFormatString
 */
bindingset[formatString]
pragma[inline_late]
private int getInsert(string formatString, int position) {
  result = getToken(formatString, position).regexpCapture(getFormatInsertRegex(), 1).toInt()
}

/**
 * Gets any insert number in the string.
 *
 * Based on semmle.code.csharp.frameworks.Format.ValidFormatString
 */
bindingset[formatString]
pragma[inline_late]
int getAnInsert(string formatString) { result = getInsert(formatString, _) }

/**
 * Concatenates the full format string with actual string values
 *
 * Example: `https://host/path?a=b` from `string.Format("https://{0}/{1}?a=b", "host", "path")`
 */
string getFormatStringValue(FormatMethodCall mc) {
  // restrict elements or number of permutations with `getStringFromAccessExpr` can exceed 32-bit stringpool
  // Do not count format string argument
  if mc.getNumberOfArguments() - 1 < elementRestiction()
  then
    exists(string formatString | getStringValue(mc.getArgumentForName("format")) = formatString |
      result =
        concat(string token, int tokenInt, string s |
          token = getToken(formatString, tokenInt) and
          if token.charAt(0) = "{"
          then
            if exists(Expr e | e = mc.getArgumentForName("provider"))
            then
              // If there is an IFormatProvider argument, get insert from 2 args ahead (skip IFormatProvider, formatString)
              exists(int insertInt | insertInt = getInsert(formatString, tokenInt) |
                s = getStringValue(mc.getArgument(insertInt + 2))
              )
            else
              // otherwise, get insert from 1 arg ahead (skip formatString)
              exists(int insertInt | insertInt = getInsert(formatString, tokenInt) |
                s = getStringValue(mc.getArgument(insertInt + 1))
              )
          else s = token
        |
          s order by tokenInt
        )
    )
  else result = "exceeds elements limitation"
}

private Expr getIseChild(IpsExprOfInterest ise, int i) {
  if ise.getChild(i) instanceof InterpolatedStringInsertExpr
  then result = ise.getChild(i).(InterpolatedStringInsertExpr).getInsert()
  else result = ise.getChild(i)
}

/**
 * Concatenates `InterpolatedStringExpr` with actual string value
 * Example: `abcde` from `$"a{b}c{d}e"`
 */
language[monotonicAggregates]
string getInterpolatedStringValue(IpsExprOfInterest ise) {
  if ise.getNumberOfChildren() < elementRestiction()
  then
    result =
      strictconcat(int i | exists(ise.getChild(i)) | getStringValue(getIseChild(ise, i)) order by i)
  else result = "exceeds elements limitation"
}

/**
 * Count of chained `AddExpr`
 */
private int getAddExprCount(AddExprOfInterest ae) {
  result = count(AddExprOfInterest ae2 | ae2 = ae.getLeftOperand+() | ae2)
}

/**
 * Recursively concatenates `AddExpr` children with actual string values
 * Example: `a`, `ab`, `abc` from `"a" +  "b" + "c"`
 */
private string getAnAddExprValue(AddExprOfInterest e) {
  // restrict elements or number of permutations with `getStringFromAccessExpr` can exceed 32-bit stringpool
  if getAddExprCount(e) < elementRestiction()
  then
    // Base case when there are no more AddExpr on the left
    not e.getLeftOperand() instanceof AddExprOfInterest and
    result = getStringValue(e.getLeftOperand()) + getStringValue(e.getRightOperand())
    or
    // Recursive case
    e.getLeftOperand() instanceof AddExprOfInterest and
    result = getAnAddExprValue(e.getLeftOperand()) + getStringValue(e.getRightOperand())
  else result = "exceeds elements limitation"
}

/**
 * Concatenates `AddExpr` with actual string values
 * Example: `abc` from `"a" +  "b" + "c"`
 */
string getAddExprValue(AddExprOfInterest e) {
  not exists(AddExprOfInterest parent | e = parent.getLeftOperand()) and
  result = getAnAddExprValue(e)
}

/**
 * Get StringBuilder constructor argument with actual string values
 *
 * Example: `a` from `new StringBuilder("a")`
 */
private LocalVariable getAStringBuilderLocalVariable(StringBuilderObjectCreation oc) {
  exists(Assignment a | a.getRValue() = oc |
    result = a.getLValue().(LocalVariableAccess).getTarget()
  )
}

/**
 * Get StringBuilder constructor argument with actual string values
 *
 * Example: `a` from `new StringBuilder("a")`
 */
private string getAStringBuilderConstructorValue(LocalVariable v) {
  exists(StringBuilderObjectCreation oc |
    oc.getTarget().getAParameter().hasName("value") and
    v.getAnAssignedValue() = oc
  |
    result = getStringValue(oc.getArgument(0))
  )
}

/**
 * Get StringBuilder.Append argument with actual string values
 *
 * Example: `b` from `sb.Append("b")`
 */
private string getAStringBuilderAppendValue(StringBuilderAppendMethodCall mc) {
  (
    result = getStringValue(mc.getAnArgument())
    or
    exists(ArrayCreationOfInterest arr | arr = getAnArrayCreationArg(mc) |
      // zero-index array
      result = getConcatenatedArrayValue(arr)
    )
    // or
    // TODO exists stringbuilder, recurse
  )
}

/**
 * Get StringBuilder.AppendLine argument with actual string values
 *
 * Example: `b` from `sb.AppendLine("b")`
 */
private string getAStringBuilderAppendLineValue(StringBuilderAppendLineMethodCall mc) {
  result = getStringValue(mc.getAnArgument()) + "/n"
  // or
  // TODO exists stringbuilder, recurse
}

/**
 * Get StringBuilder method argument with actual string values
 */
private string getAStringBuilderMethodValue(StringBuilderMethodCall mc) {
  result = getAStringBuilderAppendValue(mc)
  or
  result = getFormatStringValue(mc)
  or
  result = getStringJoinValue(mc)
  or
  result = getAStringBuilderAppendLineValue(mc)
}

/**
 * Count of StringBuilder qualifier chain
 */
private int getAStringBuilderQualifierCount(StringBuilderMethodCall mc) {
  result = count(StringBuilderMethodCall mc2 | mc2 = mc.getQualifier+() | mc2)
}

/**
 * Concatenate StringBuilder append chain with actual string values
 *
 * Example: `b`, `cd`, `e;f`, `ab`, `abcd`, `abcde;f`
 *  from `StringBuilder sb = new StringBuilder("a");`
 * `sb.Append("b").AppendFormat("c{0}", "d").AppendJoin(";", new String[]{"e", "f"});`
 */
private string getAStringBuilderAppendChainValue(StringBuilderMethodCall mc) {
  // restrict elements or number of permutations with `getStringFromAccessExpr` can exceed 32-bit stringpool
  if getAStringBuilderQualifierCount(mc) < elementRestiction()
  then
    // base case
    exists(LocalVariableAccess va | va = mc.getQualifier() |
      result = getAStringBuilderConstructorValue(va.getTarget()) + getAStringBuilderMethodValue(mc)
      or
      not exists(string s | s = getAStringBuilderConstructorValue(va.getTarget())) and
      result = getAStringBuilderMethodValue(mc)
    )
    or
    // recursive case
    exists(StringBuilderMethodCall qualifier | qualifier = mc.getQualifier() |
      result = getAStringBuilderAppendChainValue(qualifier) + getAStringBuilderMethodValue(mc)
    )
  else result = "exceeds elements limitation"
}

/**
 * Concatenate StringBuilder append chain with actual string values
 *
 * Example: `abcde;f`
 *  from `StringBuilder sb = new StringBuilder("a");`
 *  `sb.Append("b").AppendFormat("c{0}", "d").AppendJoin(";", new String[]{"e", "f"})`
 */
private string getStringBuilderAppendChainValue(StringBuilderObjectCreation oc) {
  exists(LocalVariableAccess va, StringBuilderMethodCall mc |
    va = getAStringBuilderLocalVariable(oc).getAnAccess() and
    va = mc.getQualifier+() and
    // filter on the last append in the chain
    not va = mc.getQualifier() and
    not exists(StringBuilderMethodCall mc2 | mc = mc2.getQualifier()) and
    result = getAStringBuilderAppendChainValue(mc)
  )
}

/**
 * Holds for `MethodCall` of discrete StringBuilder append calls
 *
 * Holds for `sb.Append("b")`, `sb.AppendFormat("c{0}", "d")`,
 *  `sb.AppendJoin(";", new String[]{"e", "f"})`
 *
 * Does not hold for `sb.Append("b").sb.Append("c")`, `sb.ToString()`
 */
private StringBuilderMethodCall getAStringBuilderMethodCall(StringBuilderObjectCreation oc) {
  exists(LocalVariable v, StringBuilderMethodCall mc |
    v = getAStringBuilderLocalVariable(oc) and
    mc.getQualifier() = v.getAnAccess() and
    // filter out append chain
    not exists(StringBuilderMethodCall mc2 | mc = mc2.getQualifier()) and
    result = mc
  )
}

/**
 * Get StringBuilder qualifiers chain count
 */
private int getAStringBuilderMethodCallCount(StringBuilderObjectCreation oc) {
  result = count(StringBuilderMethodCall mc2 | mc2 = getAStringBuilderMethodCall(oc) | mc2)
}

/**
 * Concatenate discrete StringBuilder append calls with actual string values
 *
 * Example: `abcde;f`
 *  from `StringBuilder sb = new StringBuilder("a"); sb.Append("b");`
 *  `sb.AppendFormat("c{0}", "d"); sb.AppendJoin(";", new String[]{"e", "f"})`
 */
private string getStringBuilderAppendValue(StringBuilderObjectCreation oc) {
  // restrict elements or number of permutations with `getStringFromAccessExpr` can exceed 32-bit stringpool
  if getAStringBuilderMethodCallCount(oc) < elementRestiction()
  then
    exists(LocalVariableAccess va, string appendValueString |
      va = getAStringBuilderLocalVariable(oc).getAnAccess() and
      appendValueString =
        concat(string s, StringBuilderMethodCall mc |
          mc = getAStringBuilderMethodCall(oc) and s = getAStringBuilderMethodValue(mc)
        |
          s order by mc.getLocation().getStartLine()
        )
    |
      result = getAStringBuilderConstructorValue(va.getTarget()) + appendValueString
      or
      not exists(string s | s = getAStringBuilderConstructorValue(va.getTarget())) and
      result = appendValueString
    ) and
    result.length() > 0
  else result = "exceeds elements limitation"
}

/**
 * Concatenate StringBuilder append chain with actual string values
 */
string getStringBuilderValue(StringBuilderObjectCreation oc) {
  result = getStringBuilderAppendChainValue(oc)
  or
  result = getStringBuilderAppendValue(oc)
}

/**
 * Concatenates `string.Concate` arguments with actual string values
 *
 * Example: `abc` from `string.Concat("a", "b", "c")`
 * Example: `abc` from `string.Concat(new String[]{"a", "b", "c"})`
 */
string getStringConcatValue(StringConcatMethodCall mc) {
  not exists(ArrayCreationOfInterest arr | arr = getAnArrayCreationArg(mc)) and
  if mc.getNumberOfArguments() < elementRestiction()
  then
    result = concat(string s, int i | s = getStringValue(mc.getArgument(i)) | s order by i) and
    result.length() > 0
  else result = "exceeds elements limitation"
  or
  exists(ArrayCreationOfInterest arr | arr = getAnArrayCreationArg(mc) |
    // zero-index array
    result = getConcatenatedArrayValue(arr)
  )
}

/**
 * Concatenates `string.Join` arguments with actual string values and separator
 *
 * Example: `abc` from `string.Join("", new String[]{"a" +  "b" + "c"})`
 * Example: `a-b-c` from `string.Join("-", new String[]{"a" +  "b" + "c"})`
 */
string getStringJoinValue(JoinMethodCall mc) {
  exists(ArrayCreationOfInterest arr |
    arr = getAnArrayCreationArg(mc) and
    // zero-index array
    result = getConcatenatedArrayValueWithSeparator(arr, mc.getArgument(0))
  )
}

class ConcatenatedStringValue extends DataFlow::Node instanceof ConcatenatedStringValue::Range {
  final string getAConcatenatedString() { result = super.getAConcatenatedString() }

  bindingset[pattern]
  predicate concatenatedStringMatches(string pattern) { super.concatenatedStringMatches(pattern) }
}

/** Provides a class for modeling string construction. */
module ConcatenatedStringValue {
  abstract class Range extends DataFlow::Node {
    /** Gets the concatenated string replaced with actual values from variables/etc. */
    abstract string getAConcatenatedString();

    bindingset[pattern]
    predicate concatenatedStringMatches(string pattern) {
      this.getAConcatenatedString().matches(pattern)
    }
  }
}

private class ConcatenateInterpolatedString extends ConcatenatedStringValue::Range, DataFlow::Node {
  ConcatenateInterpolatedString() {
    exists(IpsExprOfInterest ips | ips = this.asExpr() |
      not ips = getExprOfInterest0() and
      not exists(AddExprOfInterest ae | ips = ae.getAnOperand())
    )
  }

  override string getAConcatenatedString() { result = getInterpolatedStringValue(this.asExpr()) }
}

private class ConcatenateFormatString extends ConcatenatedStringValue::Range, DataFlow::Node {
  ConcatenateFormatString() { exists(StringFormatMethodCall mc | mc = this.asExpr()) }

  override string getAConcatenatedString() { result = getFormatStringValue(this.asExpr()) }
}

private class ConcatenateAddExpr extends ConcatenatedStringValue::Range, DataFlow::Node {
  ConcatenateAddExpr() {
    exists(AddExprOfInterest ae | ae = this.asExpr() |
      not ae = getExprOfInterest0() and
      not exists(IpsExprOfInterest ips | ae = ips.getAnInsert())
    )
  }

  override string getAConcatenatedString() { result = getAddExprValue(this.asExpr()) }
}

private class ConcatenateStringConcat extends ConcatenatedStringValue::Range, DataFlow::Node {
  ConcatenateStringConcat() { exists(StringConcatMethodCall mc | mc = this.asExpr()) }

  override string getAConcatenatedString() { result = getStringConcatValue(this.asExpr()) }
}

private class ConcatenateStringBuilder extends ConcatenatedStringValue::Range, DataFlow::Node {
  ConcatenateStringBuilder() { exists(StringBuilderObjectCreation oc | oc = this.asExpr()) }

  override string getAConcatenatedString() { result = getStringBuilderValue(this.asExpr()) }
}

private class ConcatenateStringJoin extends ConcatenatedStringValue::Range, DataFlow::Node {
  ConcatenateStringJoin() { exists(StringJoinMethodCall mc | mc = this.asExpr()) }

  override string getAConcatenatedString() { result = getStringJoinValue(this.asExpr()) }
}
