/**
 * @name Non-constant format string
 * @description Passing a non-constant 'format' string to a printf-like function can lead
 *              to a mismatch between the number of arguments defined by the 'format' and the number
 *              of arguments actually passed to the function. If the format string ultimately stems
 *              from an untrusted source, this can be used for exploits.
 * @kind problem
 * @problem.severity recommendation
 * @security-severity 9.3
 * @precision high
 * @id cpp/non-constant-format
 * @tags maintainability
 *       correctness
 *       security
 *       external/cwe/cwe-134
 */

 import semmle.code.cpp.ir.dataflow.TaintTracking
 import semmle.code.cpp.security.FlowSources
 import semmle.code.cpp.models.implementations.Strcpy
 import StrConcatenation
 
 /**
  * Functions not statically observed to be called by any other function
  */
 class UncalledFunction extends Function {
   UncalledFunction() { 
     not exists(Call c | c.getTarget() = this)
    }
 }
 
 // For the following `...gettext` functions, we assume that
 // all translations preserve the type and order of `%` specifiers
 // (and hence are safe to use as format strings).  This
 // assumption is hard-coded into the query.
 predicate whitelistFunction(Function f, int arg) {
   // basic variations of gettext
   f.getName() = "_" and arg = 0
   or
   f.getName() = "gettext" and arg = 0
   or
   f.getName() = "dgettext" and arg = 1
   or
   f.getName() = "dcgettext" and arg = 1
   or
   // plural variations of gettext that take one format string for singular and another for plural form
   f.getName() = "ngettext" and
   (arg = 0 or arg = 1)
   or
   f.getName() = "dngettext" and
   (arg = 1 or arg = 2)
   or
   f.getName() = "dcngettext" and
   (arg = 1 or arg = 2)
 }
 
 
 /**
  * 1) The return of any function so long as the function does not have a definition and 
  *   is not in the white list (see `whitelistFunction`)
  * 2) A parameter to a function that is not called (see `UncalledFunction`)
  * 3) An out parameter of a function so long as the function has no definition and is not the
  *   output of a formatting function call (see `FormattingFunctionCall`) or a call to a strcpy variant
  *   (see `StrcpyFunction`). 
  *   Rationale: The output of a FormattingFunctionCall and StrcpyFunction is a step in a data flow, not a source of
  *   const or non-const data. 
  * 4) A flow source (see `FlowSources`)
  */
 predicate isNonConst(DataFlow::Node node){
    //  exists(Call fc | fc = [node.asExpr(), node.asIndirectExpr()] |
    //    not (
    //      whitelistFunction(fc.getTarget(), _) or
    //      fc.getTarget().hasDefinition()
    //    )
    //  )
    //  or
     exists(UncalledFunction f | f.getAParameter() = node.asParameter())
    //  or
    //  (
    //    node instanceof DataFlow::DefinitionByReferenceNode and
    //    not exists(FormattingFunctionCall fc | node.asDefiningArgument() = fc.getOutputArgument(_)) and
    //    not exists(Call c | c.getAnArgument() = node.asDefiningArgument() and c.getTarget().hasDefinition()) and
    //    not exists(StrcpyFunction fc, Call c |  c.(Call).getTarget() = fc | 
    //     node.asDefiningArgument() = c.getArgument(fc.getParamDest())
    //     or
    //     [node.asExpr(), node.asIndirectExpr()] = c)
    //  )
     or node instanceof FlowSource
 }
 
 
 
 /**
  * `sink` is DataFlow::Node representing format string of a `FormatingFunctionCall`
  * `formatSTring` is the Expr representing the format string of `sink`. 
  */
 predicate isSinkImpl(DataFlow::Node sink, Expr formatString) {
   [sink.asExpr(), sink.asIndirectExpr()] = formatString and
   exists(FormattingFunctionCall fc | formatString = fc.getArgument(fc.getFormatParameterIndex()))
 }
 
 
 /**
  * Flow from a non-constant source to a format string of a formatting function call.
  * 
  * Continue flow through `whitelistFunction` calls.
  */
 module NonConstFlowConfig implements DataFlow::ConfigSig {
   predicate isSource(DataFlow::Node source) {
     isNonConst(source)
   }
 
   predicate isSink(DataFlow::Node sink) { isSinkImpl(sink, _) }
 
   predicate isAdditionalFlowStep(DataFlow::Node n1, DataFlow::Node n2){
     exists(Call c, int ind |
       whitelistFunction(c.getTarget(), ind)
       and c.getArgument(ind) = [n1.asExpr(), n1.asIndirectExpr()]
       and n2.asIndirectExpr() = c
       )
   }
 }
 
 module NonConstFlow = TaintTracking::Global<NonConstFlowConfig>;

 /**
  * Flow from a non-constant source to a format string of a formatting function call.
  * Used to find non-constant format strings by finding format variables with no
  * constant source (the non-existence of any literal path to a format would indicate a 
  * potential vulnerability).
  * NOTE: this is an approximation. If one literal flows to a format sink, then it appears
  * to not be vulnerable. For example, if two paths exist to the format, one with a literal
  * and one without, this approach will result in a false negative.
  * Another potential for false negatives is string concatenation with a literal. 
  * We address these false negatives partially by combining results using the `NonConstFlow`
  * trace, and also by providing specific barriers for known concatenation with literals
  * (Special casing how flow should be traced through string concatenation using `LiteralToStrConcatFlow`).
  * 
  * Continues flow through `whitelistFunction` calls.
  */
