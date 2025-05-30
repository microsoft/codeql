/**
 * @name Capture sink models.
 * @description Finds public methods that act as sinks as they flow into a known sink.
 * @kind diagnostic
 * @id java/utils/modelgenerator/sink-models
 * @tags modelgenerator
 */

import internal.CaptureModels
import SinkModels

from DataFlowSinkTargetApi api, string sink
where sink = Heuristic::captureSink(api)
select sink order by sink
