/**
 * @name Execution of an attacker-influenced download without verification
 * @description Code from an insecure or attacker-controlled download is executed without an effective integrity or publisher check.
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
import semmle.code.powershell.controlflow.ControlFlowGraph
import semmle.code.powershell.controlflow.CfgNodes
import semmle.code.powershell.dataflow.flowsources.Remote

/** Gets a cmdlet's named argument, or its positional argument when not named. */
bindingset[name, position]
DataFlow::Node getArgument(DataFlow::CallNode call, string name, int position) {
  result = call.getNamedArgument(name)
  or
  not call.hasNamedArgument(name) and
  result = call.getPositionalArgument(position)
}

/** Gets a pipeline argument without confusing it with the command's ordinary arguments. */
DataFlow::Node getPipelineInput(DataFlow::CallNode call) {
  result.asExpr() = call.getCallNode().getPipelineArgument()
}

/** Holds if `node` has an explicitly known .NET receiver type. */
bindingset[type]
predicate hasType(DataFlow::Node node, string type) {
  exists(DataFlow::ObjectCreationNode creation |
    (
      creation.getLowerCaseConstructedTypeName() = type.toLowerCase()
      or
      creation.getQualifier().asExpr().getExpr().(TypeNameExpr).getPossiblyQualifiedName() =
        type.toLowerCase()
    ) and
    DataFlow::localFlow(creation, node)
  )
  or
  exists(DataFlow::Node parameter |
    parameter.asParameter().getAnAttribute().(TypeConstraint).getName().toLowerCase() =
      type.toLowerCase() and
    DataFlow::localFlow(parameter, node)
  )
}

predicate isDotNetDownload(DataFlow::CallNode call) {
  call.getAName() =
    [
      "DownloadFile", "DownloadFileAsync", "DownloadFileTaskAsync", "DownloadData",
      "DownloadDataAsync", "DownloadDataTaskAsync", "DownloadString", "DownloadStringAsync",
      "DownloadStringTaskAsync", "GetStringAsync", "GetByteArrayAsync", "GetStreamAsync"
    ]
}

/** A download, with URL and destination roles modeled separately. */
class DownloadCall extends DataFlow::CallNode {
  DownloadCall() {
    this.getAName() =
      [
        "Invoke-WebRequest", "iwr", "Invoke-RestMethod", "irm", "curl", "wget",
        "Start-BitsTransfer", "curl.exe", "wget.exe", "azcopy", "azcopy.exe", "aria2c", "aria2c.exe"
      ]
    or
    isDotNetDownload(this) and
    hasType(this.getQualifier(),
      ["System.Net.WebClient", "Net.WebClient", "System.Net.Http.HttpClient", "Net.Http.HttpClient"])
  }

  DataFlow::Node getUrl() {
    this.getAName() = ["Invoke-WebRequest", "iwr", "Invoke-RestMethod", "irm", "curl", "wget"] and
    result = getArgument(this, "uri", 0)
    or
    this.getAName() = "Start-BitsTransfer" and
    result = getArgument(this, "source", 0)
    or
    this.getAName() = ["curl.exe", "wget.exe", "aria2c", "aria2c.exe"] and
    result = [this.getNamedArgument("url"), this.getPositionalArgument(0)]
    or
    this.getAName() = ["azcopy", "azcopy.exe"] and
    this.getPositionalArgument(0).asExpr().getValue().asString().toLowerCase() = "copy" and
    result = this.getPositionalArgument(1)
    or
    this.asExpr().getExpr() instanceof InvokeMemberExpr and
    result = this.getArgument(0)
  }

  DataFlow::Node getOutFileArg() {
    this.getAName() = ["Invoke-WebRequest", "iwr", "Invoke-RestMethod", "irm", "curl", "wget"] and
    result = this.getNamedArgument("outfile")
    or
    this.getAName() = "Start-BitsTransfer" and
    result = getArgument(this, "destination", 1)
    or
    this.getAName() = ["curl.exe", "wget.exe", "aria2c", "aria2c.exe"] and
    result = this.getNamedArgument(["o", "output"])
    or
    this.getAName() = ["azcopy", "azcopy.exe"] and
    result = this.getPositionalArgument(2)
    or
    this.getAName() = ["DownloadFile", "DownloadFileAsync", "DownloadFileTaskAsync"] and
    result = this.getArgument(1)
  }

  /** Gets returned content; an ordinary file download's status output is not its body. */
  DataFlow::Node getContent() {
    not exists(this.getOutFileArg()) and
    not this.getAName() =
      ["Start-BitsTransfer", "wget.exe", "azcopy", "azcopy.exe", "aria2c", "aria2c.exe"] and
    result = this
  }
}

/** Holds if an entire expression is known to start with the insecure HTTP scheme. */
predicate hasHttpPrefix(Expr expr) {
  [
    expr.getValue().asString(),
    expr.(ExpandableStringExpr).getUnexpandedValue()
  ].toLowerCase().matches("http://%")
  or
  expr instanceof AddExpr and
  hasHttpPrefix(expr.(AddExpr).getLeft())
}

