/**
 * Provides a taint tracking configuration for reasoning about
 * insecure-randomness vulnerabilities (CWE-338).
 *
 * Note, for performance reasons: only import this file if
 * `InsecureRandomnessFlow` is needed, otherwise
 * `InsecureRandomnessCustomizations` should be imported instead.
 */

import powershell
import semmle.code.powershell.dataflow.TaintTracking
import InsecureRandomnessCustomizations::InsecureRandomness
import semmle.code.powershell.dataflow.DataFlow

private module Config implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) { source instanceof Source }

  predicate isSink(DataFlow::Node sink) { sink instanceof Sink }

  predicate isBarrier(DataFlow::Node node) { node instanceof Sanitizer }

  predicate isAdditionalFlowStep(DataFlow::Node node1, DataFlow::Node node2) {
    // When .NextBytes() is called on a System.Random instance,
    // taint flows from the qualifier to the argument (the byte array is filled with random bytes).
    exists(DataFlow::CallNode call |
      call.matchesName("NextBytes") and
      node1 = call.getQualifier() and
      node2.(DataFlow::PostUpdateNode).getPreUpdateNode() = call.getArgument(0)
    )
  }
}

/**
 * Taint-tracking for reasoning about insecure-randomness vulnerabilities.
 */
module InsecureRandomnessFlow = TaintTracking::Global<Config>;
