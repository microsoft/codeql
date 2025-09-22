import java
import utils.modelgenerator.internal.CaptureModels
import SinkModels
import utils.test.InlineMadTest

module InlineMadTestConfig implements InlineMadTestConfigSig {
  string getCapturedModel(Callable c) { result = Heuristic::captureSink(c) }

  string getKind() { result = "sink" }
}

import InlineMadTest<InlineMadTestConfig>
