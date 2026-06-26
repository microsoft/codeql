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

/** Holds if `s` looks like a URL pointing at a trusted artifact host. */
bindingset[s]
predicate isTrustedArtifactHost(string s) {
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
        ])
}

/** A data-flow node that is tainted by a string constant looking like an artifact URL. */
class ArtifactUrl extends DataFlow::Node {
  ArtifactUrl() {
    exists(DataFlow::Node source, string s |
      TaintTracking::localTaint(source, this) and
      s =
        [
          source.asExpr().getValue().asString(),
          source.asExpr().getExpr().(ExpandableStringExpr).getUnexpandedValue()
        ] and
      isTrustedArtifactHost(s) and
      // Exclude API metadata endpoints (e.g. api.github.com/.../releases/latest),
      // which return JSON metadata rather than a downloadable artifact.
      not s.toLowerCase().matches(["%api.github.com%", "%api.bitbucket.org%"])
    )
  }
}

/**
 * A call that downloads an artifact from a trusted host.
 *
 * This covers cmdlets and their aliases (`Invoke-WebRequest`/`iwr`,
 * `Invoke-RestMethod`/`irm`, `Start-BitsTransfer`), native download tools
 * (`curl`, `wget`, `azcopy`, `aria2c`) and the .NET `WebClient`/`HttpClient`
 * download methods. The URL may be passed as a named argument (e.g. `-Uri`,
 * `-Source`), positionally, or as a method argument.
 */
class DownloadCall extends DataFlow::CallNode {
  ArtifactUrl url;

  DownloadCall() {
    this.getAName() =
      [
        // cmdlets and aliases
        "Invoke-WebRequest", "iwr", "Invoke-RestMethod", "irm", "Start-BitsTransfer",
        // native command-line download tools
        "curl", "curl.exe", "wget", "wget.exe", "azcopy", "azcopy.exe", "aria2c", "aria2c.exe",
        // .NET WebClient / HttpClient download methods
        "DownloadFile", "DownloadFileAsync", "DownloadFileTaskAsync", "DownloadData",
        "DownloadDataAsync", "DownloadDataTaskAsync", "DownloadString", "DownloadStringAsync",
        "GetByteArrayAsync", "GetStreamAsync"
      ] and
    url = this.getAnArgument()
  }

  /**
   * Gets the argument that names the file the artifact is written to, if any.
   * Downloads that consume the response inline (e.g. `irm ... | iex`) have no
   * such argument.
   */
  DataFlow::Node getOutFileArg() {
    result =
      this.getNamedArgument([
            "outfile", "destination", "outputfile", "outpath", "literalpath", "path", "o"
          ])
    or
    // WebClient.DownloadFile(url, destinationFile): the destination is the 2nd argument.
    this.getAName() = ["DownloadFile", "DownloadFileAsync", "DownloadFileTaskAsync"] and
    result = this.getArgument(1)
  }
}

/**
 * A call that verifies the integrity of a file, by computing/comparing a hash
 * or by checking a signature.
 */
class IntegrityCheck extends DataFlow::CallNode {
  IntegrityCheck() {
    this.getAName() =
      [
        "Get-FileHash", "gfh", // hash a file
        "certutil", "certutil.exe", // certutil -hashfile <file> SHA256
        "ComputeHash", // [SHA256]::Create().ComputeHash(...)
        "Get-AuthenticodeSignature", "Test-FileCatalog", // signature / catalog checks
        "cosign", "cosign.exe", "gpg", "gpg.exe" // external signature verification
      ]
  }

  /** Gets an argument referring to the file whose integrity is being checked. */
  DataFlow::Node getFile() { result = this.getAnArgument() }
}

module Conf implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) { source = any(DownloadCall c).getOutFileArg() }

  predicate isSink(DataFlow::Node sink) { sink = any(IntegrityCheck c).getFile() }

  /**
   * Bridges a file path to the bytes/text read from it, so that hashing the
   * *contents* of the downloaded file (e.g. `ComputeHash([IO.File]::ReadAllBytes($f))`)
   * is recognised as verifying `$f`.
   */
  predicate isAdditionalFlowStep(DataFlow::Node node1, DataFlow::Node node2) {
    exists(DataFlow::CallNode read |
      read.getAName() =
        [
          "ReadAllBytes", "ReadAllText", "ReadAllLines", "OpenRead", "ReadAsByteArrayAsync",
          "Get-Content", "gc", "cat", "type"
        ] and
      node1 = read.getAnArgument() and
      node2 = read
    )
  }
}

module Flow = DataFlow::Global<Conf>;

/** Holds if the downloaded file `out` flows to an integrity check. */
predicate isVerified(DataFlow::Node out) {
  exists(Flow::PathNode source |
    source.getNode() = out and
    source.isSource()
  )
}

from DownloadCall call
where
  // Report unless the file that was downloaded is later verified. A download
  // with no output-file argument cannot be hash-verified, so it is reported.
  not exists(DataFlow::Node out | out = call.getOutFileArg() and isVerified(out))
select call,
  "This downloads an artifact without verifying its integrity (e.g. a hash or signature check)."
