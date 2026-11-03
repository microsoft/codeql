/** Provides Azure Pipelines executable steps and direct credential exposure sinks. */

private import iac

module AzurePipelineExecution {
  /** Gets the task identifier without its version. */
  string getTaskKind(AzurePipelines::Task task) {
    result = task.lookup("task").(YamlString).getValue().regexpCapture("([^@]+)@[0-9]+", 1)
  }

  /** Holds if this is a task that executes scripts, commands, or repository build code. */
  predicate isExecutionTask(AzurePipelines::Task task) {
    getTaskKind(task) =
      [
        "Bash", "PowerShell", "CmdLine", "PythonScript", "AzureCLI", "AzurePowerShell", "Npm",
        "DotNetCoreCLI", "MSBuild", "VSBuild", "Maven", "Gradle"
      ]
  }

  /** Holds if the step explicitly executes code or a command. */
  predicate isExecutionStep(AzurePipelines::Step step) {
    step instanceof AzurePipelines::Script
    or
    isExecutionTask(step.(AzurePipelines::Task))
  }

  private predicate isExecutableInput(AzurePipelines::Task task, string input) {
    exists(string taskKind, YamlMapping inputs |
      taskKind = getTaskKind(task) and inputs = task.lookup("inputs")
    |
      taskKind = ["Bash", "PowerShell"] and
      (
        input = ["arguments", "filePath"] and
        not inputs.lookup("targetType").(YamlString).getValue() = "inline"
        or
        input = "script" and inputs.lookup("targetType").(YamlString).getValue() = "inline"
      )
      or
      taskKind = "CmdLine" and input = "script"
      or
      taskKind = "PythonScript" and
      (
        input = "script" and inputs.lookup("scriptSource").(YamlString).getValue() = "inline"
        or
        input = ["scriptPath", "arguments"] and
        not inputs.lookup("scriptSource").(YamlString).getValue() = "inline"
      )
      or
      taskKind = "AzureCLI" and
      (
        input = "inlineScript" and
        inputs.lookup("scriptLocation").(YamlString).getValue() = "inlineScript"
        or
        input = ["scriptPath", "arguments"] and
        not inputs.lookup("scriptLocation").(YamlString).getValue() = "inlineScript"
      )
      or
      taskKind = "AzurePowerShell" and
      (
        input = "Inline" and inputs.lookup("ScriptType").(YamlString).getValue() = "InlineScript"
        or
        input = ["ScriptPath", "ScriptArguments"] and
        not inputs.lookup("ScriptType").(YamlString).getValue() = "InlineScript"
      )
      or
      taskKind = "Npm" and
      input = "customCommand" and
      inputs.lookup("command").(YamlString).getValue() = "custom"
      or
      taskKind = "DotNetCoreCLI" and input = "arguments"
      or
      taskKind = ["MSBuild", "VSBuild"] and input = "msbuildArgs"
      or
      taskKind = "Maven" and input = ["options", "mavenOptions"]
      or
      taskKind = "Gradle" and input = ["options", "gradleOptions", "tasks"]
    )
  }

  /** Holds if a step supplies the token directly to executable code or an output sink. */
  predicate directTokenSink(AzurePipelines::Step step, YamlString sink, string kind) {
    sink = step.(AzurePipelines::Script).getScriptContent() and kind = "inline script"
    or
    exists(AzurePipelines::Task task, string input |
      task = step and
      isExecutableInput(task, input) and
      sink = task.lookup("inputs").(YamlMapping).lookup(input)
    |
      kind = "task " + input
    )
    or
    exists(AzurePipelines::Task task |
      task = step and
      (
        getTaskKind(task) = "PublishBuildArtifacts" and
        sink = task.lookup("inputs").(YamlMapping).lookup("PathtoPublish")
        or
        getTaskKind(task) = "PublishPipelineArtifact" and
        sink = task.lookup("inputs").(YamlMapping).lookup("targetPath")
      ) and
      kind = "artifact publication input"
    )
    or
    sink = step.lookup("publish") and kind = "artifact publication input"
    or
    isExecutionStep(step) and
    exists(YamlMapping env, YamlScalar key | env = step.lookup("env") and env.maps(key, sink)) and
    kind = "execution-step environment"
  }

  /** Holds if a string directly expands the predefined job access token. */
  predicate containsSystemAccessToken(YamlString value) {
    value.getValue().toLowerCase().matches("%$(system.accesstoken)%")
  }
}
