
import csharp
private import codeql.dataflow.DataFlow
private import semmle.code.csharp.dataflow.internal.DataFlowImplSpecific

private import codeql.dataflowstack.DataFlowStack as DFS
private import DFS::DataFlowStackMake<Location, CsharpDataFlow> as DataFlowStackFactory

module DataFlowStackMake<DataFlowStackFactory::DataFlow::GlobalFlowSig Flow>{
    import DataFlowStackFactory::FlowStack<Flow>
}

module BiStackAnalysisMake<DataFlowStackFactory::DataFlow::GlobalFlowSig FlowA, DataFlowStackFactory::DataFlow::GlobalFlowSig FlowB>{
    import DataFlowStackFactory::BiStackAnalysis<FlowA, FlowB>
}