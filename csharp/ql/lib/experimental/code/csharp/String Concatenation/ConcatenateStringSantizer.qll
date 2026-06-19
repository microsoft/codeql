private import ConcatenateString

/**
 * TODO:
 * separate the unit tests from SSRF for this library
 */
private class ExtractStringExpr extends Expr {
  ExtractStringExpr() {
    this instanceof StringLiteral
    or
    this instanceof VariableAccess
    or
    this instanceof AddExprOfInterest
  }
}

private string getString(ExtractStringExpr e) {
  result = e.(StringLiteral).getValue()
  or
  result = getAddExprValue(e)
}

/**
 * A data-flow node in string construction to check for sanitization of a predecessor string.
 *
 * Extend this class and override `stringContainsSanitizer` to set string matches for all StringCreationSanitizer::Range extensions.
 *
 * Example to use as a Barrier:
 * private class PathAndQueryBarrier extends Barrier {
 *   PathAndQueryBarrier() {
 *     this.(StringCreationSanitizerSSRF).stringContainsSanitizer()
 *   }
 * }
 *
 * If you want to add new forms of string concatenation, extend `StringCreationSanitizer::Range` instead.
 */
class StringCreationSanitizer extends DataFlow::Node instanceof StringCreationSanitizer::Range {
  /** Gets the predecessor node containing sanitizer. */
  final ExtractStringExpr getAPredecessor() { result = super.getAPredecessor() }

  final string getPredecessorString() { result = super.getPredecessorString() }

  /**
   * Holds for string match patterns
   * Include super.stringContainsSanitizer() when overriding to exclude string matches inside logging methods
   *
   * Example:
   * class StringCreationSanitizerSSRF extends StringCreationSanitizer {
   *   override predicate stringContainsSanitizer() {
   *     super.stringContainsSanitizer() and // will not match patterns inside logging methods
   *     exists(string s | s = this.getPredecessorString() and s.length() > 0 |
   *     s.matches("%/%") and not s.matches("%://%"))
   *     or
   *     s.matches("%?%")
   *   }
   * }
   */
  predicate stringContainsSanitizer() { super.stringContainsSanitizer() }
}

/** Provides a class for modeling string construction. */
module StringCreationSanitizer {
  abstract class Range extends DataFlow::Node {
    ExtractStringExpr predecessor;

    /** Gets the predecessor node containing sanitizer. */
    ExtractStringExpr getAPredecessor() { result = predecessor }

    /**
     * Gets the string value for the predecessor node containing sanitizer
     * Overriding this predicate will only apply to an individual StringCreationSanitizer::Range extension.
     * Overriding this predicate is needed in cases like `ValidFormatString` where the predecessor is a substring, not an `Expr`
     */
    string getPredecessorString() {
      result = getString(predecessor)
      or
      exists(LocalVariable lv | predecessor = lv.getAnAccess() |
        result = getString(lv.getVariableDeclExpr().getInitializer())
      )
      or
      not predecessor instanceof LocalVariableAccess and
      exists(Variable v, Expr e |
        v = predecessor.(VariableAccess).getTarget() and
        (
          v.getAnAssignedValue() = e
          or
          v.getInitializer() = e
        ) and
        result = getString(e)
      )
    }

    /**
     * Holds when the node is not the child of an argument of a logging method.
     *
     * Overriding this predicate will only apply to an individual StringCreationSanitizer::Range extension.
     */
    predicate stringContainsSanitizer() { not this instanceof ExtendedLogMessageSink }
  }
}

/**
 * Holds if the node is being used in an interpolated string such that it is used after `stringContainsSanitizer`
 *
 * Example: if `stringContainsSanitizer` matches on a "/" character, but not "//":
 * `$"https://something/{node}"` will hold
 * `$"https://{node}"` will not hold
 */
private class InterpolatedStringSanitizer extends StringCreationSanitizer::Range, DataFlow::Node {
  InterpolatedStringSanitizer() {
    exists(InterpolatedStringExpr ise, Expr ei, int index, int preIndex |
      this.asExpr() = ei and
      ei = ise.getChild(index).(InterpolatedStringInsertExpr).getInsert() and
      index >= 1 and
      preIndex in [0 .. (index - 1)]
    |
      if ise.getChild(preIndex) instanceof InterpolatedStringInsertExpr
      then predecessor = ise.getChild(preIndex).(InterpolatedStringInsertExpr).getInsert()
      else predecessor = ise.getChild(preIndex)
    )
  }
}

