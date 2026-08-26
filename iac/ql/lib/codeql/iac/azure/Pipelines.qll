private import codeql.iac.YAML
private import codeql.files.FileSystem

module AzurePipelines {
  private predicate hasPipelineBaseName(YamlDocument doc) {
    doc.getFile().getBaseName() = ["azure-pipelines.yml", "azure-pipelines.yaml"]
  }

  private predicate hasPipelineShape(YamlMapping doc) {
    exists(doc.lookup("steps")) or
    exists(doc.lookup("jobs")) or
    exists(doc.lookup("stages")) or
    exists(doc.lookup("extends"))
  }

  /**
   * Azure DevOps Pipeline file or referenced template.
   */
  class Document extends YamlNode, YamlDocument, YamlMapping {
    Document() {
      this.getFile().getExtension() = ["yml", "yaml"] and
      (hasPipelineBaseName(this) or hasPipelineShape(this))
    }

    override string toString() { result = "Azure DevOps Pipeline" }

    /**
     * Gets a top-level trigger-like entry.
     */
    YamlValue getTrigger(string name) { result = this.lookup(name) }

    /**
     * Get the pipeline pool.
     */
    Pool getPool() { result = this.lookup("pool") }

    /**
     * Gets the pipeline parameters.
     */
    Parameter getParameters() { result = this.lookup("parameters").getAChild() }

    /**
     * Get the pipeline variables.
     */
    Variable getVariables() { result = this.lookup("variables").getAChild() }

    /**
     * Get the pipeline variable with the given name.
     */
    YamlValue getVariable(string name) {
      exists(Variable var | var = this.getVariables() and var.getName() = name |
        result = var.getValue()
      )
    }

    /**
     * Get the pipeline steps.
     */
    Step getSteps() { result.getEnclosingDocument() = this }

    /**
     * Gets the pipeline stages.
     */
    Stage getStages() { result = this.lookup("stages").getAChild() }

    /**
     * Gets the pipeline jobs.
     */
    Job getJobs() {
      result = this.lookup("jobs").getAChild()
      or
      result = this.getStages().getJobs()
    }

    /**
     * Gets the pipeline repository resources.
     */
    RepositoryResource getRepositoryResources() { result.getEnclosingDocument() = this }

    /**
     * Gets the pipeline resources.
     */
    PipelineResource getPipelineResources() { result.getEnclosingDocument() = this }

    /**
     * Get the pipeline task steps.
     */
    Task getTaskSteps() { result = this.getSteps().(Task) }

    /**
     * Get the pipeline script steps.
     */
    Script getScriptSteps() { result = this.getSteps().(Script) }
  }

  /**
   * Azure DevOps Pipeline parameter.
   */
  class Parameter extends YamlNode, YamlMapping {
    Parameter() { exists(Document document | document.lookup("parameters").getChild(_) = this) }

    override string toString() { result = "Parameter '" + this.getName() + "'" }

    /**
     * Gets the parameter name.
     */
    string getName() { result = yamlToString(this.lookup("name")) }

    /**
     * Gets the parameter type.
     */
    string getType() { result = yamlToString(this.lookup("type")) }

    /**
     * Gets the parameter default value.
     */
    YamlValue getDefault() { result = this.lookup("default") }

    /**
     * Gets an allowed value for the parameter.
     */
    YamlValue getAllowedValue() { result = this.lookup("values").getAChild() }
  }

  /**
   * Azure DevOps Pipeline stage.
   */
  class Stage extends YamlNode, YamlMapping {
    Stage() { exists(Document document | document.lookup("stages").getAChildNode() = this) }

    override string toString() { result = "Stage '" + this.getName() + "'" }

    /**
     * Gets the stage name.
     */
    string getName() { result = yamlToString(this.lookup("stage")) }

    /**
     * Gets a job in the stage.
     */
    Job getJobs() { result = this.lookup("jobs").getAChild() }

    /**
     * Gets the stage condition.
     */
    YamlValue getCondition() { result = this.lookup("condition") }
  }

  /**
   * Azure DevOps Pipeline job.
   */
  class Job extends YamlNode, YamlMapping {
    Job() {
      exists(Document document | document.lookup("jobs").getAChildNode() = this)
      or
      exists(Stage stage | stage.lookup("jobs").getAChildNode() = this)
    }

    override string toString() { result = "Job '" + this.getName() + "'" }

    /**
     * Gets the job name.
     */
    string getName() {
      result = yamlToString(this.lookup("job"))
      or
      result = yamlToString(this.lookup("deployment"))
    }

    /**
     * Gets the job pool.
     */
    Pool getPool() { result = this.lookup("pool") }

    /**
     * Gets a step in the job.
     */
    Step getSteps() { result = this.lookup("steps").getAChild() }

    /**
     * Gets the job condition.
     */
    YamlValue getCondition() { result = this.lookup("condition") }
  }

  /**
   * Azure DevOps Pipeline deployment job.
   */
  class DeploymentJob extends Job {
    DeploymentJob() { exists(this.lookup("deployment")) }
  }

  /**
   * Azure DevOps Pipeline pool.
   *
   * https://learn.microsoft.com/en-us/azure/devops/pipelines/yaml-schema/pool
   */
  class Pool extends YamlNode, YamlMapping {
    Pool() {
      exists(Document document | document.lookup("pool") = this)
      or
      exists(Job job | job.lookup("pool") = this)
    }

    /**
     * Get the pool name.
     */
    string getName() { result = yamlToString(this.lookup("name")) }

    /**
     * Get the pool VM image.
     */
    string getVmImage() { result = yamlToString(this.lookup("vmImage")) }

    /**
     * Get the pool demands.
     */
    string getDemands() { result = yamlToString(this.lookup("demands")) }
  }

