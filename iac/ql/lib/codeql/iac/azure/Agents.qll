/** Provides explicitly PR-enabled pipelines and effective private pool selection. */

private import iac

module AzurePipelineAgents {
  private predicate isLiteralName(YamlString value) {
    value.getValue() != "" and
    not value.getValue().regexpMatch(".*\\$[({\\[].*")
  }

  /** Holds if a pool explicitly selects private agents rather than hosted or server jobs. */
  predicate isPrivatePool(YamlValue pool) {
    exists(YamlString name |
      name = pool
      or
      name = pool.(YamlMapping).lookup("name")
    |
      isLiteralName(name) and
      not name.getValue().toLowerCase() = ["server", "azure pipelines"] and
      not exists(pool.(YamlMapping).lookup("vmImage"))
    )
    or
    exists(YamlMapping mapping |
      mapping = pool and
      not exists(mapping.lookup("name")) and
      not exists(mapping.lookup("vmImage")) and
      exists(YamlString demand |
        demand = mapping.lookup("demands")
        or
        demand = mapping.lookup("demands").(YamlSequence).getAChild()
      |
        isLiteralName(demand)
      )
    )
  }

  private predicate isPoolScope(YamlMapping scope, AzurePipelines::Step step) {
    scope = step.getParentNode+() and
    (
      scope instanceof AzurePipelines::Document
      or
      scope instanceof AzurePipelines::Stage
      or
      scope instanceof AzurePipelines::Job
      or
      // Deployment lifecycle hooks may override the job pool.
      exists(AzurePipelines::DeploymentJob job |
        scope =
          job.lookup("strategy")
              .getAChild()
              .(YamlMapping)
              .lookup(["preDeploy", "deploy", "routeTraffic", "postRouteTraffic"])
        or
        scope =
          job.lookup("strategy")
              .getAChild()
              .(YamlMapping)
              .lookup("on")
              .(YamlMapping)
              .lookup(["failure", "success"])
      )
    )
  }

  /** Gets the nearest explicitly declared pool, respecting even unknown overrides. */
  YamlValue getEffectivePool(AzurePipelines::Step step) {
    exists(YamlMapping scope |
      isPoolScope(scope, step) and
      result = scope.lookup("pool") and
      not exists(YamlMapping nearer |
        isPoolScope(nearer, step) and
        scope = nearer.getParentNode+() and
        exists(nearer.lookup("pool"))
      )
    )
  }

  /** Holds if YAML explicitly enables PR builds. Omitted PR triggers are not inferred. */
  predicate explicitlyEnablesPr(AzurePipelines::Document doc) {
    exists(YamlString pr | pr = doc.lookup("pr") | pr.getValue() = "*")
    or
    exists(YamlSequence pr |
      pr = doc.lookup("pr") and
      exists(YamlString branch | branch = pr.getAChild() | isLiteralName(branch))
    )
    or
    exists(YamlMapping pr |
      pr = doc.lookup("pr") and
      (
        not exists(pr.lookup("branches").(YamlMapping).lookup("include"))
        or
        exists(YamlString branch |
          branch = pr.lookup("branches").(YamlMapping).lookup("include").getAChild() and
          isLiteralName(branch)
        )
      ) and
      not pr.lookup("branches").(YamlMapping).lookup("exclude").getAChild().(YamlString).getValue() =
        "*"
    )
  }

  bindingset[condition]
  private predicate excludesPr(string condition) {
    exists(string normalized |
      normalized = condition.toLowerCase().regexpReplaceAll("\\s", "").replaceAll("\"", "'") and
      (
        normalized = "false"
        or
        normalized
            .regexpMatch("ne\\(variables(\\['build.reason'\\]|\\.build.reason),'pullrequest'\\)")
        or
        normalized
            .regexpMatch("eq\\(variables(\\['build.reason'\\]|\\.build.reason),'(individualci|batchedci|manual|schedule)'\\)")
        or
        normalized
            .regexpMatch("and\\(succeeded\\(\\),ne\\(variables(\\['build.reason'\\]|\\.build.reason),'pullrequest'\\)\\)")
      )
    )
  }

  bindingset[condition]
  private predicate requiresPr(string condition) {
    condition
        .toLowerCase()
        .regexpReplaceAll("\\s", "")
        .replaceAll("\"", "'")
        .regexpMatch("eq\\(variables(\\['build.reason'\\]|\\.build.reason),'pullrequest'\\)")
    or
    condition
        .toLowerCase()
        .regexpReplaceAll("\\s", "")
        .replaceAll("\"", "'")
        .regexpMatch("eq\\(variables(\\['system.pullrequest.isfork'\\]|\\.system.pullrequest.isfork),(true|'true')\\)")
  }

  /** Holds if an explicit trigger or enclosing PR/fork-only guard establishes a PR path. */
  predicate hasExplicitPrEvidence(AzurePipelines::Step step) {
    explicitlyEnablesPr(step.getEnclosingDocument())
    or
    exists(YamlMapping scope |
      scope = step.getParentNode*() and
      (
        scope = step or
        scope instanceof AzurePipelines::Job or
        scope instanceof AzurePipelines::Stage
      ) and
      requiresPr(scope.lookup("condition").(YamlScalar).getValue())
    )
    or
    exists(YamlMapping wrapper, YamlString key |
      wrapper = step.getParentNode+() and
      wrapper.maps(key, _) and
      requiresPr(key.getValue().regexpCapture("\\$\\{\\{\\s*if\\s+(.*?)\\s*\\}\\}", 1))
    )
  }

  /** Holds if an enclosing literal or simple build-reason guard excludes PR execution. */
  predicate hasKnownNonPrGuard(AzurePipelines::Step step) {
    exists(YamlMapping scope |
      scope = step.getParentNode*() and
      (
        scope = step or
        scope instanceof AzurePipelines::Job or
        scope instanceof AzurePipelines::Stage
      ) and
      excludesPr(scope.lookup("condition").(YamlScalar).getValue())
    )
    or
    exists(YamlMapping wrapper, YamlString key |
      wrapper = step.getParentNode+() and
      wrapper.maps(key, _) and
      excludesPr(key.getValue().regexpCapture("\\$\\{\\{\\s*if\\s+(.*?)\\s*\\}\\}", 1))
    )
  }
}
