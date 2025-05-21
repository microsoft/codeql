import powershell
import semmle.code.powershell.frameworks.data.internal.ApiGraphModels
private import semmle.code.powershell.dataflow.internal.DataFlowPublic as DataFlow

module EngineIntrinsics {
  private class EngineIntrinsicsGlobalEntry extends ModelInput::TypeModel {
    override DataFlow::Node getASource(string type) {
      type = "system.management.automation.engineintrinsics" and
      result.asExpr().getExpr().(VarReadAccess).getVariable().matchesName("executioncontext")
    }
  }
}
