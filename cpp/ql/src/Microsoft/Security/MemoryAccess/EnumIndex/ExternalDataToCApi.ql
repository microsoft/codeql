/**
 * @kind path-problem
 * @id cpp/external-data-to-c-api
 */

import cpp
import semmle.code.cpp.dataflow.new.TaintTracking
import ExternalToCApiFlow::PathGraph

abstract class CApiFunction extends Function {
  abstract int getAnInputParameterIndex();
}

class StrcpyFunction extends CApiFunction {
  StrcpyFunction() { this.hasGlobalOrStdName("strcpy") }

  final override int getAnInputParameterIndex() { result = 1 }
}

class StrncpyFunction extends CApiFunction {
  StrncpyFunction() { this.hasGlobalOrStdName("strncpy") }

  final override int getAnInputParameterIndex() { result = 1 }
}

class StrcatFunction extends CApiFunction {
  StrcatFunction() { this.hasGlobalOrStdName("strcat") }

  final override int getAnInputParameterIndex() { result = 1 }
}

class StrncatFunction extends CApiFunction {
  StrncatFunction() { this.hasGlobalOrStdName("strncat") }

  final override int getAnInputParameterIndex() { result = 1 }
}

class SprintfFunction extends CApiFunction {
  SprintfFunction() { this.hasGlobalOrStdName("sprintf") }

  final override int getAnInputParameterIndex() { result = 1 }
}

class SnprintfFunction extends CApiFunction {
  SnprintfFunction() { this.hasGlobalOrStdName("snprintf") }

  final override int getAnInputParameterIndex() { result = 2 }
}

class StrxfrmFunction extends CApiFunction {
  StrxfrmFunction() { this.hasGlobalOrStdName("strxfrm") }

  final override int getAnInputParameterIndex() { result = 1 }
}

class StrdupFunction extends CApiFunction {
  StrdupFunction() { this.hasGlobalOrStdName("strdup") }

  final override int getAnInputParameterIndex() { result = 0 }
}

class StrndupFunction extends CApiFunction {
  StrndupFunction() { this.hasGlobalOrStdName("strndup") }

  final override int getAnInputParameterIndex() { result = 0 }
}

class WordexpFunction extends CApiFunction {
  WordexpFunction() { this.hasGlobalOrStdName("wordexp") }

  final override int getAnInputParameterIndex() { result = 0 }
}

class SetenvFunction extends CApiFunction {
  SetenvFunction() { this.hasGlobalOrStdName("setenv") }

  final override int getAnInputParameterIndex() { result = 0 }
}

class PutenvFunction extends CApiFunction {
  PutenvFunction() { this.hasGlobalOrStdName("putenv") }

  final override int getAnInputParameterIndex() { result = 0 }
}

class FopenFunction extends CApiFunction {
  FopenFunction() { this.hasGlobalOrStdName("fopen") }

  final override int getAnInputParameterIndex() { result = 0 }
}

class DlsymFunction extends CApiFunction {
  DlsymFunction() { this.hasGlobalOrStdName("dlsym") }

  final override int getAnInputParameterIndex() { result = 1 }
}

class GetaddrinfoFunction extends CApiFunction {
  GetaddrinfoFunction() { this.hasGlobalOrStdName("getaddrinfo") }

  final override int getAnInputParameterIndex() { result = 0 }
}

class PthreadSetnameNpFunction extends CApiFunction {
  PthreadSetnameNpFunction() { this.hasGlobalOrStdName("pthread_setname_np") }

  final override int getAnInputParameterIndex() { result = 1 }
}

predicate isSink(DataFlow::Node sink, CApiFunction f) {
  exists(int ii, Call c |
    c.getTarget() = f and
    sink.asIndirectExpr(ii) = c.getArgument(f.getAnInputParameterIndex()) and
    not exists(sink.asIndirectExpr(ii + 1))
  )
}

private import semmle.code.cpp.models.interfaces.DataFlow
private import semmle.code.cpp.models.interfaces.Taint
private import semmle.code.cpp.dataflow.internal.FlowSummaryImpl::Public

class ExternalFunction extends Function {
  ExternalFunction() {
    not this.hasDefinition() and
    not this instanceof DataFlowFunction and
    not this instanceof TaintFunction and
    not this instanceof SummarizedCallable and
    not this instanceof HeuristicAllocationFunction and
    not this instanceof DeallocationFunction
  }
}

import semmle.code.cpp.controlflow.Guards

predicate lessThanCheck(IRGuardCondition g, Expr e, boolean branch) {
  exists(Operand op | op.getDef().getConvertedResultExpression() = e |
    exists(GuardValue value |
      value.asBooleanValue() = branch and
      g.comparesLt(op, _, true, value)
    )
    or
    g.comparesLt(op, _, _, true, branch)
  )
}

module ExternalToCApiConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) {
    exists(Call call | call.getTarget() instanceof ExternalFunction |
      source.asIndirectExpr() = call
      or
      exists(int ii |
        source.asDefiningArgument(ii) = call.getAnArgument() and
        not exists(source.asDefiningArgument(ii + 1))
      )
    )
  }

  predicate isBarrier(DataFlow::Node n) {
    // Disable flow through globals to reduce FPs
    exists(n.asVariable())
    or
    exists(n.asIndirectVariable())
    or
    // A less than check on the pointer
    n = DataFlow::BarrierGuard<lessThanCheck/3>::getAnIndirectBarrierNode()
    or
    // A less than check that guards this node
    any(IRGuardCondition gc).ensuresLt(_, _, n.getBasicBlock(), true)
    or
    any(IRGuardCondition gc).ensuresLt(_, _, _, n.getBasicBlock(), _)
  }

  predicate isSink(DataFlow::Node sink) { isSink(sink, _) }

  predicate isBarrierOut(DataFlow::Node n) { isSink(n) }

  predicate isBarrierIn(DataFlow::Node n) { isSource(n) }
}

module ExternalToCApiFlow = TaintTracking::Global<ExternalToCApiConfig>;

from ExternalToCApiFlow::PathNode source, ExternalToCApiFlow::PathNode sink, Function f
where ExternalToCApiFlow::flowPath(source, sink) and isSink(sink.getNode(), f)
select sink.getNode(), source, sink, "External flow from $@", f, f.toString()