/** Explicit inbound request data, not an arbitrary parameter or environment variable. */
class RequestUrlInput extends DataFlow::Node {
  RequestUrlInput() {
    exists(IndexExpr index, MemberExpr query, DataFlow::Node receiver, DataFlow::Node collection |
      query.memberNameMatches("QueryString") and
      receiver.asExpr().getExpr() = query.getQualifier() and
      hasType(receiver, ["System.Net.HttpListenerRequest", "Net.HttpListenerRequest"]) and
      collection.asExpr().getExpr() = query and
      DataFlow::localFlow(collection, any(DataFlow::Node n | n.asExpr().getExpr() = index.getBase())) and
      this.asExpr().getExpr() = index
    )
  }
}

module HttpOriginConf implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) { hasHttpPrefix(source.asExpr().getExpr()) }

  predicate isSink(DataFlow::Node sink) { sink = any(DownloadCall d).getUrl() }
}

module HttpOriginFlow = DataFlow::Global<HttpOriginConf>;

module RemoteOriginConf implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) {
    source instanceof RequestUrlInput
    or
    source instanceof RemoteFlowSource and
    // Generic download responses do not establish control by a less-trusted caller.
    not source instanceof DownloadCall and
    not isDotNetDownload(source.(DataFlow::CallNode))
  }

  predicate isSink(DataFlow::Node sink) { sink = any(DownloadCall d).getUrl() }
}

module RemoteOriginFlow = DataFlow::Global<RemoteOriginConf>;

/** A call that computes a hash, rather than verifying a signature. */
class HashCheck extends DataFlow::CallNode {
  HashCheck() {
    this.getAName() = ["Get-FileHash", "gfh", "certutil", "certutil.exe", "ComputeHash"]
  }

  /** Gets the path of the file whose contents are hashed. */
  DataFlow::Node getHashedFile() {
    this.getAName() = ["Get-FileHash", "gfh"] and
    result = [this.getNamedArgument(["path", "literalpath"]), this.getPositionalArgument(0)]
    or
    this.getAName() = ["certutil", "certutil.exe"] and
    result = this.getNamedArgument("hashfile")
    or
    this.getAName() = "ComputeHash" and
    not exists(this.getArgument(1)) and
    exists(DataFlow::CallNode read |
      read.getAName() = ["ReadAllBytes", "OpenRead"] and
      DataFlow::localFlow(read, this.getArgument(0)) and
      result = read.getArgument(0)
    )
  }

  /** Gets the computed digest, excluding unrelated properties of a hash object. */
  DataFlow::Node getDigest() {
    this.getAName() = ["Get-FileHash", "gfh"] and
    exists(MemberExpr member, DataFlow::Node qualifier |
      member.memberNameMatches("Hash") and
      qualifier.asExpr().getExpr() = member.getQualifier() and
      DataFlow::localFlow(this, qualifier) and
      result.asExpr().getExpr() = member
    )
    or
    this.getAName() = ["certutil", "certutil.exe", "ComputeHash"] and
    result = this
  }
}

/** Holds if a static method is invoked on the given .NET type. */
bindingset[type]
predicate isStaticCall(DataFlow::CallNode call, string type) {
  call.getQualifier().asExpr().getExpr().(TypeNameExpr).getPossiblyQualifiedName() =
    type.toLowerCase()
}

/** Gets a cmdlet's source file, without accepting unrelated arguments as files. */
DataFlow::Node getFileArgument(DataFlow::CallNode call) {
  result = call.getNamedArgument("literalpath")
  or
  not call.hasNamedArgument("literalpath") and
  result = getArgument(call, "path", 0)
}

/** A read of file contents, not a use of the path string as file contents. */
class FileRead extends DataFlow::CallNode {
  FileRead() {
    this.getAName() = ["Get-Content", "gc", "cat", "type"]
    or
    this.getAName() = ["ReadAllBytes", "ReadAllText", "OpenRead"] and
    isStaticCall(this, ["System.IO.File", "IO.File"])
  }

  DataFlow::Node getFile() {
    this.asExpr().getExpr() instanceof InvokeMemberExpr and result = this.getArgument(0)
    or
    not this.asExpr().getExpr() instanceof InvokeMemberExpr and result = getFileArgument(this)
    or
    // Unknown switch binding currently attaches a following positional path to -Raw.
    this.getAName() = ["Get-Content", "gc", "cat", "type"] and
    not exists(getFileArgument(this)) and
    result = this.getNamedArgument("raw")
  }
}

/** A file-preserving copy, move, or rename. */
class FileTransfer extends DataFlow::CallNode {
  FileTransfer() {
    this.getAName() =
      [
        "Copy-Item", "cp", "copy", "cpi", "Move-Item", "mv", "move", "mi", "Rename-Item", "ren",
        "rni"
      ]
  }

  DataFlow::Node getInput() { result = getFileArgument(this) }

  DataFlow::Node getOutput() {
    not this.getAName() = ["Rename-Item", "ren", "rni"] and
    result = getArgument(this, "destination", 1)
    or
    this.hasNamedArgument("passthru") and
    exists(MemberExpr member, DataFlow::Node receiver |
      member.memberNameMatches("FullName") and
      receiver.asExpr().getExpr() = member.getQualifier() and
      DataFlow::localFlow(this, receiver) and
      result.asExpr().getExpr() = member
    )
  }

  predicate removesInput() {
    this.getAName() = ["Move-Item", "mv", "move", "mi", "Rename-Item", "ren", "rni"]
  }
}

