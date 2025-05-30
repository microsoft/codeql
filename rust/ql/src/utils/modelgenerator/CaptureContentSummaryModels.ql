/**
 * @name Capture content based summary models.
 * @description Finds applicable content based summary models to be used by other queries.
 * @kind diagnostic
 * @id rust/utils/modelgenerator/contentbased-summary-models
 * @tags modelgenerator
 */

import internal.CaptureModels
import SummaryModels

from DataFlowSummaryTargetApi api, string flow
where flow = ContentSensitive::captureFlow(api, _)
select flow order by flow
