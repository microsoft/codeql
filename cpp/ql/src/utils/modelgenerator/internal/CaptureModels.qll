/**
 * Provides predicates related to capturing summary models of the Standard or a 3rd party library.
 */

private import cpp as Cpp
private import semmle.code.cpp.dataflow.new.DataFlow
private import semmle.code.cpp.ir.IR as IR
private import semmle.code.cpp.dataflow.ExternalFlow as ExternalFlow
private import semmle.code.cpp.ir.dataflow.internal.DataFlowDispatch
private import semmle.code.cpp.ir.dataflow.internal.DataFlowImplCommon as DataFlowImplCommon
private import semmle.code.cpp.ir.dataflow.internal.DataFlowImplSpecific
private import semmle.code.cpp.ir.dataflow.internal.DataFlowPrivate as DataFlowPrivate
private import semmle.code.cpp.ir.dataflow.internal.DataFlowUtil as DataFlowUtil
private import semmle.code.cpp.dataflow.internal.FlowSummaryImpl as FlowSummaryImpl
private import semmle.code.cpp.ir.dataflow.internal.TaintTrackingImplSpecific
private import semmle.code.cpp.ir.dataflow.internal.SsaInternals as SsaInternals
private import semmle.code.cpp.dataflow.new.TaintTracking
private import codeql.mad.modelgenerator.internal.ModelGeneratorImpl

module ModelGeneratorInput implements ModelGeneratorInputSig<Location, CppDataFlow> {
  class Type = DataFlowPrivate::DataFlowType;

  class Parameter extends DataFlow::ParameterNode {
    Parameter() {
      not this.isSourceParameterOf(_,
        any(DataFlowPrivate::Position pos | pos.getArgumentIndex() = -1))
    }
  }

  class Callable = Cpp::Declaration;

  class NodeExtended extends DataFlow::Node {
    Callable getAsExprEnclosingCallable() { result = this.asExpr().getEnclosingDeclaration() }
  }

  Parameter asParameter(NodeExtended n) { result = n }

  Callable getEnclosingCallable(NodeExtended n) {
    result = n.getEnclosingCallable().asSourceCallable()
  }

  private predicate hasManualSummaryModel(Callable api) {
    api = any(FlowSummaryImpl::Public::SummarizedCallable sc | sc.applyManualModel()) or
    api = any(FlowSummaryImpl::Public::NeutralSummaryCallable sc | sc.hasManualModel())
  }

  private predicate hasManualSourceModel(Callable api) {
    api = any(FlowSummaryImpl::Public::NeutralSourceCallable sc | sc.hasManualModel())
  }

  private predicate hasManualSinkModel(Callable api) {
    api = any(FlowSummaryImpl::Public::NeutralSinkCallable sc | sc.hasManualModel())
  }

  private predicate relevant(Callable api) { api.fromSource() } // TODO

  class SummaryTargetApi extends Callable {
    private Callable lift;

    SummaryTargetApi() {
      lift = this and
      not hasManualSummaryModel(lift)
    }

    Callable lift() { result = lift }

    predicate isRelevant() {
      relevant(this) and
      not hasManualSummaryModel(this)
    }
  }

  class SourceOrSinkTargetApi extends Callable {
    SourceOrSinkTargetApi() { relevant(this) }
  }

  class SinkTargetApi extends SourceOrSinkTargetApi {
    SinkTargetApi() { not hasManualSinkModel(this) }
  }

  class SourceTargetApi extends SourceOrSinkTargetApi {
    SourceTargetApi() { not hasManualSourceModel(this) }
  }

  class InstanceParameterNode extends DataFlow::ParameterNode {
    InstanceParameterNode() {
      // TODO: Indirection?
      DataFlowPrivate::nodeHasOperand(this, any(IR::ThisArgumentOperand arg), _)
    }
  }

  private string isExtensible(Callable c) {
    if c instanceof MemberFunction then result = "true" else result = "false"
  }

  private string templateParams(Declaration template) {
    exists(string params |
      params =
        concat(int i |
          |
          template.getTemplateArgument(i).(TypeTemplateParameter).getName(), "," order by i
        )
    |
      if params = "" then result = "" else result = "<" + params + ">"
    )
  }

  private string params(Function functionTemplate) {
    exists(string params |
      params =
        concat(int i |
          |
          ExternalFlow::getParameterTypeWithoutTemplateArguments(functionTemplate, i, true), ","
          order by
            i
        )
    |
      if params = "" then result = "" else result = "(" + params + ")"
    )
  }

