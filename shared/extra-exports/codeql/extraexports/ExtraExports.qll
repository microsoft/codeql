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
  signature module ExtraExportsDataFlowConfigSig{
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
  module ExtraExportsDataFlow<ExtraExportsDataFlowConfigSig Config>{
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
   * Export general details about a regular DataFlow (standardized)
   */
  module ExtraExportsDF<DF::Configs<Location, Lang>::ConfigSig Config> {
    module ExportsConfig implements ExtraExportsDataFlowConfigSig{
      Lang::Node getBarriers(){
        Config::isBarrier(result)
      }

      Lang::Node getBarriersIn(){
        Config::isBarrierIn(result)
      }

      Lang::Node getBarriersOut(){
        Config::isBarrierOut(result)
      }
    }

    import ExtraExportsDataFlow<ExportsConfig>
  }

  /**
   * Export general details about a stateful DataFlow (standardized)
   */
  module ExtraExportsDFStateful<DF::Configs<Location, Lang>::StateConfigSig Config> {
    module ExportsConfig implements ExtraExportsDataFlowConfigSig{
      Lang::Node getBarriers(){
        Config::isBarrier(result)
      }

      Lang::Node getBarriersIn(){
        Config::isBarrierIn(result)
      }

      Lang::Node getBarriersOut(){
        Config::isBarrierOut(result)
      }
    }

    import ExtraExportsDataFlow<ExportsConfig>
  }
}