/** An overwrite of a file with content from an expression or pipeline. */
class FileWrite extends DataFlow::CallNode {
  FileWrite() {
    this.getAName() = ["Set-Content", "sc"]
    or
    this.getAName() = "Out-File" and not this.hasNamedArgument("append")
    or
    this.getAName() = ["WriteAllBytes", "WriteAllText"] and
    isStaticCall(this, ["System.IO.File", "IO.File"])
  }

  DataFlow::Node getFile() {
    this.getAName() = ["Set-Content", "sc"] and result = getFileArgument(this)
    or
    this.getAName() = "Out-File" and result = getArgument(this, "filepath", 0)
    or
    this.asExpr().getExpr() instanceof InvokeMemberExpr and result = this.getArgument(0)
  }

  DataFlow::Node getContent() {
    this.getAName() = ["Set-Content", "sc"] and
    result = [getArgument(this, "value", 1), getPipelineInput(this)]
    or
    this.getAName() = "Out-File" and
    result = [this.getNamedArgument("inputobject"), getPipelineInput(this)]
    or
    this.asExpr().getExpr() instanceof InvokeMemberExpr and result = this.getArgument(1)
  }
}

/** An extraction operation. Extraction alone is deliberately not an execution sink. */
class ArchiveExtraction extends DataFlow::CallNode {
  ArchiveExtraction() {
    this.getAName() = "Expand-Archive"
    or
    this.getAName() = "ExtractToDirectory" and
    isStaticCall(this, ["System.IO.Compression.ZipFile", "IO.Compression.ZipFile"])
  }

  DataFlow::Node getFile() {
    this.getAName() = "Expand-Archive" and result = getFileArgument(this)
    or
    this.getAName() = "ExtractToDirectory" and result = this.getArgument(0)
  }

  DataFlow::Node getDirectory() {
    this.getAName() = "Expand-Archive" and result = getArgument(this, "destinationpath", 1)
    or
    this.getAName() = "ExtractToDirectory" and result = this.getArgument(1)
  }
}

/** A path constructed under a directory using a fixed, non-traversing relative name. */
class ChildPath extends DataFlow::CallNode {
  ChildPath() {
    this.getAName() = "Join-Path"
    or
    this.getAName() = "Combine" and isStaticCall(this, ["System.IO.Path", "IO.Path"])
  }

  DataFlow::Node getDirectory() {
    this.getAName() = "Join-Path" and result = getArgument(this, "path", 0)
    or
    this.getAName() = "Combine" and result = this.getArgument(0)
  }

  DataFlow::Node getChild() {
    this.getAName() = "Join-Path" and
    not this.hasNamedArgument("additionalchildpath") and
    not exists(this.getPositionalArgument(2)) and
    result = getArgument(this, "childpath", 1)
    or
    this.getAName() = "Combine" and
    not exists(this.getArgument(2)) and
    result = this.getArgument(1)
  }

  predicate isRelative() {
    exists(string child |
      child = this.getChild().asExpr().getValue().asString() and
      child != "" and
      not child.matches(["/%", "\\%", "%:%", "%..%"])
    )
  }
}

/** A use that executes downloaded code, rather than merely retrieving or unpacking it. */
predicate isExecutablePath(DataFlow::Node node) {
  exists(DataFlow::Node literal, string path |
    DataFlow::localFlow(literal, node) and
    path =
      [
        literal.asExpr().getValue().asString(),
        literal.asExpr().getExpr().(ExpandableStringExpr).getUnexpandedValue()
      ].toLowerCase() and
    path.matches(["%.exe", "%.com", "%.cmd", "%.bat", "%.msi"])
  )
  or
  exists(ChildPath path | DataFlow::localFlow(path, node) and isExecutablePath(path.getChild()))
}

class CodeExecution extends DataFlow::CallNode {
  CodeExecution() {
    this instanceof DataFlow::CallOperatorNode or
    this instanceof DataFlow::DotSourcingOperatorNode or
    this.getAName() =
      [
        "Import-Module", "ipmo", "Start-Process", "saps", "start", "Add-Type", "LoadFrom",
        "LoadFile", "powershell", "powershell.exe", "pwsh", "pwsh.exe", "msiexec", "msiexec.exe",
        "Invoke-Expression", "iex", "Load"
      ]
  }