/**
 * Holds if the node is being used in string concatenation such that such that it is used after `stringContainsSanitizer`
 *
 * Example: if `stringContainsSanitizer` matches on a "/" character, but not "//":
 * `@"https://something/" + node` will hold
 * `@"https://something/" + $"{node1}-{node2}"` will hold
 * `@"https://something/" + $"{node1}/{node2}" + node3` will hold
 * `@"https://" + node` will not hold
 */
private class StringAdditionSanitizer extends StringCreationSanitizer::Range, DataFlow::Node {
  StringAdditionSanitizer() {
    exists(AddExpr ae, Expr ei |
      this.asExpr() = ei and
      ei = ae.getRightOperand() and
      predecessor = ae.getLeftOperand().getAChildExpr*()
    )
  }
}

/**
 * Holds if the node is being used in String.Concat such that it is used after `stringContainsSanitizer`
 *
 * Example: if `stringContainsSanitizer` matches on a "/" character, but not "//": *
 * `string.Concat("https://something/", node)` will hold
 * `string.Concat("https://", node)` will not hold
 * There are other overloaded String.Concat methods not handled here
 * (see https://learn.microsoft.com/en-us/dotnet/api/system.string.concat)
 * They can be added as needed if false positives are found
 */
private class StringConcatSanitizer extends StringCreationSanitizer::Range, DataFlow::Node {
  StringConcatSanitizer() {
    exists(MethodCall c, Expr ei, int index, int preIndex |
      this.asExpr() = ei and
      c.getTarget().hasFullyQualifiedName("System.String", "Concat") and
      ei = c.getArgument(index) and
      index >= 1 and
      preIndex in [0 .. (index - 1)] and
      predecessor = c.getArgument(preIndex)
    )
  }
}

bindingset[fs]
pragma[inline_late]
private string getFormatString(ExtractStringExpr fs) {
  result = getString(fs)
  or
  exists(LocalVariable lv | fs = lv.getAnAccess() |
    result = getString(lv.getVariableDeclExpr().getInitializer())
  )
  or
  // format string argument is a VariableAccess; try to get the value
  not fs instanceof LocalVariableAccess and
  exists(Variable v, Expr e |
    v = fs.(VariableAccess).getTarget() and
    (
      v.getAnAssignedValue() = e
      or
      v.getInitializer() = e
    ) and
    result = getString(e)
  )
}

private string getFormatStringFromFormatMethod(FormatMethodCall mc) {
  exists(Expr formatStringArg | mc.getArgumentForName("format") = formatStringArg |
    formatStringArg instanceof ExtractStringExpr and
    result = getFormatString(formatStringArg)
    or
    formatStringArg instanceof ConditionalExpr and
    (
      result = getFormatString(formatStringArg.(ConditionalExpr).getThen())
      or
      result = getFormatString(formatStringArg.(ConditionalExpr).getElse())
    )
  )
}

/**
 * Holds if the node is being used in format string such that it is used after `stringContainsSanitizer`
 *
 * Example: if `stringContainsSanitizer` matches on a "/" character, but not "//":
 *  * `string.Format("https://something/{0}", node)` will hold
 * `string.Format("https://{0}", node)` will not hold
 */
private class StringFormatSanitizer extends StringCreationSanitizer::Range, DataFlow::Node {
  string stringPredecessor;

  StringFormatSanitizer() {
    exists(FormatMethodCall c, Expr ei, int index, int preIndex, string formatString |
      this.asExpr() = ei and
      formatString = getFormatStringFromFormatMethod(c) and
      ei = c.getArgument(index) and
      (
        // formatString is argument 0 of the `FormatMethod`
        // the inserts start 1
        not exists(Expr e | e = c.getArgumentForName("provider")) and
        index >= 1 and
        predecessor = c.getArgument(0) and // not actually the predecessor, however something needs to be set to prevent a cartesian product
        preIndex in [0 .. (index - 1)]
        or
        // IFormatProvider is argument 0 of the `FormatMethod`
        // formatString is argument 1; the inserts start 2
        exists(Expr e | e = c.getArgumentForName("provider")) and
        index >= 2 and
        predecessor = c.getArgument(1) and // not actually the predecessor, however something needs to be set to prevent a cartesian product
        preIndex in [0 .. (index - 2)]
      ) and
      if preIndex = 0
      then
        // Starting at char position 0 of the formatString, get the text before the first insert (`indexOf` uses a 0-based array for the nth occurrance within the string)
        // For example: `https://' from `https://{0}`
        exists(int insertPos | insertPos = formatString.indexOf("{", 0, 0) |
          stringPredecessor = formatString.substring(0, insertPos) and
          stringPredecessor.length() > 0
        )
      else
        // Starting at char position 0 of the formatString, get the text between the nth inserts.
        // For example: `/` from `https://{0}/{1}`
        exists(int predInsertEnd, int succInsertStart |
          predInsertEnd = formatString.indexOf("}", preIndex - 1, 0) and
          succInsertStart = formatString.indexOf("{", preIndex, 0) and
          stringPredecessor = formatString.substring(predInsertEnd + 1, succInsertStart) and
          stringPredecessor.length() > 0
        )
    )
  }