  /**
   * Azure DevOps Pipeline variables.
   *
   * https://learn.microsoft.com/en-us/azure/devops/pipelines/process/variables
   */
  class Variable extends YamlNode, YamlMapping {
    Variable() {
      exists(Document document | document.lookup("variables").getChild(_) = this)
      or
      exists(Stage stage | stage.lookup("variables").getChild(_) = this)
      or
      exists(Job job | job.lookup("variables").getChild(_) = this)
    }

    override string toString() { result = "Variable '" + this.getName() + "'" }

    /**
     * Get the variable name.
     */
    string getName() { result = yamlToString(this.lookup("name")) }

    /**
     * Get the variable value.
     */
    YamlValue getValue() { result = this.lookup("value") }
  }

  /**
   * Azure DevOps Pipeline step.
   *
   * https://learn.microsoft.com/en-us/azure/devops/pipelines/yaml-schema/steps
   */
  class Step extends YamlNode, YamlMapping {
    Step() {
      exists(Document document | document.lookup("steps").getAChildNode() = this)
      or
      exists(Job job | job.lookup("steps").getAChildNode() = this)
    }

    override string toString() { result = "Azure DevOps Pipeline step" }

    /**
     * Gets the enclosing Azure DevOps Pipeline document.
     */
    Document getEnclosingDocument() {
      exists(Document document | document.lookup("steps").getAChildNode() = this | result = document)
      or
      exists(Document document | this.getFile() = document.getFile() | result = document)
    }

    /**
     * Get the step display name.
     */
    string displayName() { result = yamlToString(this.lookup("displayName")) }

    /**
     * Get the step type based on the presence of a `task` or `script` key.
     */
    string getType() {
      exists(this.lookup("task")) and result = "task"
      or
      exists(this.lookup("script")) and result = "script"
      or
      exists(this.lookup("bash")) and result = "bash"
      or
      exists(this.lookup("powershell")) and result = "powershell"
      or
      exists(this.lookup("pwsh")) and result = "pwsh"
      or
      exists(this.lookup("checkout")) and result = "checkout"
      or
      exists(this.lookup("template")) and result = "template"
    }
  }

  /**
   * Azure DevOps Pipeline task step.
   */
  class Task extends Step {
    Task() { this.getType() = "task" }

    /**
     * Get the task name.
     */
    string getName() { result = yamlToString(this.lookup("task")) }
  }

  class TaskInputs extends YamlNode, YamlMapping {
    private Task task;

    TaskInputs() { task.lookup("inputs") = this }

    YamlValue getInput(string name) { result = this.lookup(name) }
  }

  /**
   * Azure DevOps Pipeline script step.
   */
  class Script extends Step {
    Script() { this.getType() = ["script", "bash", "powershell", "pwsh"] }

    /**
     * Gets the script step kind.
     */
    string getScriptKind() { result = this.getType() }

    /**
     * Gets the inline script content.
     */
    YamlValue getScriptContent() { result = this.lookup(this.getScriptKind()) }
  }

  /**
   * Azure DevOps Pipeline checkout step.
   */
  class Checkout extends Step {
    Checkout() { this.getType() = "checkout" }

    /**
     * Gets the checkout target.
     */
    string getRepository() { result = yamlToString(this.lookup("checkout")) }

    /**
     * Gets the persistCredentials setting.
     */
    YamlValue getPersistCredentials() { result = this.lookup("persistCredentials") }
  }

  /**
   * Azure DevOps Pipeline template step.
   */
  class TemplateStep extends Step {
    TemplateStep() { this.getType() = "template" }

    /**
     * Gets the referenced template path.
     */
    string getTemplate() { result = yamlToString(this.lookup("template")) }
  }

  /**
   * Azure DevOps repository resource.
   */
  class RepositoryResource extends YamlNode, YamlMapping {
    RepositoryResource() {
      exists(Document document |
        document.lookup("resources").(YamlMapping).lookup("repositories").getAChildNode() = this
      )
    }

    override string toString() { result = "Repository resource '" + this.getAlias() + "'" }

    /**
     * Gets the enclosing Azure DevOps Pipeline document.
     */
    Document getEnclosingDocument() {
      exists(Document document |
        document.lookup("resources").(YamlMapping).lookup("repositories").getAChildNode() = this
      |
        result = document
      )
    }

    /**
     * Gets the resource alias.
     */
    string getAlias() { result = yamlToString(this.lookup("repository")) }

    /**
     * Gets the repository name.
     */
    string getName() { result = yamlToString(this.lookup("name")) }

    /**
     * Gets the referenced revision.
     */
    string getRef() { result = yamlToString(this.lookup("ref")) }
  }

  /**
   * Azure DevOps pipeline resource.
   */
  class PipelineResource extends YamlNode, YamlMapping {
    PipelineResource() {
      exists(Document document |
        document.lookup("resources").(YamlMapping).lookup("pipelines").getAChildNode() = this
      )
    }

    override string toString() { result = "Pipeline resource '" + this.getAlias() + "'" }

    /**
     * Gets the enclosing Azure DevOps Pipeline document.
     */
    Document getEnclosingDocument() {
      exists(Document document |
        document.lookup("resources").(YamlMapping).lookup("pipelines").getAChildNode() = this
      |
        result = document
      )
    }

    /**
     * Gets the resource alias.
     */
    string getAlias() { result = yamlToString(this.lookup("pipeline")) }

    /**
     * Gets the source pipeline.
     */
    string getSource() { result = yamlToString(this.lookup("source")) }

    /**
     * Gets the branch selector.
     */
    string getBranch() { result = yamlToString(this.lookup("branch")) }
  }
}