  DataFlow::Node getFile() {
    this instanceof DataFlow::CallOperatorNode and
    result = this.(DataFlow::CallOperatorNode).getCommand()
    or
    this instanceof DataFlow::DotSourcingOperatorNode and
    result = this.(DataFlow::DotSourcingOperatorNode).getCommand()
    or
    this.getAName() = ["Import-Module", "ipmo"] and result = getArgument(this, "name", 0)
    or
    this.getAName() = ["Start-Process", "saps", "start"] and
    result = getArgument(this, "filepath", 0) and
    isExecutablePath(result)
    or
    this.getAName() = "Add-Type" and result = this.getNamedArgument(["path", "literalpath"])
    or
    this.getAName() = ["LoadFrom", "LoadFile"] and
    isStaticCall(this, ["System.Reflection.Assembly", "Reflection.Assembly"]) and
    result = this.getArgument(0)
    or
    this.getAName() = ["powershell", "powershell.exe", "pwsh", "pwsh.exe"] and
    result = this.getNamedArgument("file")
    or
    this.getAName() = ["msiexec", "msiexec.exe"] and
    exists(int i |
      this.getPositionalArgument(i).asExpr().getValue().asString().toLowerCase() =
        ["/i", "/package"] and
      result = this.getPositionalArgument(i + 1)
    )
    or
    this.getAName() = ["Start-Process", "saps", "start"] and
    exists(DataFlow::Node arguments, ArrayLiteral array, string host, string option, int i |
      hasFixedValue(getArgument(this, "filepath", 0), host) and
      DataFlow::localFlow(arguments, getArgument(this, "argumentlist", 1)) and
      arguments.asExpr().getExpr() = array and
      option = array.getExpr(i).getValue().asString().toLowerCase() and
      (
        host.toLowerCase() = ["msiexec", "msiexec.exe"] and option = ["/i", "/package"]
        or
        host.toLowerCase() = ["powershell", "powershell.exe", "pwsh", "pwsh.exe"] and
        option = "-file"
      ) and
      result.asExpr().getExpr() = array.getExpr(i + 1)
    )
  }

  DataFlow::Node getContent() {
    this.getAName() = ["Invoke-Expression", "iex"] and
    result = [getArgument(this, "command", 0), getPipelineInput(this)]
    or
    this.getAName() = "Load" and
    isStaticCall(this, ["System.Reflection.Assembly", "Reflection.Assembly"]) and
    result = this.getArgument(0)
    or
    this instanceof DataFlow::CallOperatorNode and
    result = this.(DataFlow::CallOperatorNode).getCommand() and
    exists(DataFlow::CallNode create |
      create.getAName() = "Create" and
      isStaticCall(create, ["System.Management.Automation.ScriptBlock", "ScriptBlock"]) and
      DataFlow::localFlow(create, result)
    )
  }
}

module FileConf implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) {
    source = any(DownloadCall d).getOutFileArg() or
    source = any(FileTransfer t).getOutput() or
    source = any(FileWrite w).getFile() or
    source = any(ArchiveExtraction e).getDirectory() or
    source instanceof ChildPath
  }

  predicate isSink(DataFlow::Node sink) {
    sink = any(DataFlow::CallNode c).getAnArgument() or
    sink = any(CodeExecution c).getFile() or
    sink = any(FileTransfer t).getOutput() or
    sink = any(ChildPath p).getDirectory()
  }
}

// File names retain their value; arbitrary string taint is not file identity.
module FileFlow = DataFlow::Global<FileConf>;

predicate sameFile(DataFlow::Node file, DataFlow::Node other) {
  DataFlow::localFlow(file, other)
  or
  FileFlow::flow(file, other)
  or
  exists(string path |
    path = file.asExpr().getValue().asString() and
    path != "" and
    path = other.asExpr().getValue().asString() and
    file.asExpr().getScope() = other.asExpr().getScope()
  )
  or
  exists(ChildPath first, ChildPath second, string child |
    first.isRelative() and
    second.isRelative() and
    DataFlow::localFlow(first, file) and
    DataFlow::localFlow(second, other) and
    hasFixedValue(first.getChild(), child) and
    hasFixedValue(second.getChild(), child) and
    (
      sameFile(first.getDirectory(), second.getDirectory())
      or
      sameFile(second.getDirectory(), first.getDirectory())
    )
  )
}

predicate archiveMember(DataFlow::Node directory, DataFlow::Node member) {
  exists(ChildPath path |
    path.isRelative() and
    member = path and
    (sameFile(directory, path.getDirectory()) or archiveMember(directory, path.getDirectory()))
  )
}

/** Holds if `first` dominates and is evaluated before `second`. */
predicate precedes(CfgNode first, CfgNode second) {
  first.getBasicBlock().strictlyDominates(second.getBasicBlock())
  or
  exists(int i, int j |
    first = first.getBasicBlock().getNode(i) and
    second = first.getBasicBlock().getNode(j) and
    i < j
  )
}

/** Holds if `expected` is a fixed, complete hexadecimal digest. */
predicate isExpectedDigest(DataFlow::Node expected) {
  exists(DataFlow::LocalSourceNode constant | DataFlow::localFlow(constant, expected)) and
  forall(DataFlow::LocalSourceNode constant | DataFlow::localFlow(constant, expected) |
    exists(string digest |
      digest = constant.asExpr().getValue().asString() and
      digest.regexpMatch("[0-9a-fA-F]+") and
      digest.length() = [32, 40, 64, 96, 128]
    )
  )
}

/** A value-preserving step or a lossless conversion of a digest to hexadecimal text. */
predicate digestStep(DataFlow::Node input, DataFlow::Node output) {
  DataFlow::localFlowStep(input, output)
  or
  exists(DataFlow::CallNode format, TypeNameExpr type |
    format.getQualifier().asExpr().getExpr() = type and
    (
      type.getPossiblyQualifiedName() = ["System.BitConverter", "BitConverter"].toLowerCase() and
      format.getAName() = "ToString"
      or
      type.getPossiblyQualifiedName() = ["System.Convert", "Convert"].toLowerCase() and
      format.getAName() = "ToHexString"
    ) and
    input = format.getArgument(0) and
    not exists(format.getArgument(1)) and
    output = format
  )
  or
  exists(DataFlow::CallNode format |
    input = format.getQualifier() and
    output = format and
    (
      format.getAName() = "Replace" and
      format.getArgument(0).asExpr().getValue().asString() = "-" and
      format.getArgument(1).asExpr().getValue().asString() = ""
      or
      format.getAName() = ["ToLower", "ToUpper", "ToLowerInvariant", "ToUpperInvariant"] and
      not exists(format.getAnArgument())
    )
  )
}