  /** Gets the predecessor node containing sanitizer. */
  override ExtractStringExpr getAPredecessor() { none() }

  /**
   * Gets the predecessor substring of `ValidFormatString` containing sanitizer
   */
  override string getPredecessorString() { result = stringPredecessor }
}

/**
 * Holds if the node is being used in String.Format argument such that it is used after `stringContainsSanitizer`
 *
 * Example: if `stringContainsSanitizer` matches on a "/" character, but not "//":
 *  * `string.Format("{0}{1}{2}", "https://something", "/", node)` will hold
 * `string.Format("{0}", node)` will not hold
 */
private class StringFormatArgumentSanitizer extends StringCreationSanitizer::Range, DataFlow::Node {
  StringFormatArgumentSanitizer() {
    exists(FormatMethodCall c, Expr ei, int index, int preIndex |
      this.asExpr() = ei and
      ei = c.getArgument(index) and
      (
        // formatString is argument 0 of the `FormatMethod`
        // the inserts start 1
        not exists(Expr e | e = c.getArgumentForName("provider")) and
        index >= 2 and
        preIndex in [1 .. (index - 1)] and
        predecessor = c.getArgument(preIndex)
        or
        // IFormatProvider is argument 0 of the `FormatMethod`
        // formatString is argument 1; the inserts start 2
        exists(Expr e | e = c.getArgumentForName("provider")) and
        index >= 3 and
        preIndex in [2 .. (index - 1)] and
        predecessor = c.getArgument(preIndex)
      )
    )
  }
}

/**
 * Holds if the node is being used in String.Join such that it is used after `stringContainsSanitizer`
 *
 * Example: if `stringContainsSanitizer` matches on a "/" character, but not "//":
 * `string.Join("/", new String[]{ "https://something", node })` will hold
 * `string.Join(null, new String[]{ "https://something/", node }` will hold
 * `string.Join(null, new String[]{ "https://", node })` will not hold
 */
private class StringJoinSanitizer extends StringCreationSanitizer::Range, DataFlow::Node {
  StringJoinSanitizer() {
    exists(MethodCall c, Expr ei, int index, int preIndex, ArrayInitializer arr |
      this.asExpr() = ei and
      c.getTarget().hasFullyQualifiedName("System.String", "Join") and
      (
        // Array creation occurs in the `String.Join` call
        c.getArgument(1).(ArrayCreation).getInitializer() = arr
        or
        // Array variable is used in the `String.Join` call
        exists(LocalVariable lv | c.getArgument(1) = lv.getAnAccess() |
          lv.getVariableDeclExpr().getInitializer().(ArrayCreation).getInitializer() = arr
        )
      ) and
      index >= 1 and
      (
        // separator may be null or empty; check array elements for sanitizer
        preIndex in [0 .. (index - 1)] and
        ei = arr.getElement(index) and
        predecessor = arr.getElement(preIndex)
        or
        // check separator for sanitizer
        // separator is only used if the array length is greater than 1
        arr.getNumberOfElements() = index and
        // exclude first node in array; only nodes joined after the separator may be sanitized
        preIndex in [1 .. (index - 1)] and
        ei = arr.getElement(index) and
        predecessor = c.getArgument(0)
      )
    )
  }
}

/**
 * Holds if the node is being used in StringBuilder such that it is used after `stringContainsSanitizer`
 *
 * Example: if `stringContainsSanitizer` matches on a "/" character, but not "//":
 * `StringBuilder stringBuilder = new StringBuilder("https://something/"); stringBuilder.Append(node);` will hold
 * `StringBuilder stringBuilder = new StringBuilder("https://"); stringBuilder.Append(node);` will not hold
 */
private class StringBuilderConstructorSanitizer extends StringCreationSanitizer::Range,
  DataFlow::Node
{
  StringBuilderConstructorSanitizer() {
    exists(MethodCall c, Expr ei, LocalVariable v |
      this.asExpr() = ei and
      c = getStringBuilderAppendMethodCall(ei) and
      v.getAnAccess() = c.getAChild() and
      predecessor = v.getAnAssignedValue().(Call).getArgument(0)
    )
  }
}

