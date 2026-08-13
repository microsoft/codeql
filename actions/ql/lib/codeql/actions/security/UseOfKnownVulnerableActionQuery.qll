import actions

/**
 * Raw vulnerable-action inventory. Keep this separate from the enabled
 * security class so consumers that need version inventory do not force the
 * security query to report every vulnerable reference.
 */
class KnownVulnerableActionInventory extends UsesStep {
  string vulnerable_action;
  string fixed_version;
  string vulnerable_version;
  string vulnerable_sha;

  KnownVulnerableActionInventory() {
    vulnerableActionsDataModel(vulnerable_action, vulnerable_version, vulnerable_sha, fixed_version) and
    this.getCallee() = vulnerable_action and
    (this.getVersion() = vulnerable_version or this.getVersion() = vulnerable_sha)
  }

  string getFixedVersion() { result = fixed_version }

  string getVulnerableAction() { result = vulnerable_action }

  string getVulnerableVersion() { result = vulnerable_version }

  string getVulnerableSha() { result = vulnerable_sha }
}

/**
 * Holds if a string is a statically false workflow condition.
 */
private predicate isStaticallyFalse(string condition) {
  condition = ["false", "0", "${{ false }}", "${{ 0 }}"]
}

/**
 * Suppress references that are not deployed workflow logic. These locations
 * are commonly copied, generated, vendored, or test-only sources.
 */
private predicate isIgnoredLocation(UsesStep step) {
  exists(string path |
    path = step.getLocation().getFile().getRelativePath() and
    (
      path.indexOf("/ql/test/") > -1 or
      path.indexOf("ql/test/") = 0 or
      path.indexOf("/test/") > -1 or
      path.indexOf("test/") = 0 or
      path.indexOf("/tests/") > -1 or
      path.indexOf("tests/") = 0 or
      path.indexOf("/external/") > -1 or
      path.indexOf("external/") = 0 or
      path.indexOf("/contrib/") > -1 or
      path.indexOf("contrib/") = 0 or
      path.indexOf("/vendor/") > -1 or
      path.indexOf("vendor/") = 0 or
      path.indexOf("/vendored/") > -1 or
      path.indexOf("vendored/") = 0 or
      path.indexOf("/third_party/") > -1 or
      path.indexOf("third_party/") = 0 or
      path.indexOf("/third-party/") > -1 or
      path.indexOf("third-party/") = 0 or
      path.indexOf("/x.github.") > -1 or
      path.indexOf("x.github.") = 0 or
      path.indexOf("generated") > -1
    )
  )
}

/**
 * Suppress references that cannot execute because their step or job is
 * statically disabled.
 */
private predicate isInactive(UsesStep step) {
  exists(If condition |
    step.getIf() = condition and
    isStaticallyFalse(condition.getCondition())
  )
  or
  exists(If condition |
    step.getEnclosingJob().getIf() = condition and
    isStaticallyFalse(condition.getCondition())
  )
}

/**
 * Holds if a changed-files output containing attacker-controlled filenames is
 * interpolated into shell source. Boolean outputs and quoted environment
 * variable use are intentionally not considered exploitable.
 */
private predicate changedFilesOutputUsedInShell(UsesStep step) {
  exists(Run run, Expression expression |
    run.getEnclosingJob() = step.getEnclosingJob() and
    expression = run.getAnScriptExpr() and
    (
      expression.getNormalizedExpression().matches(
        "%steps." + step.getId() + ".outputs.all_changed_files%"
      )
      or
      expression.getNormalizedExpression().matches(
        "%steps." + step.getId() + ".outputs.modified_files%"
      )
      or
      expression.getNormalizedExpression().matches(
        "%steps." + step.getId() + ".outputs.added_files%"
      )
      or
      expression.getNormalizedExpression().matches(
        "%steps." + step.getId() + ".outputs.copied_files%"
      )
      or
      expression.getNormalizedExpression().matches(
        "%steps." + step.getId() + ".outputs.deleted_files%"
      )
      or
      expression.getNormalizedExpression().matches(
        "%steps." + step.getId() + ".outputs.renamed_files%"
      )
    )
  )
}