/** A control-flow step that does not continue past an uncaught throw or exit. */
predicate continuingStep(CfgNode node, CfgNode next) {
  next = node.getASuccessor() and
  // The CFG currently propagates the normal completion of a throw's operand.
  not exists(Stmt abort |
    (abort instanceof ThrowStmt or abort instanceof ExitStmt or abort instanceof ReturnStmt) and
    node.getAstNode().getParent*() = abort and
    not next.getAstNode().getParent*() = abort and
    not abort.getParent+() instanceof TryStmt and
    not exists(TrapStmt trap | abort.getParent+() = trap.getParent())
  )
}

/** Holds if the entire compared value is derived from this digest, not a bypass value. */
predicate isDigestValue(DataFlow::Node digest, DataFlow::Node actual) {
  digestStep*(digest, actual) and
  forall(DataFlow::LocalSourceNode origin | DataFlow::localFlow(origin, actual) |
    digestStep*(digest, origin)
  )
}

/** Facts established by a Boolean expression, independently of short-circuit CFG support. */
predicate conditionImplies(Expr condition, boolean outcome, Expr tested, boolean required) {
  condition = tested and required = [true, false] and outcome = required
  or
  conditionImplies(condition.(ParenExpr).getExpr(), outcome, tested, required)
  or
  exists(boolean inner |
    (
      outcome = true and inner = false
      or
      outcome = false and inner = true
    ) and
    conditionImplies(condition.(NotExpr).getOperand(), inner, tested, required)
  )
  or
  outcome = true and
  conditionImplies(condition.(LogicalAndExpr).getAnOperand(), true, tested, required)
  or
  outcome = false and
  conditionImplies(condition.(LogicalOrExpr).getAnOperand(), false, tested, required)
}

predicate hashGuard(HashCheck check, ExprCfgNode guard, BooleanSuccessor success) {
  exists(ComparisonExpr comparison, DataFlow::Node actual, DataFlow::Node expected |
    actual.asExpr().getExpr() = comparison.getAnOperand() and
    expected.asExpr().getExpr() = comparison.getAnOperand() and
    actual != expected and
    isDigestValue(check.getDigest(), actual) and
    isExpectedDigest(expected) and
    conditionImplies(guard.getExpr(), success.getValue(), comparison, equalityMatchesOn(comparison)) and
    precedes(check.getCfgNode(), guard)
  )
}

/** Gets a property read from a particular value, including through local aliases. */
bindingset[name]
DataFlow::Node getProperty(DataFlow::Node value, string name) {
  exists(MemberExpr member, DataFlow::Node receiver |
    member.memberNameMatches(name) and
    receiver.asExpr().getExpr() = member.getQualifier() and
    DataFlow::localFlow(value, receiver) and
    result.asExpr().getExpr() = member
  )
}

predicate hasFixedValue(DataFlow::Node value, string expected) {
  exists(DataFlow::LocalSourceNode origin |
    DataFlow::localFlow(origin, value) and expected = origin.asExpr().getValue().asString()
  ) and
  forall(DataFlow::LocalSourceNode origin | DataFlow::localFlow(origin, value) |
    origin.asExpr().getValue().asString() = expected
  )
}

boolean equalityMatchesOn(ComparisonExpr comparison) {
  (comparison instanceof EqExpr or comparison instanceof CEqExpr) and
  result = true
  or
  (comparison instanceof NeExpr or comparison instanceof CNeExpr) and
  result = false
}

/** A comparison of a particular value against an exact fixed string. */
predicate stringGuard(
  DataFlow::Node value, string expected, ExprCfgNode guard, BooleanSuccessor success
) {
  exists(ComparisonExpr comparison, DataFlow::Node actual, DataFlow::Node other |
    actual.asExpr().getExpr() = comparison.getAnOperand() and
    other.asExpr().getExpr() = comparison.getAnOperand() and
    actual != other and
    isDigestValue(value, actual) and
    hasFixedValue(other, expected) and
    guard.getExpr() = comparison and
    success.getValue() = equalityMatchesOn(comparison)
  )
}

/** Holds if reaching `target` requires passing this guard's successful branch. */
predicate requiresSuccess(ExprCfgNode guard, BooleanSuccessor success, CfgNode target) {
  precedes(guard, target) and
  exists(guard.getASuccessor(success)) and
  not exists(CfgNode failure |
    failure = guard.getASuccessor(success.getDual()) and continuingStep*(failure, target)
  )
}

