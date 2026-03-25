/**
 * Provides classes representing various flow sources for taint tracking.
 */

import cpp
import semmle.code.cpp.ir.dataflow.DataFlow
private import semmle.code.cpp.ir.IR
import semmle.code.cpp.models.interfaces.FlowSource
private import semmle.code.cpp.ir.dataflow.internal.ModelUtil
private import semmle.code.cpp.ir.dataflow.internal.DataFlowPrivate as Private

/** A data flow source of user input, whether local or remote. */
abstract class FlowSource extends DataFlow::Node {
  /** Gets a string that describes the type of this flow source. */
  abstract string getSourceType();
}

/** A data flow source of remote user input. */
abstract class RemoteFlowSource extends FlowSource { }

/** A data flow source of local user input. */
abstract class LocalFlowSource extends FlowSource { }

/**
 * A remote data flow source that is defined through a `RemoteFlowSourceFunction` model.
 */
private class RemoteModelSource extends RemoteFlowSource {
  string sourceType;

  RemoteModelSource() {
    exists(CallInstruction call, RemoteFlowSourceFunction func, FunctionOutput output |
      call.getStaticCallTarget() = func and
      func.hasRemoteFlowSource(output, sourceType) and
      this = callOutput(call, output)
    )
  }

  override string getSourceType() { result = sourceType }
}

/**
 * A local data flow source that is defined through a `LocalFlowSourceFunction` model.
 */
private class LocalModelSource extends LocalFlowSource {
  string sourceType;

  LocalModelSource() {
    exists(CallInstruction call, LocalFlowSourceFunction func, FunctionOutput output |
      call.getStaticCallTarget() = func and
      func.hasLocalFlowSource(output, sourceType) and
      this = callOutput(call, output)
    )
  }

  override string getSourceType() { result = sourceType }
}

/**
 * A local data flow source that is the `argv` parameter to `main` or `wmain`.
 */
private class ArgvSource extends LocalFlowSource {
  ArgvSource() {
    exists(Function main, Parameter argv |
      main.hasGlobalName(["main", "wmain"]) and
      main.getParameter(1) = argv and
      this.asParameter(2) = argv
    )
  }

  override string getSourceType() { result = "a command-line argument" }
}

/**
 * A local data flow source that is the `pCmdLine` parameter to `WinMain` or `wWinMain`.
 */
private class CmdLineSource extends LocalFlowSource {
  CmdLineSource() {
    exists(Function main, Parameter pCmdLine |
      main.hasGlobalName(["WinMain", "wWinMain"]) and
      main.getParameter(2) = pCmdLine and
      this.asParameter(1) = pCmdLine
    )
  }

  override string getSourceType() { result = "a command-line" }
}

/**
 * A remote data flow source that is defined through 'models as data'.
 */
private class ExternalRemoteFlowSource extends RemoteFlowSource {
  ExternalRemoteFlowSource() { sourceNode(this, "remote") }

  override string getSourceType() { result = "external" }
}

/**
 * A local data flow source that is defined through 'models as data'.
 */
private class ExternalLocalFlowSource extends LocalFlowSource {
  ExternalLocalFlowSource() { sourceNode(this, "local") }

  override string getSourceType() { result = "external" }
}

/** A remote data flow sink. */
abstract class RemoteFlowSink extends DataFlow::Node {
  /** Gets a string that describes the type of this flow sink. */
  abstract string getSinkType();
}

/**
 * A remote flow sink derived from the `RemoteFlowSinkFunction` model.
 */
private class RemoteParameterSink extends RemoteFlowSink {
  string sourceType;

  RemoteParameterSink() {
    exists(CallInstruction call, RemoteFlowSinkFunction func, FunctionInput input |
      call.getStaticCallTarget() = func and
      func.hasRemoteFlowSink(input, sourceType) and
      this = callInput(call, input)
    )
  }

  override string getSinkType() { result = sourceType }
}