/**
 * Holds if the Gradle configuration cache is explicitly enabled in the
 * action's arguments or in a shell command in the same job.
 */
private predicate gradleConfigurationCacheEnabled(UsesStep step) {
  step.getArgument("arguments").toLowerCase().matches("%configuration-cache%") or
  exists(Run run |
    run.getEnclosingJob() = step.getEnclosingJob() and
    run.getScript().getRawScript().toLowerCase().matches("%configuration-cache%")
  )
}

/**
 * A named artifact is a useful defensive boundary for the download-artifact
 * path traversal advisory: this query does not claim that a known same-run
 * artifact name is attacker-controlled.
 */
private predicate downloadsUnrestrictedArtifactSet(UsesStep step) {
  not exists(step.getArgument("name")) and
  not exists(step.getArgument("artifact-ids")) and
  not exists(step.getArgument("pattern"))
}

private predicate hasNonTokenSecretAccess(UsesStep step) {
  exists(SecretsExpression secret |
    (secret.getEnclosingJob() = step.getEnclosingJob() or not exists(secret.getEnclosingJob())) and
    secret.getEnclosingWorkflow() = step.getEnclosingJob().getWorkflow() and
    not secret.getFieldName() = "GITHUB_TOKEN"
  )
}

private predicate changedFilesAdvisoryExploitability(UsesStep step) {
  exists(Event event |
    step.getEnclosingJob().isPrivilegedExternallyTriggerable(event) and
    event.getName() = "pull_request_target" and
    changedFilesOutputUsedInShell(step)
  )
}

private predicate githubSlugAdvisoryExploitability(UsesStep step) {
  exists(Event event |
    step.getEnclosingJob().isPrivilegedExternallyTriggerable(event) and
    event.getName() = "pull_request_target"
  )
}

private predicate gradleAdvisoryExploitability(UsesStep step) {
  exists(Event event |
    step.getEnclosingJob().isPrivilegedExternallyTriggerable(event) and
    (
      event.getName() = "pull_request_target" or
      event.getName() = "workflow_run" or
      event.getName() = "workflow_call"
    ) and
    gradleConfigurationCacheEnabled(step) and
    hasNonTokenSecretAccess(step)
  )
}

private predicate downloadArtifactAdvisoryExploitability(UsesStep step) {
  exists(Event event |
    step.getEnclosingJob().isPrivilegedExternallyTriggerable(event) and
    (
      event.getName() = "pull_request_target" or
      event.getName() = "workflow_run" or
      event.getName() = "workflow_call"
    ) and
    downloadsUnrestrictedArtifactSet(step)
  )
}

/**
 * Holds if an affected action is externally reachable and runs with a
 * meaningful repository or secret impact.
 */
private predicate hasAdvisoryExploitability(
  KnownVulnerableActionInventory step, string advisory
) {
  advisory = "GHSA-mcph-m25j-8j63" and changedFilesAdvisoryExploitability(step)
  or
  advisory = "GHSA-6q4m-7476-932w" and githubSlugAdvisoryExploitability(step)
  or
  advisory = "GHSA-h3qr-39j9-4r5v" and gradleAdvisoryExploitability(step)
  or
  advisory = "GHSA-cxww-7g56-2vh6" and downloadArtifactAdvisoryExploitability(step)
}

/**
 * A known vulnerable action with a supported advisory-specific exploitability
 * model. This is the class consumed by the enabled high-value query.
 */
class KnownVulnerableAction extends KnownVulnerableActionInventory {
  string advisory;

  KnownVulnerableAction() {
    vulnerableActionsAdvisoryDataModel(vulnerable_action, advisory) and
    not isIgnoredLocation(this) and
    not isInactive(this) and
    hasAdvisoryExploitability(this, advisory)
  }

  string getAdvisory() { result = advisory }
}