/** A signature must establish both validity and the expected publisher's certificate. */
predicate authenticodeGuard(DataFlow::CallNode check, ExprCfgNode guard, BooleanSuccessor success) {
  check.getAName() = "Get-AuthenticodeSignature" and
  exists(
    ExprCfgNode status, ExprCfgNode signer, BooleanSuccessor statusOk, BooleanSuccessor signerOk,
    DataFlow::Node fingerprint, ComparisonExpr comparison
  |
    stringGuard(getProperty(check, "Status"), "Valid", status, statusOk) and
    fingerprint = getProperty(getProperty(check, "SignerCertificate"), "Thumbprint") and
    signer.getExpr() = comparison and
    exists(DataFlow::Node actual, DataFlow::Node expected |
      actual.asExpr().getExpr() = comparison.getAnOperand() and
      expected.asExpr().getExpr() = comparison.getAnOperand() and
      actual != expected and
      isDigestValue(fingerprint, actual) and
      isExpectedDigest(expected)
    ) and
    signerOk.getValue() = equalityMatchesOn(comparison) and
    precedes(check.getCfgNode(), status) and
    precedes(check.getCfgNode(), signer) and
    (
      requiresSuccess(status, statusOk, signer) and guard = signer and success = signerOk
      or
      requiresSuccess(signer, signerOk, status) and guard = status and success = statusOk
      or
      conditionImplies(guard.getExpr(), success.getValue(), status.getExpr(), statusOk.getValue()) and
      conditionImplies(guard.getExpr(), success.getValue(), signer.getExpr(), signerOk.getValue())
    )
  )
}

/** Gets the value of a native command's long option, not a PowerShell parameter. */
bindingset[name]
DataFlow::Node getNativeOption(DataFlow::CallNode call, string name) {
  not call.getPositionalArgument(_).asExpr().getValue().asString().matches("--" + name + "=%") and
  (
    result = call.getNamedArgument("-" + name) and
    not call.getPositionalArgument(_).asExpr().getValue().asString() = "--" + name
    or
    not call.hasNamedArgument("-" + name) and
    exists(int i |
      i =
        unique(int index |
          call.getPositionalArgument(index).asExpr().getValue().asString() = "--" + name
        |
          index
        ) and
      result = call.getPositionalArgument(i + 1)
    )
  )
}

bindingset[name]
predicate hasNativeOption(DataFlow::CallNode call, string name) {
  call.hasNamedArgument("-" + name)
  or
  call.getPositionalArgument(_).asExpr().getValue().asString() = "--" + name
  or
  call.getPositionalArgument(_).asExpr().getValue().asString().matches("--" + name + "=%")
}

/** Gets an operand, excluding long options and their following values. */
bindingset[position]
DataFlow::Node getNativeOperand(DataFlow::CallNode call, int position) {
  result =
    rank[position + 1](DataFlow::Node operand, int i |
      operand = call.getPositionalArgument(i) and
      not operand.asExpr().getValue().asString().matches("--%") and
      not call.getPositionalArgument(i - 1).asExpr().getValue().asString().matches("--%")
    |
      operand order by i
    )
}

/** Native verification policies that establish the expected signer, not just any valid signature. */
class NativeSignatureCheck extends DataFlow::CallNode {
  NativeSignatureCheck() { this.getAName() = ["gpg", "gpg.exe", "cosign", "cosign.exe"] }

  DataFlow::Node getFile() {
    this.getAName() = ["gpg", "gpg.exe"] and
    exists(string fingerprint |
      hasFixedValue(getNativeOption(this, "assert-signer"), fingerprint) and
      fingerprint.regexpMatch("[0-9a-fA-F]+") and
      fingerprint.length() = [40, 64]
    ) and
    exists(getNativeOption(this, "verify")) and
    not exists(getNativeOperand(this, 1)) and
    (
      result = getNativeOperand(this, 0)
      or
      not exists(getNativeOperand(this, 0)) and result = getNativeOption(this, "verify")
    )
    or
    this.getAName() = ["cosign", "cosign.exe"] and
    getNativeOperand(this, 0).asExpr().getValue().asString() = "verify-blob" and
    not exists(getNativeOperand(this, 2)) and
    exists(string identity, string issuer |
      hasFixedValue(getNativeOption(this, "certificate-identity"), identity) and
      identity != "" and
      hasFixedValue(getNativeOption(this, "certificate-oidc-issuer"), issuer) and
      issuer.matches("https://%")
    ) and
    not hasNativeOption(this,
      [
        "key", "trusted-root", "certificate-chain", "ca-roots", "ca-intermediates",
        "insecure-ignore-sct", "insecure-ignore-tlog", "certificate-identity-regexp",
        "certificate-oidc-issuer-regexp"
      ]) and
    result = getNativeOperand(this, 1)
  }
}

/** Only an unmodified exit code from this verifier can establish successful verification. */
predicate nativeSignatureGuard(
  NativeSignatureCheck check, ExprCfgNode guard, BooleanSuccessor success
) {
  exists(ComparisonExpr comparison, Expr actual, Expr zero |
    actual = comparison.getAnOperand() and
    zero = comparison.getAnOperand() and
    actual != zero and
    actual.(AutomaticVariable).getLowerCaseName() = "lastexitcode" and
    zero.getValue().asInt() = 0 and
    conditionImplies(guard.getExpr(), success.getValue(), comparison, equalityMatchesOn(comparison)) and
    precedes(check.getCfgNode(), guard) and
    not exists(DataFlow::CallNode intervening |
      intervening != check and
      continuingStep+(check.getCfgNode(), intervening.getCfgNode()) and
      continuingStep+(intervening.getCfgNode(), guard)
    )
  )
}

