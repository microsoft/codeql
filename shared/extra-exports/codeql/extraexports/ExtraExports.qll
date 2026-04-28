private import codeql.dataflow.DataFlow as DF
private import codeql.util.Location

/**
 * A module to export additional information about a database in relation to a specific query,
 * which is populated in the SecurityDescriptor generic property bag.
 * 
 * Used for LLM enrichment pertaining to automated remediation PRs.
 */
module ExtraExportsMake<LocationSig Location, DF::InputSig<Location> Lang> {
  private module DataFlow = DF::DataFlowMake<Location, Lang>;

  /**
   * A signature for exporting sets of data about a Codebase contextualized for a given query.
   */
  signature module ExtraExportsConfigSig{
    default Lang::Node getBarriers(){ none() }

    default Lang::Node getBarriersIn(){ none() }

    default Lang::Node getBarriersOut(){ none() }
  }

  /**
   * A generalized module for exporting additional barriers/sanitizers/etc associated with a query
   */
  module ExtraExportsGeneral<ExtraExportsConfigSig Config>{

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
    module ExportsConfig implements ExtraExportsConfigSig{
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

    import ExtraExportsGeneral<ExportsConfig>
  }

  /**
   * Export general details about a stateful DataFlow (standardized)
   */
  module ExtraExportsDFStateful<DF::Configs<Location, Lang>::StateConfigSig Config> {
    module ExportsConfig implements ExtraExportsConfigSig{
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

    import ExtraExportsGeneral<ExportsConfig>
  }
}