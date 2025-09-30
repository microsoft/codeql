private import codeql.dataflow.DataFlow as DF
private import codeql.util.Location

module CodeSuggestionsMake<LocationSig Location, DF::InputSig<Location> Lang> {
  private module DataFlow = DF::DataFlowMake<Location, Lang>;

  module CodeSuggestions<DF::Configs<Location, Lang>::ConfigSig Config> {
    private module Flow = DataFlow::Global<Config>;

    query predicate barriers(Lang::Node node){
      Config::isBarrier(node)
    }

    // default predicate isBarrier(Node node) { none() }

    // /** Holds if data flow into `node` is prohibited. */
    // default predicate isBarrierIn(Node node) { none() }

    // /** Holds if data flow out of `node` is prohibited. */
    // default predicate isBarrierOut(Node node) { none() }
  }

  module CodeSuggestionsStateful<DF::Configs<Location, Lang>::StateConfigSig Config> {
    private module Flow = DataFlow::GlobalWithState<Config>;

    query predicate barriers(Lang::Node node){
      Config::isBarrier(node)
    }

    // default predicate isBarrier(Node node) { none() }

    // /** Holds if data flow into `node` is prohibited. */
    // default predicate isBarrierIn(Node node) { none() }

    // /** Holds if data flow out of `node` is prohibited. */
    // default predicate isBarrierOut(Node node) { none() }
  }
}