overlay[local?]
module;

import java
private import semmle.code.java.dataflow.DataFlow
private import semmle.code.java.dataflow.internal.DataFlowImplSpecific
private import codeql.dataflowstack.FlowStack as FlowStack

module LanguageFlowStack = FlowStack::LanguageDataFlow<Location, JavaDataFlow>;

module FlowStackDataFlowConfig<LanguageFlowStack::AbstractDF::ConfigSig Config>{

  /**
   * Flow Type of Global DataFlow
   */
  module FlowTypeDataFlow implements LanguageFlowStack::FlowTypeImpl{
    additional class InternalPathNode = DataFlow::Global<Config>::PathNode;
    class PathNode instanceof InternalPathNode{
      PathNode getASuccessor() { result = this.(InternalPathNode).getASuccessor() }
      JavaDataFlow::Node getNode() { result = this.(InternalPathNode).getNode() }
      predicate isSource() { this.(InternalPathNode).isSource() }
      string toString(){ result = this.(InternalPathNode).toString() }
    }
  }

  /**
   * The implementation of the interface, mapping the language implementation of DataFlow/FlowType to language agnostic constructs
   */
  private module FlowStackInput<LanguageFlowStack::FlowTypeImpl FlowType>
    implements LanguageFlowStack::DataFlowConfigContext<Config>::FlowInstance<FlowType>
  {
    JavaDataFlow::Node getNode(FlowType::PathNode n) { result = n.getNode() }

    predicate isSource(FlowType::PathNode n) { n.isSource() }

    FlowType::PathNode getASuccessor(FlowType::PathNode n) { result = n.getASuccessor() }

    JavaDataFlow::DataFlowCallable getARuntimeTarget(JavaDataFlow::DataFlowCall call) {
      result.asCallable() = call.asCall().getCallee()
    }

    JavaDataFlow::Node getAnArgumentNode(JavaDataFlow::DataFlowCall call) {
      result = JavaDataFlow::exprNode(call.asCall().getAnArgument())
    }
  }

  /** Create a DataFlowStack */
  module DataFlowStackMake{
    import LanguageFlowStack::FlowStack<Config, FlowTypeDataFlow, FlowStackInput<FlowTypeDataFlow>>
  }

  module BiStackAnalysisMake<
    DataFlow::ConfigSig ConfigA,
    DataFlow::ConfigSig ConfigB
  >{
    import LanguageFlowStack::BiStackAnalysis<
      ConfigA, FlowTypeDataFlow, FlowStackInput<FlowTypeDataFlow>,
      ConfigB, FlowTypeDataFlow, FlowStackInput<FlowTypeDataFlow>
    >
  }
}