/**
 * A remote flow sink defined in a CSV model.
 */
private class RemoteFlowFromCsvSink extends RemoteFlowSink {
  RemoteFlowFromCsvSink() { sinkNode(this, "remote-sink") }

  override string getSinkType() { result = "remote flow sink" }
}

class DriverEntryFunction extends Function {
  DriverEntryFunction() { this.hasGlobalName("DriverEntry") }
}

private predicate hasAMajorFunctionAssignment(
  Parameter driverObject, int index, Function majorFunction
) {
  exists(ArrayExpr ae, AssignExpr assign, FieldAccess fa |
    assign.getLValue() = ae and
    ae.getArrayBase() = fa and
    fa.getQualifier() = driverObject.getAnAccess() and
    fa.getTarget().hasName("MajorFunction") and
    ae.getArrayOffset().getValue().toInt() = index and
    assign.getRValue().(FunctionAccess).getTarget() = majorFunction
  )
}

private predicate hasUserControlledIrpParameter(Function f) {
  exists(DriverEntryFunction entry, Parameter driverObject, int index |
    entry.getParameter(0) = driverObject and
    hasAMajorFunctionAssignment(driverObject, index, f) and
    index =
      [
        14, // IRP_MJ_DEVICE_CONTROL
        15 // IRP_MJ_INTERNAL_DEVICE_CONTROL
      ]
  )
}

class DRIVER_DISPATCH extends TypedefType {
  DRIVER_DISPATCH() { this.getName() = "DRIVER_DISPATCH" }
}

class IRP extends Class {
  IRP() { this.hasName("_IRP") }
}

private class IrpParameter extends DataFlow::IndirectParameterNode {
  IrpParameter() {
    exists(Function f |
      hasUserControlledIrpParameter(f) and
      f.getADeclarationEntry().getTypedefType() instanceof DRIVER_DISPATCH and
      f.getAParameter() = this.getParameter() and
      super.getIndirectionIndex() = 1 and
      this.getType().stripType() instanceof IRP
    )
  }
}

private module Config implements DataFlow::StateConfigSig {
  newtype FlowState =
    Pre() or
    PostAssociatedIrp()

  additional predicate isSink(DataFlow::Node sink, FlowState state, DataFlow::Node node2) {
    exists(DataFlow::ContentSet cs, DataFlow::FieldContent fc |
      Private::readStep(sink, cs, node2) and
      cs.isSingleton(fc) and
      fc.getIndirectionIndex() = 1
    |
      state = PostAssociatedIrp() and
      fc.getAField().hasName("SystemBuffer")
      or
      state = Pre() and
      fc.getAField().hasName("UserBuffer")
    )
  }

  predicate isSource(DataFlow::Node node, FlowState state) {
    node instanceof IrpParameter and
    state = Pre()
  }

  predicate isSink(DataFlow::Node node, FlowState state) { isSink(node, state, _) }

  int fieldFlowBranchLimit() { result = 0 }

  int accessPathLimit() { result = 0 }

  predicate isAdditionalFlowStep(
    DataFlow::Node node1, FlowState state1, DataFlow::Node node2, FlowState state2
  ) {
    exists(DataFlow::ContentSet cs, DataFlow::FieldContent fc |
      Private::readStep(node1, cs, node2) and
      cs.isSingleton(fc) and
      fc.getIndirectionIndex() = 1 and
      state1 = Pre() and
      fc.getAField().hasName("AssociatedIrp") and
      state2 = PostAssociatedIrp()
    )
  }
}

private module IrpFlow = DataFlow::GlobalWithState<Config>;

class IrpFlowSource extends RemoteFlowSource {
  IrpFlowSource() {
    exists(IrpFlow::PathNode sink |
      sink.isSink() and
      Config::isSink(sink.getNode(), _, this)
    )
  }

  override string getSourceType() { result = "an I/O Request Packet (IRP)" }
}