/** An overwrite or removal stops tracking the previous downloaded file version. */
predicate overwritesFile(DataFlow::Node file, CfgNode node) {
  exists(DownloadCall download |
    node = download.getCfgNode() and sameFile(file, download.getOutFileArg())
  )
  or
  exists(FileWrite write | node = write.getCfgNode() and sameFile(file, write.getFile()))
  or
  exists(FileTransfer transfer |
    node = transfer.getCfgNode() and
    (
      transfer.removesInput() and sameFile(file, transfer.getInput())
      or
      sameFile(file, transfer.getOutput())
    )
  )
  or
  exists(DataFlow::CallNode remove |
    node = remove.getCfgNode() and
    (
      remove.getAName() = ["Remove-Item", "ri", "rm", "del"] and
      sameFile(file, getFileArgument(remove))
      or
      // Relative path identity cannot be assumed across a working-directory change.
      remove.getAName() = ["Set-Location", "cd", "chdir", "sl", "Push-Location", "Pop-Location"]
    )
  )
}

predicate producedFile(DataFlow::CallNode producer, DataFlow::Node file) {
  file = producer.(DownloadCall).getOutFileArg() or
  file = producer.(FileTransfer).getOutput() or
  file = producer.(FileWrite).getFile() or
  file = producer.(FileRead).getFile() or
  archiveMember(producer.(ArchiveExtraction).getDirectory(), file)
}

/** Reaches a node from a specific producer while the same file version is present. */
predicate producedFileReaches(DataFlow::CallNode producer, DataFlow::Node file, CfgNode target) {
  producedFile(producer, file) and continuingStep(producer.getCfgNode(), target)
  or
  exists(CfgNode node |
    producedFileReaches(producer, file, node) and
    not overwritesFile(file, node) and
    continuingStep(node, target)
  )
}

/** A check of an unchanged original also validates the copy made from it. */
predicate checksProducedFile(
  DataFlow::CallNode producer, DataFlow::Node file, DataFlow::Node checked, CfgNode check
) {
  sameFile(file, checked) and producedFileReaches(producer, file, check)
  or
  exists(FileTransfer copy |
    producer = copy and
    not copy.removesInput() and
    file = copy.getOutput() and
    sameFile(copy.getInput(), checked) and
    precedes(copy.getCfgNode(), check) and
    not exists(CfgNode changed |
      overwritesFile(copy.getInput(), changed) and
      continuingStep+(copy.getCfgNode(), changed) and
      continuingStep*(changed, check)
    )
  )
}

/** Only this file version, checked after it was produced, can validate a path. */
predicate fileVerificationEdge(
  DataFlow::CallNode producer, DataFlow::Node file, CfgNode guard, CfgNode next
) {
  exists(HashCheck check, ExprCfgNode condition, BooleanSuccessor success |
    checksProducedFile(producer, file, check.getHashedFile(), check.getHashedFile().asExpr()) and
    hashGuard(check, condition, success) and
    guard = condition and
    next = condition.getASuccessor(success) and
    not next = condition.getASuccessor(success.getDual())
  )
  or
  exists(DataFlow::CallNode check, ExprCfgNode condition, BooleanSuccessor success |
    authenticodeGuard(check, condition, success) and
    checksProducedFile(producer, file, getArgument(check, "filepath", 0), check.getCfgNode()) and
    guard = condition and
    next = condition.getASuccessor(success) and
    not next = condition.getASuccessor(success.getDual())
  )
  or
  exists(NativeSignatureCheck check, ExprCfgNode condition, BooleanSuccessor success |
    checksProducedFile(producer, file, check.getFile(), check.getCfgNode()) and
    nativeSignatureGuard(check, condition, success) and
    guard = condition and
    next = condition.getASuccessor(success) and
    not next = condition.getASuccessor(success.getDual())
  )
}

/** An existential path to a particular use, excluding only successful verification edges. */
predicate unverifiedFileReachable(DataFlow::CallNode producer, DataFlow::Node file, CfgNode target) {
  producedFile(producer, file) and continuingStep(producer.getCfgNode(), target)
  or
  exists(CfgNode node |
    unverifiedFileReachable(producer, file, node) and
    not overwritesFile(file, node) and
    continuingStep(node, target) and
    not fileVerificationEdge(producer, file, node, target)
  )
}

predicate unverifiedFileUse(
  DataFlow::CallNode producer, DataFlow::Node file, DataFlow::CallNode use, DataFlow::Node input
) {
  sameFile(file, input) and
  unverifiedFileReachable(producer, file, use.getCfgNode())
}

/** Extra content steps represent bytes/text, never a path string becoming its file's bytes. */
predicate contentStep(DataFlow::Node input, DataFlow::Node output) {
  output = getProperty(input, ["Content", "Result"])
  or
  exists(DataFlow::CallNode decode |
    decode.getAName() = "GetString" and
    decode
        .getQualifier()
        .asExpr()
        .getExpr()
        .(MemberExpr)
        .getQualifier()
        .(TypeNameExpr)
        .getPossiblyQualifiedName() = ["System.Text.Encoding", "Text.Encoding"].toLowerCase() and
    input = decode.getArgument(0) and
    output = decode
  )
  or
  exists(DataFlow::CallNode create |
    create.getAName() = "Create" and
    isStaticCall(create, ["System.Management.Automation.ScriptBlock", "ScriptBlock"]) and
    input = create.getArgument(0) and
    output = create
  )
}

