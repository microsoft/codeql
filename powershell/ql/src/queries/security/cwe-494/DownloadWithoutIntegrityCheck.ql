/**
 * @name Unvalidated Artifact Download
 * @description Download of artifact without integrity check.
 * @kind problem
 * @problem.severity warning
 * @security-severity 7.5
 * @precision high
 * @id powershell/download-without-integrity-check
 * @tags security
 *       external/cwe/cwe-494
 *       external/cwe/cwe-829
 */

import powershell
import semmle.code.powershell.dataflow.DataFlow
import semmle.code.powershell.dataflow.TaintTracking

predicate invokeGitHub(DataFlow::CallNode call, DataFlow::Node out) {
  exists(DataFlow::Node source, string s, DataFlow::Node uri |
    call.getAName() = ["Invoke-WebRequest", "iwr", "Invoke-RestMethod", "irm", "curl", "wget"] and
    uri = call.getNamedArgument("uri") and
    TaintTracking::localTaint(source, uri) and
    s.toLowerCase()
        .matches([
            "%github%",
            "%gitlab%",
            "%bitbucket%",
            "%sourceforge%",
            "%powershellgallery%",
            "%nuget%",
            "%npmjs%",
            "%pypi%",
            "%repo1.maven%",
            "%repo.maven.apache%",
            "%blob.core.windows%",
            "%amazonaws%",
            "%googleapis%",
            "%azure%",
            "%visualstudio%",
            "%jfrog%",
            "%artifactory%"
          ]) and
    s =
      [
        source.asExpr().getValue().asString(),
        source.asExpr().getExpr().(ExpandableStringExpr).getUnexpandedValue()
      ] and
    out = call.getNamedArgument("outfile")
  )
}

module Conf implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) { invokeGitHub(_, source) }

  predicate isSink(DataFlow::Node sink) {
    exists(DataFlow::CallNode hasher |
      hasher.getAName() = ["Get-FileHash", "gfh"] and
      sink = hasher.getNamedArgument(["path", "literalpath"])
    )
  }
}

module Flow = DataFlow::Global<Conf>;

predicate isHashed(DataFlow::Node out) {
  exists(Flow::PathNode source |
    source.getNode() = out and
    source.isSource()
  )
}

from DataFlow::CallNode call, DataFlow::Node out
where
  invokeGitHub(call, out) and
  not isHashed(out)
select call, "This downloads an artifact from GitHub without checking its hash."