  /**
   * Holds if the callable `c` is in namespace `namespace`
   * and is a member of `type`.
   */
  private predicate qualifiedName(
    Callable callable, string namespace, string type, string name, string params
  ) {
    exists(
      Function functionTemplate, string typeWithoutTemplateArgs, string nameWithoutTemplateArgs
    |
      functionTemplate = ExternalFlow::getFullyTemplatedFunction(callable) and
      functionTemplate.hasQualifiedName(namespace, typeWithoutTemplateArgs, nameWithoutTemplateArgs) and
      nameWithoutTemplateArgs = functionTemplate.getName() and
      name = nameWithoutTemplateArgs + templateParams(functionTemplate) and
      params = params(functionTemplate)
    |
      exists(Class classTemplate |
        classTemplate = functionTemplate.getDeclaringType() and
        type = typeWithoutTemplateArgs + templateParams(classTemplate)
      )
      or
      not exists(functionTemplate.getDeclaringType()) and
      type = ""
    )
  }

  predicate isRelevantType(Type t) { any() }

  Type getUnderlyingContentType(DataFlow::ContentSet c) {
    result = c.(DataFlow::FieldContent).getField().getUnspecifiedType() or
    result = c.(DataFlow::UnionContent).getUnion().getUnspecifiedType()
  }

  string qualifierString() { result = "Argument[-1]" }

  bindingset[n]
  private string indirections(int n) { result = concat(int i | i = [1 .. n] | "*") }

  private Type getUniqueParameterType(Function f) {
    result = unique( | | f.getAParameter()).getUnspecifiedType()
  }

  private string begin() { result = ["cbegin", "begin"] }

  private int iteratorValueType(Type t) {
    exists(Class c, TypedefType typedef, SsaInternals::CppType cppType | c = t.stripType() |
      typedef = c.getAMember() and
      typedef.getName() = "value_type" and
      cppType.hasType(typedef.getUnspecifiedType(), false) and
      result = SsaInternals::countIndirectionsForCppType(cppType)
    )
  }

  private predicate shouldBeModelledWithElementContent(Type t, int indirectionIndex) {
    exists(Class c, Function f |
      c = t.stripType() and
      f = c.getAMemberFunction()
    |
      // begin as a member
      f.hasName(begin()) and
      indirectionIndex = iteratorValueType(f.getUnspecifiedType())
      or
      // operator[] as a member (it cannot be defined as non-member)
      f.hasName("operator[]") and
      indirectionIndex =
        SsaInternals::countIndirectionsForCppType(any(SsaInternals::CppType cppType |
            cppType.hasType(f.getUnspecifiedType(), false)
          ))
    )
    or
    // begin as a non-member
    exists(Function f |
      indirectionIndex = iteratorValueType(f.getUnspecifiedType()) and
      getUniqueParameterType(f).stripType() = t and
      f.hasName(begin())
    )
  }

  private predicate parameterContentAccessImpl(Parameter p, string argument, Type t) {
    exists(int indirectionIndex, int argumentIndex, DataFlowPrivate::Position pos |
      p.isSourceParameterOf(_, pos) and
      pos.getArgumentIndex() = argumentIndex and
      pos.getIndirectionIndex() = indirectionIndex and
      t = p.getType() and
      argument = "Argument[" + indirections(indirectionIndex) + argumentIndex + "]"
    )
  }

  string parameterAccess(Parameter p) {
    // TODO: Handle void pointers
    exists(Type t, string argument | parameterContentAccessImpl(p, argument, t) |
      exists(int elementIndirectionIndex, string element |
        shouldBeModelledWithElementContent(t, elementIndirectionIndex) and
        element = argument + ".Element"
      |
        if elementIndirectionIndex > 0
        then result = element + "[" + indirections(elementIndirectionIndex) + "]"
        else result = element
      )
      or
      not shouldBeModelledWithElementContent(t, _) and
      result = argument
    )
  }

  string parameterContentAccess(Parameter p) { parameterContentAccessImpl(p, result, _) }

  bindingset[c]
  string paramReturnNodeAsOutput(Callable c, DataFlowPrivate::Position pos) {
    exists(Parameter p |
      p.isSourceParameterOf(c, pos) and
      result = parameterAccess(p)
    )
    or
    result = qualifierString() and pos.(DataFlowPrivate::DirectPosition).getArgumentIndex() = -1
  }

  bindingset[c]
  string paramReturnNodeAsContentOutput(Callable c, DataFlowPrivate::ParameterPosition pos) {
    exists(Parameter p |
      p.isSourceParameterOf(c, pos) and
      result = parameterContentAccess(p)
    )
    or
    result = qualifierString() and pos.(DataFlowPrivate::DirectPosition).getArgumentIndex() = -1
  }

  pragma[nomagic]
  Callable returnNodeEnclosingCallable(DataFlow::Node ret) {
    result = DataFlowImplCommon::getNodeEnclosingCallable(ret).asSourceCallable()
  }

