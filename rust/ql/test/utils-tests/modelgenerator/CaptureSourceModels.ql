import rust
import utils.modelgenerator.internal.CaptureModels
import SourceModels
import utils.test.InlineMadTest
import codeql.rust.dataflow.internal.ModelsAsData

module InlineMadTestConfig implements InlineMadTestConfigSig {
  string getCapturedModel(Function c) { result = Heuristic::captureSource(c) }

  string getKind() { result = "source" }
}

import InlineMadTest<InlineMadTestConfig>