module LiteralToFormatConfig implements DataFlow::ConfigSig{
  predicate  isSource(DataFlow::Node source) {
      source.asExpr() instanceof StringLiteral
  }

  predicate isSink(DataFlow::Node sink) {
    isSinkImpl(sink, _) 
  }

  predicate isAdditionalFlowStep(DataFlow::Node n1, DataFlow::Node n2){
    exists(Call c, int ind |
      whitelistFunction(c.getTarget(), ind)
      and c.getArgument(ind) = [n1.asExpr(), n1.asIndirectExpr()]
      and n2.asIndirectExpr() = c
      )
  }

  predicate isBarrierOut(DataFlow::Node node) {
    exists(StrConcatenation sc | sc.getAnOperand() = [node.asExpr(), node.asIndirectExpr()])
  }
}

module LiteralToFormatTrace = TaintTracking::Global<LiteralToFormatConfig>;

predicate isLiteralFormat(Expr fmt){
  exists(DataFlow::Node src, DataFlow::Node sink | 
      LiteralToFormatTrace::flow(src,sink)
      and 
      isSinkImpl(sink, fmt) 
  )
}

predicate isNonLiteralfmt(Expr fmt){
  exists(DataFlow::Node sink | isSinkImpl(sink, fmt))
  and
  not isLiteralFormat(fmt)
}


module LiteralToStrConcatConfig implements DataFlow::ConfigSig{
  predicate  isSource(DataFlow::Node source) {
      source.asExpr() instanceof Literal
  }

  predicate isSink(DataFlow::Node sink) {
    exists(StrConcatenation sc | sc.getAnOperand() = [sink.asExpr(), sink.asIndirectExpr()])
  }

  predicate isAdditionalFlowStep(DataFlow::Node n1, DataFlow::Node n2){
    exists(Call c, int ind |
      whitelistFunction(c.getTarget(), ind)
      and c.getArgument(ind) = [n1.asExpr(), n1.asIndirectExpr()]
      and n2.asIndirectExpr() = c
      )
  }
}

module LiteralToStrConcatFlow = TaintTracking::Global<LiteralToStrConcatConfig>;

predicate isLiteralStrConcatArg(StrConcatenation cat, Expr arg){
  exists(DataFlow::Node src, DataFlow::Node sink | 
      LiteralToStrConcatFlow::flow(src,sink)
      and 
      arg = [sink.asExpr(), sink.asIndirectExpr()]
      and
      cat.getAnOperand() = arg
  )
}

predicate isNonLiteralStrConcatArg(StrConcatenation cat, Expr arg){
  cat.getAnOperand() = arg
  and 
  not isLiteralStrConcatArg(cat, arg)
}


module NonConstStrCatToFormatConfig implements DataFlow::ConfigSig{
  predicate  isSource(DataFlow::Node source) {
      exists(StrConcatenation sc | 
        isNonLiteralStrConcatArg(sc, _)
        and
        sc.getResultExpr() = [source.asExpr(), source.asIndirectExpr()])
  }

  predicate isSink(DataFlow::Node sink) {
    isSinkImpl(sink, _) 
  }

  predicate isAdditionalFlowStep(DataFlow::Node n1, DataFlow::Node n2){
    exists(Call c, int ind |
      whitelistFunction(c.getTarget(), ind)
      and c.getArgument(ind) = [n1.asExpr(), n1.asIndirectExpr()]
      and n2.asIndirectExpr() = c
      )
  }
}
module NonConstStrCatToFormatFlow = TaintTracking::Global<NonConstStrCatToFormatConfig>;


from FormattingFunctionCall call, Expr formatString
where
  call.getArgument(call.getFormatParameterIndex()) = formatString and
  (
    isNonLiteralfmt(formatString)
    or
    exists(DataFlow::Node sink |
      NonConstFlow::flowTo(sink) and
      isSinkImpl(sink, formatString)
      )
    or
    exists(DataFlow::Node sink |
      NonConstStrCatToFormatFlow::flowTo(sink) and
      isSinkImpl(sink, formatString)
      )
  )

select formatString,
  "The format string argument to " + call.getTarget().getName() +
    " should be constant to prevent security issues and other potential errors."


// import NonConstFlow::PathGraph
// from NonConstFlow::PathNode source, NonConstFlow::PathNode sink
// where
//   NonConstFlow::flowPath(source, sink) and
//   exists(Expr formatString| isSinkImpl(sink.getNode(), formatString)
//   )
// select sink, source, sink, "TEST"