  /** Holds if this instance access is to an enclosing instance of type `t`. */
  pragma[nomagic]
  private predicate isEnclosingInstanceAccess(DataFlowPrivate::ReturnNode n, Class t) {
    n.getKind().isIndirectReturn(-1) and
    t = n.getType().stripType() and
    t != n.getEnclosingCallable().asSourceCallable().(Cpp::Function).getDeclaringType()
  }

  pragma[nomagic]
  predicate isOwnInstanceAccessNode(DataFlowPrivate::ReturnNode node) {
    node.getKind().isIndirectReturn(-1) and
    not isEnclosingInstanceAccess(node, _)
  }

  predicate sinkModelSanitizer(DataFlow::Node node) { none() }

  predicate apiSource(DataFlow::Node source) {
    DataFlowPrivate::nodeHasOperand(source, any(DataFlow::FieldAddress fa), _)
    or
    source instanceof DataFlow::ParameterNode
  }

  string getInputArgument(DataFlow::Node source) {
    exists(DataFlowPrivate::Position pos, int argumentIndex, int indirectionIndex |
      source.(DataFlow::ParameterNode).isParameterOf(_, pos) and
      argumentIndex = pos.getArgumentIndex() and
      indirectionIndex = pos.getIndirectionIndex() and
      result = "Argument[" + indirections(indirectionIndex) + argumentIndex + "]"
    )
    or
    // TODO: Can it ever be anything other than 1?
    DataFlowPrivate::nodeHasOperand(source, any(DataFlow::FieldAddress fa), 1) and
    result = qualifierString()
  }

  predicate irrelevantSourceSinkApi(Callable source, SourceTargetApi api) { none() }

  bindingset[kind]
  predicate isRelevantSourceKind(string kind) { any() }

  bindingset[kind]
  predicate isRelevantSinkKind(string kind) { any() }

  predicate containerContent(DataFlow::ContentSet cs) { cs instanceof DataFlow::ElementContent }

  predicate isAdditionalContentFlowStep(DataFlow::Node node1, DataFlow::Node node2) {
    TaintTracking::defaultAdditionalTaintStep(node1, node2, _) and
    not exists(DataFlow::Content f |
      DataFlowPrivate::readStep(node1, f, node2) and containerContent(f)
    )
  }

  predicate isField(DataFlow::ContentSet c) {
    c instanceof DataFlowUtil::FieldContent or
    c instanceof DataFlowUtil::UnionContent
  }

  predicate isCallback(DataFlow::ContentSet c) { none() }

  string getSyntheticName(DataFlow::ContentSet c) {
    // TODO: Do we need this?
    exists(Field f |
      not f.isPublic() and
      f = c.(DataFlowUtil::FieldContent).getField() and
      result = f.getQualifiedName()
    )
  }

  string printContent(DataFlow::ContentSet c) {
    exists(int indirectionIndex, string name, string kind |
      exists(DataFlowUtil::UnionContent uc |
        c.isSingleton(uc) and
        name = uc.getUnion().getName() and
        indirectionIndex = uc.getIndirectionIndex() and
        kind = "Union["
      )
      or
      exists(DataFlowUtil::FieldContent fc |
        c.isSingleton(fc) and
        name = fc.getField().getName() and
        indirectionIndex = fc.getIndirectionIndex() and
        kind = "Field["
      )
    |
      result = kind + indirections(indirectionIndex) + name + "]"
    )
    or
    exists(DataFlowUtil::ElementContent ec |
      c.isSingleton(ec) and
      result = "Element[" + ec.getIndirectionIndex() + "]"
    )
  }

  predicate isUninterestingForDataFlowModels(Callable api) {
    // Note: This also makes all global/static-local variables uninteresting
    not api.(Cpp::Function).hasDefinition()
  }

  predicate isUninterestingForHeuristicDataFlowModels(Callable api) { none() }

  string partialModelRow(Callable api, int i) {
    i = 0 and qualifiedName(api, result, _, _, _) // namespace
    or
    i = 1 and qualifiedName(api, _, result, _, _) // type
    or
    i = 2 and result = isExtensible(api) // extensible
    or
    i = 3 and qualifiedName(api, _, _, result, _) // name
    or
    i = 4 and qualifiedName(api, _, _, _, result) // parameters
    or
    i = 5 and result = "" and exists(api) // ext
  }

  string partialNeutralModelRow(Callable api, int i) {
    i = 0 and qualifiedName(api, result, _, _, _) // namespace
    or
    i = 1 and qualifiedName(api, _, result, _, _) // type
    or
    i = 2 and qualifiedName(api, _, _, result, _) // name
    or
    i = 3 and qualifiedName(api, _, _, _, result) // parameters
  }

  predicate sourceNode = ExternalFlow::sourceNode/2;

  predicate sinkNode = ExternalFlow::sinkNode/2;
}

import MakeModelGenerator<Location, CppDataFlow, CppTaintTracking, ModelGeneratorInput>
