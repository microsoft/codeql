import csharp
import SsrfBarrierHost

/**
 * Holds for call of `Microsoft.Azure.Storage.NameValidator` validation methods
 * Example: `NameValidator.ValidateBlobName(blobName)`
 */
class NameValidatorBarrier extends Barrier {
  NameValidatorBarrier() {
    exists(MethodCall mc, Method m, string s |
      this.asExpr() = mc.getAnArgument() and
      m = mc.getTarget() and
      m.hasFullyQualifiedName("Microsoft.Azure.Storage.NameValidator", s) and
      s in ["ValidateBlobName", "ValidateContainerName", "ValidateQueueName"]
    )
  }
}

/**
 * Holds if we detect Scheme and Host validation https://aka.ms/ssrf/sdl
 */
private class RequestForgeryBarrier extends Barrier {
  RequestForgeryBarrier() { doesNodeFlowToSchemaAndHostSanitizer(this.asExpr()) }
}

/**
 * Holds if the `node` is a property read on a `Uri` object
 *
 * Example: `myUri.Host`
 */
private predicate isUriHostNode(DataFlow::Node node) {
  exists(Property p, PropertyRead pr |
    pr = node.asExpr() and
    p.hasFullyQualifiedName("System.Uri", "Host") and
    p.getAnAccess() = pr
  )
}

/**
 * Holds if the `Uri` variable `v` has beeen checked (`co`) for the schema to validate HTTPS
 *
 * Example: `if (myUri.Scheme == Uri.UriSchemeHttps) { ... }`
 */
private predicate uriVariableHasBeenCheckedForUriSchemeHttps(
  Variable v, DataFlow::Node node, ComparisonOperation co
) {
  exists(Field ec, Property p, PropertyRead pr, Expr e |
    ec.hasFullyQualifiedName("System.Uri", "UriSchemeHttps") and
    p.hasFullyQualifiedName("System.Uri", "Scheme") and
    p.getAnAccess() = pr and
    co.getAnOperand() = pr and
    co.getAnOperand() = ec.getAnAccess() and
    v.getAnAccess() = pr.getQualifier() and
    v.getType() instanceof SystemUriClass and
    e.getType() instanceof SystemUriClass and
    e = co.getAChild*() and
    e = node.asExpr()
  )
}

/**
 * Holds if the `Uri` variable `v` is used in a verification against a list of allowed domains using `EndsWith`
 *
 * Example:
 *  `Uri myUri = new Uri("http://www.subdomain.something.com/");
 *   List<string> hostList = new List<string> { "something.com", ".something.com"};
 *   if (myUri.Host.EndsWith(hostList[0])) { ... }`
 */
private predicate uriVariableHostHasBeenUsedInASelectionStmt(
  Variable v, DataFlow::Node node, DataFlow::Node source
) {
  exists(PropertyRead pr, SelectionStmt ifstmt, Expr e |
    e = node.asExpr() and
    pr = source.asExpr() and
    ifstmt.getCondition().getAChild*() = node.asExpr() and
    DataFlow::localFlow(source, node) and
    isUriHostNode(source) and
    v.getAnAccess() = pr.getQualifier()
  ) and
  exists(MethodCall call |
    call.getQualifier() = node.asExpr() and
    call.getTarget().hasName("EndsWith")
  )
}

/**
 * Holds if the string literal starts with `.` and
 * it is not an `InterpolatedStringExpr` element
 *
 * Example: `".something.com";`
 */
private predicate isLiteralStartingWithDotAndNotInterpolated(Literal l) {
  l.getValue().length() > 2 and
  l.getValue().regexpMatch("^\\.[^.\\/\\s].*") and
  not l.getParent() instanceof InterpolatedStringInsertExpr
}

/**
 * holds if the `source` is a literal and not an interpolated string
 *
 * Examples:
 * `String s = ".something.com";`
 * or
 * `String s = "";
 *  s = new String(".something.com"); // literal is child of ObjectCreation
 *  if (myUri.Host.EndsWith(s)) { ... }` // source is a VariableAccess of that object
 */
private predicate isAzureDomainNode(DataFlow::Node source) {
  isLiteralStartingWithDotAndNotInterpolated(source.asExpr())
  or
  exists(Variable v, ObjectCreation oc, AssignExpr ae, Literal l |
    source.asExpr() = v.getAnAccess() and
    ae.getLValue() = v.getAnAccess() and
    ae.getRValue() = oc and
    oc.getAChild*() = l and
    isLiteralStartingWithDotAndNotInterpolated(l)
  )
}

/**
 * Holds if a non-interpolated string literal flows to expression `e`
 */
private predicate flowsFromAzureDomainString(Expr e) {
  exists(DataFlow::Node source, DataFlow::Node sink |
    e = sink.asExpr() and
    isAzureDomainNode(source) and
    DataFlow::localFlow(source, sink)
  )
}

/**
 * Holds if `true` is set to `EnableTenantDiscovery` property
 *
 * Example: `BlobClientOptions blobClientOptions = new BlobClientOptions();
 *           blobClientOptions.EnableTenantDiscovery = true;`
 */
predicate existsTrueFlowsToEnableTenantDiscoveryProperty() {
  exists(BoolLiteral bl, PropertyWrite pw, AssignExpr ae |
    bl.getBoolValue() = true and
    ae.getRValue() = bl and
    ae.getLValue() = pw and
    pw.getProperty().hasName("EnableTenantDiscovery")
  )
}

/**
 * Helper to detect the Scheme and Host sanitizer
 *
 * TODO: example
 */
