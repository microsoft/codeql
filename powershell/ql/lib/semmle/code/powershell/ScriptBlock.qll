import powershell
private import semmle.code.powershell.controlflow.internal.Scope

class ScriptBlock extends @script_block, Ast {
  predicate isTopLevel() { not exists(this.getParent()) }

  override string toString() {
    if this.isTopLevel()
    then result = this.getLocation().getFile().getBaseName()
    else result = "{...}"
  }

  override Location getLocation() { script_block_location(this, result) }

  int getNumUsings() { script_block(this, result, _, _, _, _) }

  int getNumRequiredModules() { script_block(this, _, result, _, _, _) }

  int getNumRequiredAssemblies() { script_block(this, _, _, result, _, _) }

  int getNumRequiredPsEditions() { script_block(this, _, _, _, result, _) }

  int getNumRequiredPsSnapIns() { script_block(this, _, _, _, _, result) }

  Stmt getUsing(int i) { script_block_using(this, i, result) }

  Stmt getAUsing() { result = this.getUsing(_) }

  ParamBlock getParamBlock() { script_block_param_block(this, result) }

  NamedBlock getBeginBlock() { script_block_begin_block(this, result) }

  NamedBlock getCleanBlock() { script_block_clean_block(this, result) }

  NamedBlock getDynamicParamBlock() { script_block_dynamic_param_block(this, result) }

  NamedBlock getEndBlock() { script_block_end_block(this, result) }

  NamedBlock getProcessBlock() { script_block_process_block(this, result) }

  string getRequiredApplicationId() { script_block_required_application_id(this, result) }

  boolean getRequiresElevation() { script_block_requires_elevation(this, result) }

  string getRequiredPsVersion() { script_block_required_ps_version(this, result) }

  ModuleSpecification getModuleSpecification(int i) {
    script_block_required_module(this, i, result)
  }

  ModuleSpecification getAModuleSpecification() { result = this.getModuleSpecification(_) }

  final override Scope getEnclosingScope() { result = this }

  /**
   * Gets the `i`'th paramter in this scope.
   *
   * This may be both function paramters and parameter block parameters.
   */
  Parameter getParameter(int i) {
    exists(Function func |
      func.getBody() = this and
      result = func.getParameter(i)
    )
    or
    this.isTopLevel() and
    result = this.getParamBlock().getParameter(i)
  }

  /**
   * Gets a paramter in this scope.
   *
   * This may be both function parameters and parameter block parameters.
   */
  Parameter getAParameter() { result = this.getParameter(_) }

  Parameter getThisParameter() {
    exists(Function func |
      func.getBody() = this and
      result = func.getThisParameter()
    )
  }

  /** Gets the number of function parameters. */
  final int getNumberOfParameters() { result = count(this.getAParameter()) }

  final Parameter getParameterExcludingPiplines(int i) {
    result = this.getParamBlock().getParameterExcludingPiplines(i)
  }
}

/** A `process` block. */
class ProcessBlock extends NamedBlock {
  ScriptBlock scriptBlock;

  ProcessBlock() { scriptBlock.getProcessBlock() = this }

  ScriptBlock getScriptBlock() { result = scriptBlock }

  PipelineParameter getPipelineParameter() {
    result = scriptBlock.getEnclosingFunction().getAParameter()
  }

  PipelineByPropertyNameParameter getAPipelineByPropertyNameParameter() {
    result = scriptBlock.getEnclosingFunction().getAParameter()
  }
}

class TopLevelScriptBlock extends ScriptBlock {
  TopLevelScriptBlock() { this.isTopLevel() }
}
