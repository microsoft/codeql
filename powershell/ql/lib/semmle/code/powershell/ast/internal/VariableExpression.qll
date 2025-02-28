private import TAst
private import Expr
private import Raw.Raw as Raw

class VarAccess extends Expr, TVarAccess {
  string getName() { result = toRaw(this).(Raw::VarAccess).getUserPath() }
}

// private predicate isImplicitVariableWriteAccess(Expr e) { none() }
// class VarReadAccess extends VarAccess {
//   VarReadAccess() { not this instanceof VarWriteAccess }
// }
// class VarWriteAccess extends VarAccess {
//   VarWriteAccess() { isExplicitWrite(this, _) or isImplicitVariableWriteAccess(this) }
//   predicate isExplicit(AssignStmt assign) { isExplicitWrite(this, assign) }
//   predicate isImplicit() { isImplicitVariableWriteAccess(this) }
// }
// /** An access to an environment variable such as `$Env:PATH` */
// class EnvVarAccess extends VarAccess {
//   EnvVarAccess() { super.getVariable() instanceof EnvVariable }
//   override EnvVariable getVariable() { result = super.getVariable() }
//   string getEnvironmentVariable() { result = this.getVariable().getEnvironmentVariable() }
// }