predicate isSchemaAndHostSanitizerHelper(DataFlow::Node node, Variable v) {
  exists(
    SelectionStmt slStmt, DataFlow::Node sink, DataFlow::Node source, DataFlow::Node node2,
    DataFlow::Node node3, MethodCall tryGetValCall, Method tryGetVal, VariableAccess nodeDictParam,
    Variable v2
  |
    uriVariableHostHasBeenUsedInASelectionStmt(v, sink, source) and
    slStmt.getAChild*() = sink.asExpr() and
    slStmt.getAChild*() = node2.asExpr() and
    tryGetVal.hasName("TryGetValue") and
    tryGetVal.getACall() = tryGetValCall and
    tryGetValCall.getQualifier() = node3.asExpr() and
    flowsFromAzureDomainString(node3.asExpr()) and
    nodeDictParam = tryGetValCall.getArgumentForName("value") and
    v2.getAnAccess() = nodeDictParam and
    exists(MethodCall call |
      call.getQualifier() = node.asExpr() and
      call.getTarget().hasName("EndsWith") and
      v2.getAnAccess() = call.getAnArgument()
    )
  )
}

/**
 * Holds if we detect the Scheme and Host sanitizer
 *
 * TODO: example
 */
predicate isSchemaAndHostSanitizer(DataFlow::Node node, Variable v) {
  isSchemaAndHostSanitizerHelper(node, v) and
  exists(DataFlow::Node node_httpsValidation |
    uriVariableHasBeenCheckedForUriSchemeHttps(v, node_httpsValidation, _)
  |
    node_httpsValidation.getControlFlowNode().getASuccessor*() = node.getControlFlowNode() or
    node_httpsValidation.getControlFlowNode().getAPredecessor*() = node.getControlFlowNode()
  ) and
  not existsTrueFlowsToEnableTenantDiscoveryProperty()
}

/**
 * Dataflow that is used to detect the Scheme and Host sanitizer https://aka.ms/ssrf/sdl
 */
private module SchemaAndHostSanitizerFlowConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) { any() }

  predicate isSink(DataFlow::Node sink) { isSchemaAndHostSanitizer(sink, _) }

  predicate isAdditionalFlowStep(DataFlow::Node node2, DataFlow::Node node1) {
    exists(PropertyCall pc | node1.asExpr() = pc |
      pc.getProperty().hasName("Host") and
      (
        exists(AssignExpr ae |
          ae.getRValue().getAChild*() = pc and
          ae.getLValue().getAChild*() = node2.asExpr()
        )
        or
        exists(LocalVariableDeclAndInitExpr lvd |
          lvd.getRValue().getAChild*() = pc and
          lvd.getAChild*().(Expr).getAControlFlowNode() = node2.getControlFlowNode()
        )
      )
    )
    or
    requestForgeryStep(node2, node1)
    or
    uriCreationStep(node2, node1)
  }
}

module SchemaAndHostSanitizerFlow = DataFlow::Global<SchemaAndHostSanitizerFlowConfig>;

/**
 * Holds when the `UriClass` is created or set
 *
 * Example: `new Uri("https://something.com");`
 */
predicate uriCreationStep(DataFlow::Node pred, DataFlow::Node succ) {
  // propagate to a URI when its host is assigned to
  exists(SystemUriClass uriClass, ObjectCreation oc, DataFlow::Node node |
    uriClass.getAConstructor().getACall() = oc and
    succ.asExpr() = oc and
    node.asExpr() = oc.getArgumentForName("uriString") and
    DataFlow::localFlow(pred, node)
  )
}

/**
 * Holds if we cannot detect a flow to the Scheme and Host sanitizer
 */
predicate doesNodeFlowToSchemaAndHostSanitizer(Expr nodeExpr) {
  exists(SchemaAndHostSanitizerFlow::PathNode node | node.getNode().asExpr() = nodeExpr |
  SchemaAndHostSanitizerFlow::flowPath(node, _)
  )
}

/**
 * Holds if the Node is using `IOption` or other well-known configuration file
 *
 * Examples:
 * Property such as `something.Configuration`
 * Parameter of type `IOption` or `IConfiguration`
 *   In the dataflow, includes `ConnectionStringSecret` property from `options.Value.ConnectionStringSecret`
 * Access dictionary key `config["vaultUrl"]`
 */
predicate isNodeUsingIconfigurationOrIOption(DataFlow::Node source) {
  // property access
  exists(PropertyRead fopRead | fopRead = source.asExpr() |
    fopRead
        .getTarget()
        .getType()
        .(Class)
        .getABaseType*()
        .hasFullyQualifiedName("Microsoft.Extensions.Configuration", "IConfiguration")
  )
  or
  // parameter, including API parameters
  exists(Parameter p | source.asParameter() = p |
    p.getType().(Generic).getUnboundDeclaration().getUndecoratedName() = "IOptions" and
    p.getType()
        .(ValueOrRefType)
        .getNamespace()
        .hasFullyQualifiedName("Microsoft.Extensions", "Options")
    or
    p.getType().hasFullyQualifiedName("Microsoft.Extensions.Configuration", "IConfiguration")
  )
  or
  // access dictionary key
  exists(IndexerCall ic, Variable v, VariableAccess va |
    source.asExpr() = ic and
    not exists(Parameter p | p.getAnAccess() = va) and // prevent duplicate results with parameters
    ic.getQualifier() = va and
    v.getAnAccess() = va and
    (
      v.getType()
          .(Class)
          .getABaseType*()
          .hasFullyQualifiedName("Microsoft.Extensions.Configuration", "IConfiguration")
      or
      v.getType().hasFullyQualifiedName("Microsoft.Extensions.Configuration", "IConfiguration")
      or
      v.getType().(Generic).getUnboundDeclaration().getUndecoratedName() = "IOptions" and
      v.getType()
          .(ValueOrRefType)
          .getNamespace()
          .hasFullyQualifiedName("Microsoft.Extensions", "Options")
    )
  )
}