module ContentConf implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) {
    source = any(DownloadCall d).getContent() or source instanceof FileRead
  }

  predicate isSink(DataFlow::Node sink) {
    sink = any(CodeExecution use).getContent() or
    sink = any(FileWrite write).getContent() or
    sink = any(HashCheck check).getArgument(0)
  }

  predicate isAdditionalFlowStep(DataFlow::Node input, DataFlow::Node output) {
    contentStep(input, output)
  }
}

module ContentFlow = TaintTracking::Global<ContentConf>;

predicate unverifiedContentReachable(
  DataFlow::CallNode producer, DataFlow::Node content, CfgNode target
) {
  (
    content = producer.(DownloadCall).getContent()
    or
    producer instanceof FileRead and content = producer
  ) and
  continuingStep(producer.getCfgNode(), target)
  or
  exists(CfgNode node |
    unverifiedContentReachable(producer, content, node) and
    continuingStep(node, target) and
    not (
      producer instanceof FileRead and
      fileVerificationEdge(producer, producer.(FileRead).getFile(), node, target)
    ) and
    not exists(HashCheck check, ExprCfgNode guard, BooleanSuccessor success |
      check.getAName() = "ComputeHash" and
      not exists(check.getArgument(1)) and
      DataFlow::localFlow(content, check.getArgument(0)) and
      hashGuard(check, guard, success) and
      node = guard and
      target = guard.getASuccessor(success) and
      not target = guard.getASuccessor(success.getDual())
    )
  )
}

predicate unverifiedContentUse(
  DataFlow::CallNode producer, DataFlow::Node content, DataFlow::CallNode use, DataFlow::Node input
) {
  ContentFlow::flow(content, input) and
  unverifiedContentReachable(producer, content, use.getCfgNode())
}

predicate pinnedHttpsUrl(DownloadCall download) {
  exists(
    ComparisonExpr comparison, ExprCfgNode guard, BooleanSuccessor success, DataFlow::Node actual,
    DataFlow::Node expected, string url
  |
    actual.asExpr().getExpr() = comparison.getAnOperand() and
    expected.asExpr().getExpr() = comparison.getAnOperand() and
    actual != expected and
    DataFlow::localFlow(actual, download.getUrl()) and
    hasFixedValue(expected, url) and
    url.toLowerCase().matches("https://%") and
    conditionImplies(guard.getExpr(), success.getValue(), comparison, equalityMatchesOn(comparison)) and
    requiresSuccess(guard, success, download.getCfgNode())
  )
}

/** The strict query needs evidence of a weaker trust boundary than a fixed HTTPS origin. */
string getOriginReason(DownloadCall download) {
  not pinnedHttpsUrl(download) and
  (
    HttpOriginFlow::flow(_, download.getUrl()) and result = "over unencrypted HTTP"
    or
    not HttpOriginFlow::flow(_, download.getUrl()) and
    RemoteOriginFlow::flow(_, download.getUrl()) and
    result = "from a remotely controlled URL"
  )
}

/** An unverified materialized file, preserving content through modeled filesystem operations. */
predicate unverifiedFile(DownloadCall download, DataFlow::CallNode producer, DataFlow::Node file) {
  exists(getOriginReason(download)) and
  producer = download and
  file = download.getOutFileArg()
  or
  exists(FileTransfer transfer, DataFlow::CallNode previous, DataFlow::Node source |
    unverifiedFile(download, previous, source) and
    unverifiedFileUse(previous, source, transfer, transfer.getInput()) and
    producer = transfer and
    file = transfer.getOutput()
  )
  or
  exists(ArchiveExtraction extract, DataFlow::CallNode previous, DataFlow::Node archive |
    unverifiedFile(download, previous, archive) and
    unverifiedFileUse(previous, archive, extract, extract.getFile()) and
    producer = extract and
    archiveMember(extract.getDirectory(), file)
  )
  or
  exists(FileWrite write, DataFlow::CallNode previous, DataFlow::Node content |
    unverifiedContent(download, previous, content) and
    unverifiedContentUse(previous, content, write, write.getContent()) and
    producer = write and
    file = write.getFile()
  )
}

predicate unverifiedContent(
  DownloadCall download, DataFlow::CallNode producer, DataFlow::Node content
) {
  exists(getOriginReason(download)) and
  producer = download and
  content = download.getContent()
  or
  exists(FileRead read, DataFlow::CallNode previous, DataFlow::Node file |
    unverifiedFile(download, previous, file) and
    unverifiedFileUse(previous, file, read, read.getFile()) and
    producer = read and
    content = read
  )
}

from DownloadCall download, CodeExecution use, DataFlow::CallNode producer, DataFlow::Node artifact
where
  unverifiedFile(download, producer, artifact) and
  unverifiedFileUse(producer, artifact, use, use.getFile())
  or
  unverifiedContent(download, producer, artifact) and
  unverifiedContentUse(producer, artifact, use, use.getContent())
select download,
  "This download " + getOriginReason(download) +
    " reaches $@ without an effective integrity or expected-publisher check.", use,
  "code execution or loading"