/**
 * Holds if the node is being used in StringBuilder such that it is used after `stringContainsSanitizer`
 *
 * Example: if `stringContainsSanitizer` matches on a "/" character, but not "//":
 * `stringBuilder.Append("https://something/").Append(node)` will hold
 * `stringBuilder.Append("https://").Append(node)` will not hold
 */
private class StringBuilderAppendChainSanitizer extends StringCreationSanitizer::Range,
  DataFlow::Node
{
  StringBuilderAppendChainSanitizer() {
    exists(MethodCall c, Expr ei |
      this.asExpr() = ei and
      c = getStringBuilderAppendMethodCall(ei) and
      predecessor = c.getAChildExpr*() and
      ei != predecessor
    )
  }
}

/**
 * Holds if the node is being used in StringBuilder such that it is used after `stringContainsSanitizer`
 *
 * Example: if `stringContainsSanitizer` matches on a "/" character, but not "//":
 * `stringBuilder.Append("https://something/"); stringBuilder.Append(node)` will hold
 * `stringBuilder.Append("https://"); stringBuilder.Append(node)` will not hold
 */
private class StringBuilderAppendSanitizer extends StringCreationSanitizer::Range, DataFlow::Node {
  StringBuilderAppendSanitizer() {
    exists(
      MethodCall callEi, MethodCall callPre, Expr ei, DataFlow::Node nodeEi, DataFlow::Node nodePre,
      LocalVariable v
    |
      this.asExpr() = ei and
      callPre = getStringBuilderAppendMethodCall(predecessor) and
      nodePre.asExpr() = callPre.getAChild() and
      nodePre.asExpr() = v.getAnAccess() and
      nodeEi.asExpr() = v.getAnAccess() and
      nodeEi.asExpr() = callEi.getAChild() and
      callEi = getStringBuilderAppendMethodCall(ei) and
      DataFlow::localFlow(nodePre, nodeEi)
    )
  }
}

/**
 * Holds if the MethodCall is for `System.Text.StringBuilder.Append`
 */
MethodCall getStringBuilderAppendMethodCall(Expr e) {
  exists(MethodCall c |
    c.getTarget().hasFullyQualifiedName("System.Text.StringBuilder", "Append") and
    e = c.getArgument(0) and
    result = c
  )
}

/**
 * A class or interface used for logging
 * Based on LoggerType in Loggers.qll
 */
class ExtendedLoggerType extends RefType {
  ExtendedLoggerType() {
    this.getABaseType*().hasName("ILogger")
    or
    this.getABaseType*().hasName("ILog")
    or
    this.getABaseType*().hasFullyQualifiedName("System.Diagnostics", "Debug")
    or
    this.getABaseType*().hasFullyQualifiedName("System.Diagnostics", "Trace")
    or
    this.getABaseType*().hasFullyQualifiedName("System.Diagnostics", "TraceSource")
    or
    this.getABaseType*().hasFullyQualifiedName("System", "Console")
    or
    this.getABaseType*().hasFullyQualifiedName("System.IO", "TextWriter")
    or
    this.getABaseType*().hasFullyQualifiedName("System.IO", "Stream")
    or
    this.getABaseType*().hasFullyQualifiedName("System.Xml.Linq", "XDocument")
    or
    exists(RefType t | t.getAMethod() instanceof LoggingMethod | this.getABaseType*() = t)
  }
}

/**
 * A method name used for loggers or streams
 */
class LoggingMethod extends Method {
  LoggingMethod() {
    this.getName() in [
        "Critical", "Debug", "DebugFormat", "Error", "ErrorFormat", "Exception", "Fatal",
        "FatalFormat", "Info", "InfoFormat", "Information", "Informational", "Log", "LogCritical",
        "LogDebug", "LogDebugMessage", "LogError", "LogErrorMessage", "LogException",
        "LogExceptionMessage", "LogInfo", "LogInfoMessage", "LogInformation", "LogTrace",
        "LogTraceMessage", "LogWarn", "LogWarning", "LogWarningMessage", "Trace", "Verbose", "Warn",
        "WarnFormat", "Warning", "Write", "WriteLine"
      ]
  }
}

/**
 * A node that is an argument (or child of an argument) for a method of class type ExtendedLoggerType
 * Based on LogMessageSink in ExternalLocationSink.qll
 * Example: `logger.LogInformation($"Message: {node1}/{node2}", logProperty);`
 */
class ExtendedLogMessageSink extends DataFlow::Node {
  ExtendedLogMessageSink() {
    this.asExpr() = any(ExtendedLoggerType i).getAMethod().getACall().getAnArgument().getAChild*()
  }
}
