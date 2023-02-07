/**
 * Provides a taint tracking configuration for reasoning about unsafe zip extraction.
 */

 import csharp
 import semmle.code.csharp.dataflow.TaintTracking2
 import semmle.code.csharp.dataflow.TaintTracking3
 import semmle.code.csharp.dataflow.TaintTracking4
 import semmle.code.csharp.controlflow.Guards
 import semmle.code.csharp.dataflow.DataFlow::DataFlow::PathGraph
 
 abstract class AbstractSanitizerMethod extends Method { }
 
 class RootSanitizerMethod extends AbstractSanitizerMethod {
   // Alias for String.StartsWith
   RootSanitizerMethod() { this.getQualifiedName() = "System.String.StartsWith" }
 }
 
 abstract class UnsanitizedPathCombiner extends Expr { }
 
 class PathCombinerViaMethodCall extends UnsanitizedPathCombiner {
   PathCombinerViaMethodCall() {
     exists(MethodCall mcPathCombine |
       mcPathCombine.getTarget().hasQualifiedName("System.IO.Path", "Combine") and
       this = mcPathCombine
     )
   }
 }
 
 class PathCombinerViaStringInterpolation extends UnsanitizedPathCombiner {
   PathCombinerViaStringInterpolation() { exists(InterpolatedStringExpr e | this = e) }
 }
 
 class PathCombinerViaStringConcatenation extends UnsanitizedPathCombiner {
   PathCombinerViaStringConcatenation() { exists(AddExpr e | this = e) }
 }
 
 class MethodCallGetFullPath extends MethodCall {
   MethodCallGetFullPath() { this.getTarget().hasQualifiedName("System.IO.Path", "GetFullPath") }
 }
 
 class GetFullPathToQualifierTaintTrackingConfiguration extends TaintTracking4::Configuration {
   GetFullPathToQualifierTaintTrackingConfiguration() {
     this = "GetFullPathToQualifierTaintTrackingConfiguration"
   }
 
   override predicate isSource(DataFlow::Node node) {
     exists(MethodCallGetFullPath mcGetFullPath | node = DataFlow::exprNode(mcGetFullPath))
   }
 
   override predicate isSink(DataFlow::Node node) {
     exists(MethodCall mc |
       mc.getTarget() instanceof RootSanitizerMethod and
       node.asExpr() = mc.getQualifier()
     )
   }
 }
 
 class PathCombinerToGetFullPathTaintTrackingConfiguration extends TaintTracking4::Configuration {
   PathCombinerToGetFullPathTaintTrackingConfiguration() {
     this = "PathCombinerToGetFullPathTaintTrackingConfiguration "
   }
 
   override predicate isSource(DataFlow::Node node) {
     exists(UnsanitizedPathCombiner pathCombiner | node = DataFlow::exprNode(pathCombiner))
   }
 
   override predicate isSink(DataFlow::Node node) {
     exists(MethodCallGetFullPath mcGetFullPath |
       node = DataFlow::exprNode(mcGetFullPath.getArgument(0))
     )
   }
 }
 
 private predicate safeCombineGetFullPathSequence(MethodCallGetFullPath mcGetFullPath, Expr q) {
   // Path.Combine THEN Path.GetFullPath is applied (with possibly arbitrary mutations)
   exists(DataFlow::Node source, PathCombinerToGetFullPathTaintTrackingConfiguration taintTracking |
     taintTracking.hasFlow(source, DataFlow::exprNode(mcGetFullPath.getArgument(0)))
   ) and
   exists(GetFullPathToQualifierTaintTrackingConfiguration qualifierTaintTracker |
     qualifierTaintTracker.hasFlow(DataFlow::exprNode(mcGetFullPath), DataFlow::exprNode(q))
   )
 }
 
 class RootSanitizerMethodCall extends SanitizerMethodCall {
   /*
    * The set of /valid/ Guards of RootSanitizerMethodCall.
    *
    *    IN CONJUNCTION with BOTH
    *      Path.Combine
    *      AND Path.GetFullPath
    *    OR
    *      There is a direct flow from Path.GetFullPath to qualifier of RootSanitizerMethodCall.
    *
    *    It is not simply enough for the qualifier of String.StartsWith
    *    to pass through Path.Combine without also passing through GetFullPath AFTER.
    */
 
   RootSanitizerMethodCall() {
     exists(RootSanitizerMethod sm | this.getTarget() = sm) and
     exists(Expr q, AbstractValue v |
       this.getQualifier() = q and
       v.(AbstractValues::BooleanValue).getValue() = true and
       exists(MethodCallGetFullPath mcGetFullPath | safeCombineGetFullPathSequence(mcGetFullPath, q))
     )
   }
 
   override Expr getFilePathArgument() { result = this.getQualifier() }
 }
 
 class ZipSlipGuard extends Guard {
   /*
    * The set of Guards of RootSanitizerMethodCall that are used IN CONJUNCTION with
    *      Path.GetFullPath - it is not simply enough for the qualifier of String.StartsWith
    *      to pass through Path.Combine without also passing through GetFullPath.
    */
 
   ZipSlipGuard() { this instanceof SanitizerMethodCall }
 
   Expr getFilePathArgument() { result = this.(SanitizerMethodCall).getFilePathArgument() }
 }
 
 abstract class SanitizerMethodCall extends MethodCall {
   SanitizerMethodCall() { this instanceof MethodCall }
 
   abstract Expr getFilePathArgument();
 }
 
 class SantizedGuardTaintTrackingConfiguration extends TaintTracking2::Configuration {
   SantizedGuardTaintTrackingConfiguration() { this = "SantizedGuardTaintTrackingConfiguration" }
 
   override predicate isSource(DataFlow::Node source) { source instanceof DataFlow::ParameterNode }
 
   override predicate isSink(DataFlow::Node sink) {
     exists(RootSanitizerMethodCall smc |
       smc.getAnArgument() = sink.asExpr() or
       smc.getQualifier() = sink.asExpr()
     )
   }
 }
 
 abstract class AbstractWrapperSanitizerMethod extends AbstractSanitizerMethod {
   /**
    * An AbstractWrapperSanitizerMethod is a Method that
    *  is a suitable sanitizer for a ZipSlip path that may not have been canonicalized prior.
    *
    * If the return value of this Method correctly validates if a file path is in a valid location,
    * or is a restricted subset of that validation, then any use of this Method is as valid as the Root
    * sanitizer (Path.StartsWith).
    */
   Parameter paramFilename;
 
   AbstractWrapperSanitizerMethod() {
     this.getReturnType() instanceof BoolType and
     this.getAParameter() = paramFilename
   }
 
   Parameter paramFilePath() { result = paramFilename }
 }
 
 class DirectWrapperSantizierMethod extends AbstractWrapperSanitizerMethod {
   /*
    * A DirectWrapperSantizierMethod is a Method where
    *      The function can /only/ returns true when passes through the RootSanitizerGuard
    *
    *     bool wrapperFn(a,b){
    *       if(guard(a,b))
    *         return true
    *       ....
    *       return false
    *     }
    *
    *     bool wrapperFn(a,b){
    *       ...
    *       return guard(a,b)
    *     }
    */
 
   DirectWrapperSantizierMethod() {
     forex(ReturnStmt ret | ret.getEnclosingCallable() = this |
       ret.getExpr().(BoolLiteral).getBoolValue() = false
       or
       exists(ZipSlipGuard g, SantizedGuardTaintTrackingConfiguration taintTracker |
         g.getEnclosingCallable() = this and
         taintTracker
             .hasFlow(DataFlow::parameterNode(paramFilename),
               DataFlow::exprNode(g.getFilePathArgument())) and
         (
           exists(AbstractValues::BooleanValue bv |
             // If there exists a control block that guards against misuse
             bv.getValue() = true and
             g.controlsNode(ret.getAControlFlowNode(), bv)
           )
           or
           // Or if the function returns the resultant of the guard call
           DataFlow::localFlow(DataFlow::exprNode(g), DataFlow::exprNode(ret.getExpr()))
         )
       )
     )
   }
 }
 
 class IndirectOverloadedWrapperSantizierMethod extends AbstractWrapperSanitizerMethod {
   /**
    * An IndirectOverloadedWrapperSanitizerMethod is a Method in which simply wraps /another/ wrapper.class
    *
    * Usually this will look like the following stanza:
    * boolean someWrapper(string s){
    *  return someWrapper(s, true);
    * }
    */
   IndirectOverloadedWrapperSantizierMethod() {
     forex(ReturnStmt ret | ret.getEnclosingCallable() = this |
       ret.getExpr().(BoolLiteral).getBoolValue() = false
       or
       exists(ZipSlipGuard g |
         // If the parameter flows directly to SanitizerMethodCall, and the resultant is returned
         DataFlow::localFlow(DataFlow::parameterNode(paramFilename),
           DataFlow::exprNode(g.getFilePathArgument())) and
         DataFlow::localFlow(DataFlow::exprNode(g), DataFlow::exprNode(ret.getExpr()))
       )
     )
   }
 }
 
 class WrapperSanitizerMethodCall extends SanitizerMethodCall {
   // A Wrapped Sanitizer Method call (some function that is equally or more restrictive than our root sanitizer)
   AbstractWrapperSanitizerMethod wrapperMethod;
 
   WrapperSanitizerMethodCall() {
     exists(AbstractWrapperSanitizerMethod sm |
       this.getTarget() = sm and
       wrapperMethod = sm
     )
   }
 
   override Expr getFilePathArgument() {
     result = this.getArgument(wrapperMethod.paramFilePath().getIndex())
   }
 }
 
 private predicate wrapperCheckGuard(Guard g, Expr e, AbstractValue v) {
   // A given wrapper method call, with the filePathArgument as a sink, that returns 'true'
   g instanceof WrapperSanitizerMethodCall and
   g.(WrapperSanitizerMethodCall).getFilePathArgument() = e and
   v.(AbstractValues::BooleanValue).getValue() = true
 }
 
 /**
  * A sanitizer for unsafe zip extraction.
  */
 abstract class Sanitizer extends DataFlow::ExprNode { }
 
 class WrapperCheckSanitizer extends Sanitizer {
   // A Wrapped RootSanitizer that is an explicit subset of RootSanitizer
   WrapperCheckSanitizer() { this = DataFlow::BarrierGuard<wrapperCheckGuard/3>::getABarrierNode() }
 }
 
 /**
  * A data flow source for unsafe zip extraction.
  */
 abstract class Source extends DataFlow::Node { }
 
 class ArchiveEntryFullName extends Source {
   // Access to full name of the archive item
   ArchiveEntryFullName() {
     exists(PropertyAccess pa |
       pa.getTarget().getDeclaringType().hasQualifiedName("System.IO.Compression", "ZipArchiveEntry") and
       pa.getTarget().getName() = "FullName" and
       this = DataFlow::exprNode(pa)
     )
   }
 }
 
 /**
  * A data flow sink for unsafe zip extraction.
  */
 abstract class Sink extends DataFlow::Node { }
 
 class SinkCompressionExtractToFileArgument extends Sink {
   // Argument to extract to file extension method
   SinkCompressionExtractToFileArgument() {
     exists(MethodCall mc |
       mc.getTarget().hasQualifiedName("System.IO.Compression.ZipFileExtensions", "ExtractToFile") and
       this.asExpr() = mc.getArgumentForName("destinationFileName")
     )
   }
 }
 
 class SinkFileOpenArgument extends Sink {
   // File Stream created from tainted file name through File.Open/File.Create
   SinkFileOpenArgument() {
     exists(MethodCall mc |
       (
         mc.getTarget().hasQualifiedName("System.IO.File", "Open") or
         mc.getTarget().hasQualifiedName("System.IO.File", "OpenWrite") or
         mc.getTarget().hasQualifiedName("System.IO.File", "Create")
       ) and
       this.asExpr() = mc.getArgumentForName("path")
     )
   }
 }
 
 class SinkStreamConstructorArgument extends Sink {
   // File Stream created from tainted file name passed directly to the constructor
   SinkStreamConstructorArgument() {
     exists(ObjectCreation oc |
       oc.getTarget().getDeclaringType().hasQualifiedName("System.IO", "FileStream") and
       this.asExpr() = oc.getArgumentForName("path")
     )
   }
 }
 
 class SinkFileInfoConstructorArgument extends Sink {
   // Constructor to FileInfo can take tainted file name and subsequently be used to open file stream
   SinkFileInfoConstructorArgument() {
     exists(ObjectCreation oc |
       oc.getTarget().getDeclaringType().hasQualifiedName("System.IO", "FileInfo") and
       this.asExpr() = oc.getArgumentForName("fileName")
     )
   }
 }
 
 class FileNameExtrationSanitizer extends Sanitizer {
   // Extracting just file name from a ZipEntry, not the full path
   FileNameExtrationSanitizer() {
     exists(MethodCall mc |
       mc.getTarget().hasQualifiedName("System.IO.Path", "GetFileName") and
       this = DataFlow::exprNode(mc.getAnArgument())
     )
   }
 }
 
 class StringCheckSanitizer extends Sanitizer {
   // Checks the string for relative path,
   // or checks the destination folder for whitelisted/target path, etc
   StringCheckSanitizer() {
     exists(MethodCall mc |
       (
         mc instanceof RootSanitizerMethodCall or
         mc.getTarget().hasQualifiedName("System.String", "Substring")
       ) and
       this = DataFlow::exprNode(mc.getQualifier())
     )
   }
 }
 
 class ZipSlipTaintTrackingConfiguration extends TaintTracking::Configuration {
   ZipSlipTaintTrackingConfiguration() { this = "ZipSlipTaintTrackingConfiguration" }
 
   override predicate isSource(DataFlow::Node node) { node instanceof Source }
 
   override predicate isSink(DataFlow::Node node) { node instanceof Sink }
 
   override predicate isAdditionalTaintStep(DataFlow::Node pred, DataFlow::Node succ) {
     super.isAdditionalTaintStep(pred, succ)
     or
     exists(MethodCall mc | succ.asExpr() = mc and pred.asExpr() = mc.getAnArgument())
   }
 
   override predicate isSanitizer(DataFlow::Node node) { node instanceof Sanitizer }
 }