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

/** Holds if `node` is tainted by a string constant that looks like an artifact URL. */
predicate isArtifactUrl(DataFlow::Node node) {
  exists(DataFlow::Node source, string s |
    TaintTracking::localTaint(source, node) and
    s =
      [
        source.asExpr().getValue().asString(),
        source.asExpr().getExpr().(ExpandableStringExpr).getUnexpandedValue()
      ] and
    isTrustedArtifactHost(s)
  )
}

/**
 * Holds if `call` downloads an artifact, where `url` is the argument that
 * carries the (trusted-host) download URL.
 *
 * This covers cmdlets and their aliases (`Invoke-WebRequest`/`iwr`,
 * `Invoke-RestMethod`/`irm`, `Start-BitsTransfer`), native download tools
 * (`curl`, `wget`, `azcopy`, `aria2c`) and the .NET `WebClient`/`HttpClient`
 * download methods. The URL may be passed as a named argument (e.g. `-Uri`,
 * `-Source`), positionally, or as a method argument.
 */
predicate downloadCall(DataFlow::CallNode call, DataFlow::Node url) {
  call.getAName() =
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
  url = call.getAnArgument() and
  isArtifactUrl(url)
}

/**
 * Gets the argument of `call` that names the file the artifact is written to,
 * if any. Downloads that consume the response inline (e.g. `irm ... | iex`)
 * have no such argument.
 */
DataFlow::Node getOutFileArg(DataFlow::CallNode call) {
  downloadCall(call, _) and
  (
    result =
      call.getNamedArgument([
            "outfile", "destination", "outputfile", "outpath", "literalpath", "path", "o"
          ])
    or
    // WebClient.DownloadFile(url, destinationFile): the destination is the 2nd argument.
    call.getAName() = ["DownloadFile", "DownloadFileAsync", "DownloadFileTaskAsync"] and
    result = call.getArgument(1)
  )
}

/**
 * Holds if `check` verifies the integrity of the file referred to by `file`,
 * by computing/comparing a hash or by checking a signature.
 */
predicate integrityCheck(DataFlow::CallNode check, DataFlow::Node file) {
  check.getAName() =
    [
      "Get-FileHash", "gfh", // hash a file
      "certutil", "certutil.exe", // certutil -hashfile <file> SHA256
      "ComputeHash", // [SHA256]::Create().ComputeHash(...)
      "Get-AuthenticodeSignature", "Test-FileCatalog", // signature / catalog checks
      "cosign", "cosign.exe", "gpg", "gpg.exe" // external signature verification
    ] and
  file = check.getAnArgument()
}

module Conf implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) { source = getOutFileArg(_) }

  predicate isSink(DataFlow::Node sink) { integrityCheck(_, sink) }
}

module Flow = DataFlow::Global<Conf>;

/** Holds if the downloaded file `out` flows to an integrity check. */
predicate isVerified(DataFlow::Node out) {
  exists(Flow::PathNode source |
    source.getNode() = out and
    source.isSource()
  )
}

from DataFlow::CallNode call
where
  downloadCall(call, _) and
  // Report unless the file that was downloaded is later verified. A download
  // with no output-file argument cannot be hash-verified, so it is reported.
  not exists(DataFlow::Node out | out = getOutFileArg(call) and isVerified(out))
select call,
  "This downloads an artifact without verifying its integrity (e.g. a hash or signature check)."
