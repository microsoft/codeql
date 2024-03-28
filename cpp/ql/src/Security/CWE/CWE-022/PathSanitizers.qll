import cpp 
import semmle.code.cpp.ir.dataflow.DataFlow
import semmle.code.cpp.controlflow.IRGuards

abstract private class PathGuard extends IRGuardCondition {
    abstract Expr getCheckedExpr();
  }

/** A complementary guard that protects against path traversal, by looking for the literal `..`. */
private class PathTraversalGuard extends PathGuard {
    Expr checkedExpr;
  
    PathTraversalGuard() {
      exists(Call ma, Function m, type t |
        m = ma.getTarget() and
        t = m.getDeclaringType() and
        (t instanceof TypeString or t instanceof StringsKt) and
        checkedExpr = getVisualQualifier(ma).getUnderlyingExpr() and
        ma.getAnArgument().(CompileTimeConstantExpr).getStringValue() = ".."
      |
        this = ma and
        getSourceMethod(m).hasName("contains")
        or
        exists(EqualityTest eq |
          this = eq and
          getSourceMethod(m).hasName(["indexOf", "lastIndexOf"]) and
          eq.getAnOperand() = ma and
          eq.getAnOperand().(CompileTimeConstantExpr).getIntValue() = -1
        )
      )
    }
  
    override Expr getCheckedExpr() { result = checkedExpr }
  
    boolean getBranch() {
      this instanceof MethodCall and result = false
      or
      result = this.(EqualityTest).polarity()
    }
  }

/** A sanitizer that protects against path injection vulnerabilities. */
abstract class PathInjectionSanitizer extends DataFlow::Node { }

/**
 * Holds if `g` is a guard that considers a path safe because it is checked for `..` components, having previously
 * been checked for a trusted prefix.
 */
predicate lessThanOrEqual(IRGuardCondition g, Expr e, boolean branch) {
   // Local taint-flow is used here to handle cases where the validated expression comes from the
    // expression reaching the sink, but it's not the same one, e.g.:
    //  Path path = source();
    //  String strPath = path.toString();
    //  if (!strPath.contains("..") && strPath.startsWith("/safe/dir"))
    //    sink(path);
    branch = g.(PathTraversalGuard).getBranch() and
    localTaintFlowToPathGuard(e, g) and
    exists(Guard previousGuard |
      previousGuard.(AllowedPrefixGuard).controls(g.getBasicBlock(), true)
      or
      previousGuard.(BlockListGuard).controls(g.getBasicBlock(), false)
    )
  }

  
  private class DotDotCheckSanitizer extends PathInjectionSanitizer {
    DotDotCheckSanitizer() {
      this = DataFlow::BarrierGuard<dotDotCheckGuard/3>::getABarrierNode() or
      this = ValidationMethod<dotDotCheckGuard/3>::getAValidatedNode()
    }
  }
  