private import codeql.dataflow.DataFlow as DF
private import codeql.util.Location

/**
 * A module to export additional information about a database in relation to a specific query,
 * which is populated in the SecurityDescriptor generic property bag.
 */
module ExtraExportsMake<LocationSig Location, DF::InputSig<Location> Lang> {
  private module DataFlow = DF::DataFlowMake<Location, Lang>;

  /**
   * A signature for exporting sets of data about a Codebase contextualized for a given query.
   */
  signature module ExtraExportsConfigSig{
    default predicate getExtraExports(string pred, string label){
      pred = "barriers" and label = "barriers"
    }
  }

  /**
   * A generalized module for exporting additional barriers/sanitizers/etc associated with a query
   */
  module ExtraExportsGeneral<ExtraExportsConfigSig Config>{
    query predicate extraExports(string pred, string label){
      Config::getExtraExports(pred, label)
    }
  }

  /**
   * A signature for exporting sets of data about a Codebase contextualized for a given query.
   */
  private signature module ExtraExportsDataFlowConfigSig{
    default predicate getExtraExports(string pred, string label){
      pred = "barriers" and label = "barriers"
      or pred = "barriersIn" and label = "barriersIn"
      or pred = "barriersOut" and label = "barriersOut"
    }

    default Lang::Node getBarriers(){ none() }

    default Lang::Node getBarriersIn(){ none() }

    default Lang::Node getBarriersOut(){ none() }
  }

  /**
   * A module for exporting additional barriers/sanitizers/etc associated with a dataflow query
   */
  private module ExportsDataFlowGeneric<ExtraExportsDataFlowConfigSig Config>{
    query predicate extraExports(string pred, string label){
      Config::getExtraExports(pred, label)
    }

    query predicate barriers(Lang::Node node){
      node = Config::getBarriers()
    }

    query predicate barriersIn(Lang::Node node){
      node = Config::getBarriersIn()
    }

    query predicate barriersOut(Lang::Node node){
      node = Config::getBarriersOut()
    }
  }

  /**
   * A DataFlow configuration to track a flow between a Source from a given DataFlow Configuration and the Barriers associated with that DataFlow.
   * 
   * Useful for extracting the set of sanitizers that are nullifying risk associated with ingress paths, reducing the total set of sanitizers.
   */
  module SourceToBarrierDFConfig<DataFlow::ConfigSig UpstreamConfig> implements DataFlow::ConfigSig{
    predicate isSource(Lang::Node node){ UpstreamConfig::isSource(node) }

    predicate isSink(Lang::Node node){ UpstreamConfig::isBarrier(node) }

    predicate isAdditionalFlowStep(Lang::Node n1, Lang::Node n2) {
      UpstreamConfig::isAdditionalFlowStep(n1, n2)
    }

    predicate isBarrier(Lang::Node node) { UpstreamConfig::isBarrier(node) }

    predicate isBarrierOut(Lang::Node node) {
      UpstreamConfig::isBarrierOut(node)
    }
  }

  module SourceToBarrierDFStatefulConfig<DataFlow::StateConfigSig UpstreamConfig> implements DataFlow::StateConfigSig{
    class FlowState = UpstreamConfig::FlowState;
    predicate isSource(Lang::Node node, FlowState state){ UpstreamConfig::isSource(node, state) }
    predicate isSink(Lang::Node node, FlowState state){ UpstreamConfig::isBarrier(node, state) }
    predicate isAdditionalFlowStep(Lang::Node n1, FlowState s1, Lang::Node n2, FlowState s2) {
      UpstreamConfig::isAdditionalFlowStep(n1, s1, n2, s2)
    }

    predicate isBarrier(Lang::Node node, FlowState state) { UpstreamConfig::isBarrier(node, state) }

    predicate isBarrierOut(Lang::Node node, FlowState state) { UpstreamConfig::isBarrierOut(node, state) }
  }
  /**
   * Export general details about a regular DataFlow (standardized)
   */
  module ExportDF<DF::Configs<Location, Lang>::ConfigSig Config> {
    module ExportsConfig implements ExtraExportsDataFlowConfigSig{
      additional module SourceToBarrierFlow = DataFlow::Global<SourceToBarrierDFConfig<Config>>;

      Lang::Node getBarriers(){
        SourceToBarrierFlow::flow(_, result)
      }

      Lang::Node getBarriersIn(){
        Config::isBarrierIn(result)
      }

      Lang::Node getBarriersOut(){
        Config::isBarrierOut(result)
      }
    }

    import ExportsDataFlowGeneric<ExportsConfig>
  }

  /**
   * Export general details about a stateful DataFlow (standardized)
   */
  module ExportDFStateful<DF::Configs<Location, Lang>::StateConfigSig Config> {
    module ExportsConfig implements ExtraExportsDataFlowConfigSig{
      additional module SourceToBarrierFlow = DataFlow::GlobalWithState<SourceToBarrierDFStatefulConfig<Config>>;

      Lang::Node getBarriers(){
        SourceToBarrierFlow::flow(_, result)
      }

      Lang::Node getBarriersIn(){
        Config::isBarrierIn(result, _)
      }

      Lang::Node getBarriersOut(){
        Config::isBarrierOut(result, _)
      }
    }

    import ExportsDataFlowGeneric<ExportsConfig>
  }

  signature class LocatableSig extends Lang::Node;

  module ExportSanitizer<LocatableSig Locatable>{
    query predicate extraExports(string pred, string label){
      pred = "sanitizers" and label = "sanitizers"
    }

    query predicate sanitizers(Locatable node){
      any() // TODO: constrain by uniqueness
    }
  }
}