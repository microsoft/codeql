import actions
import codeql.actions.security.ControlChecks
private import codeql.actions.DataFlow
private import codeql.actions.dataflow.FlowSources
private import codeql.actions.TaintTracking

string checkoutTriggers() {
  result = ["pull_request_target", "workflow_run", "workflow_call", "issue_comment"]
}

/**
 * A taint-tracking configuration for PR HEAD references flowing
 * into actions/checkout's ref argument.
 */
private module ActionsMutableRefCheckoutConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) {
    (
      // remote flow sources
      source instanceof GitHubCtxSource
      or
      source instanceof GitHubEventCtxSource
      or
      source instanceof GitHubEventJsonSource
      or
      source instanceof MaDSource
      or
      // `ref` argument contains the PR id/number or head ref
      exists(Expression e |
        source.asExpr() = e and
        (
          containsHeadRef(e.getExpression()) or
          containsPullRequestNumber(e.getExpression())
        )
      )
      or
      // 3rd party actions returning the PR head ref
      exists(StepsExpression e, UsesStep step |
        source.asExpr() = e and
        e.getStepId() = step.getId() and
        (
          step.getCallee() = "eficode/resolve-pr-refs" and e.getFieldName() = "head_ref"
          or
          step.getCallee() = "xt0rted/pull-request-comment-branch" and e.getFieldName() = "head_ref"
          or
          step.getCallee() = "alessbell/pull-request-comment-branch" and
          e.getFieldName() = "head_ref"
          or
          step.getCallee() = "gotson/pull-request-comment-branch" and e.getFieldName() = "head_ref"
          or
          step.getCallee() = "potiuk/get-workflow-origin" and
          e.getFieldName() = ["sourceHeadBranch", "pullRequestNumber"]
          or
          step.getCallee() = "github/branch-deploy" and e.getFieldName() = ["ref", "fork_ref"]
        )
      )
    )
  }

  predicate isSink(DataFlow::Node sink) {
    exists(Uses uses |
      uses.getCallee() = "actions/checkout" and
      uses.getArgumentExpr(["ref", "repository"]) = sink.asExpr()
    )
  }

  predicate isAdditionalFlowStep(DataFlow::Node pred, DataFlow::Node succ) {
    exists(Run run |
      pred instanceof FileSource and
      pred.asExpr().(Step).getAFollowingStep() = run and
      succ.asExpr() = run.getScript() and
      exists(run.getScript().getAFileReadCommand())
    )
  }
}

module ActionsMutableRefCheckoutFlow = TaintTracking::Global<ActionsMutableRefCheckoutConfig>;

private module ActionsSHACheckoutConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) {
    source.asExpr().getATriggerEvent().getName() =
      ["pull_request_target", "workflow_run", "workflow_call", "issue_comment"] and
    (
      // `ref` argument contains the PR head/merge commit sha
      exists(Expression e |
        source.asExpr() = e and
        containsHeadSHA(e.getExpression())
      )
      or
      // 3rd party actions returning the PR head sha
      exists(StepsExpression e, UsesStep step |
        source.asExpr() = e and
        e.getStepId() = step.getId() and
        (
          step.getCallee() = "eficode/resolve-pr-refs" and e.getFieldName() = "head_sha"
          or
          step.getCallee() = "xt0rted/pull-request-comment-branch" and e.getFieldName() = "head_sha"
          or
          step.getCallee() = "alessbell/pull-request-comment-branch" and
          e.getFieldName() = "head_sha"
          or
          step.getCallee() = "gotson/pull-request-comment-branch" and e.getFieldName() = "head_sha"
          or
          step.getCallee() = "potiuk/get-workflow-origin" and
          e.getFieldName() = ["sourceHeadSha", "mergeCommitSha"]
        )
      )
      or
      // Some authorization wrappers return a JSON object whose ref member is
      // the already-resolved commit SHA.
      exists(JsonReferenceExpression e |
        source.asExpr() = e and
        e.getAccessPath().regexpMatch("(?i)\\.ref\\b") and
        e.getInnerExpression().regexpMatch(
          "(?i)\\b(needs\\.Authorization|steps\\.(auth|authorization))\\.outputs\\.args\\b"
        )
      )
    )
  }

  predicate isSink(DataFlow::Node sink) {
    exists(Uses uses |
      uses.getCallee() = "actions/checkout" and
      uses.getArgumentExpr(["ref", "repository"]) = sink.asExpr()
    )
  }

  predicate isAdditionalFlowStep(DataFlow::Node pred, DataFlow::Node succ) {
    exists(Run run |
      pred instanceof FileSource and
      pred.asExpr().(Step).getAFollowingStep() = run and
      succ.asExpr() = run.getScript() and
      exists(run.getScript().getAFileReadCommand())
    )
  }
}

module ActionsSHACheckoutFlow = TaintTracking::Global<ActionsSHACheckoutConfig>;

bindingset[s]
predicate containsPullRequestNumber(string s) {
  exists(
    normalizeExpr(s)
        .regexpFind([
            "\\bgithub\\.event\\.number\\b", "\\bgithub\\.event\\.issue\\.number\\b",
            "\\bgithub\\.event\\.pull_request\\.id\\b",
            "\\bgithub\\.event\\.pull_request\\.number\\b",
            "\\bgithub\\.event\\.check_suite\\.pull_requests\\[\\d+\\]\\.id\\b",
            "\\bgithub\\.event\\.check_suite\\.pull_requests\\[\\d+\\]\\.number\\b",
            "\\bgithub\\.event\\.check_run\\.check_suite\\.pull_requests\\[\\d+\\]\\.id\\b",
            "\\bgithub\\.event\\.check_run\\.check_suite\\.pull_requests\\[\\d+\\]\\.number\\b",
            "\\bgithub\\.event\\.check_run\\.pull_requests\\[\\d+\\]\\.id\\b",
            "\\bgithub\\.event\\.check_run\\.pull_requests\\[\\d+\\]\\.number\\b",
            // heuristics
            "\\bpr_number\\b", "\\bpr_id\\b"
          ], _, _)
  )
}

bindingset[s]
predicate containsHeadSHA(string s) {
  exists(
    normalizeExpr(s)
        .regexpFind([
            "\\bgithub\\.event\\.pull_request\\.head\\.sha\\b",
            "\\bgithub\\.event\\.pull_request\\.merge_commit_sha\\b",
            "\\bgithub\\.event\\.workflow_run\\.head_commit\\.id\\b",
            "\\bgithub\\.event\\.workflow_run\\.head_sha\\b",
            "\\bgithub\\.event\\.check_suite\\.after\\b",
            "\\bgithub\\.event\\.check_suite\\.head_commit\\.id\\b",
            "\\bgithub\\.event\\.check_suite\\.head_sha\\b",
            "\\bgithub\\.event\\.check_suite\\.pull_requests\\[\\d+\\]\\.head\\.sha\\b",
            "\\bgithub\\.event\\.check_run\\.check_suite\\.after\\b",
            "\\bgithub\\.event\\.check_run\\.check_suite\\.head_commit\\.id\\b",
            "\\bgithub\\.event\\.check_run\\.check_suite\\.head_sha\\b",
            "\\bgithub\\.event\\.check_run\\.check_suite\\.pull_requests\\[\\d+\\]\\.head\\.sha\\b",
            "\\bgithub\\.event\\.check_run\\.head_sha\\b",
            "\\bgithub\\.event\\.check_run\\.pull_requests\\[\\d+\\]\\.head\\.sha\\b",
            "\\bgithub\\.event\\.merge_group\\.head_sha\\b",
            "\\bgithub\\.event\\.merge_group\\.head_commit\\.id\\b",
            // heuristics
            "\\bhead\\.sha\\b", "\\bhead_sha\\b", "\\bmerge_sha\\b", "\\bpr_head_sha\\b"
          ], _, _)
  )
}

bindingset[s]
predicate containsHeadRef(string s) {
  exists(
    normalizeExpr(s)
        .regexpFind([
            "\\bgithub\\.event\\.pull_request\\.head\\.ref\\b", "\\bgithub\\.head_ref\\b",
            "\\bgithub\\.event\\.workflow_run\\.head_branch\\b",
            "\\bgithub\\.event\\.check_suite\\.pull_requests\\[\\d+\\]\\.head\\.ref\\b",
            "\\bgithub\\.event\\.check_run\\.check_suite\\.pull_requests\\[\\d+\\]\\.head\\.ref\\b",
            "\\bgithub\\.event\\.check_run\\.pull_requests\\[\\d+\\]\\.head\\.ref\\b",
            "\\bgithub\\.event\\.merge_group\\.head_ref\\b",
            // heuristics
            "\\bhead\\.ref\\b", "\\bhead_ref\\b", "\\bmerge_ref\\b", "\\bpr_head_ref\\b",
            // env vars
            "GITHUB_HEAD_REF",
          ], _, _)
  )
}

class SimplePRHeadCheckoutStep extends Step {
  SimplePRHeadCheckoutStep() {
    // This should be:
    // artifact instanceof PRHeadCheckoutStep
    // but PRHeadCheckoutStep uses Taint Tracking anc causes a non-Monolitic Recursion error
    // so we list all the subclasses of PRHeadCheckoutStep here and use actions/checkout as a workaround
    // instead of using ActionsMutableRefCheckout and ActionsSHACheckout
    exists(Uses uses |
      this = uses and
      uses.getCallee() = "actions/checkout" and
      exists(uses.getArgument("ref")) and
      not uses.getArgument("ref").matches("%base%") and
      uses.getATriggerEvent().getName() = checkoutTriggers()
    )
    or
    this instanceof GitMutableRefCheckout
    or
    this instanceof GitSHACheckout
    or
    this instanceof GhMutableRefCheckout
    or
    this instanceof GhSHACheckout
  }
}

/** Checkout of a Pull Request HEAD */
abstract class PRHeadCheckoutStep extends Step {
  abstract string getPath();
}

/** Checkout of a Pull Request HEAD ref */
abstract class MutableRefCheckoutStep extends PRHeadCheckoutStep { }

/** Checkout of a Pull Request HEAD ref */
abstract class SHACheckoutStep extends PRHeadCheckoutStep { }

/** Checkout of a Pull Request HEAD ref using actions/checkout action */
class ActionsMutableRefCheckout extends MutableRefCheckoutStep instanceof UsesStep {
  ActionsMutableRefCheckout() {
    this.getCallee() = "actions/checkout" and
    (
      exists(
        ActionsMutableRefCheckoutFlow::PathNode source, ActionsMutableRefCheckoutFlow::PathNode sink
      |
        ActionsMutableRefCheckoutFlow::flowPath(source, sink) and
        this.getArgumentExpr(["ref", "repository"]) = sink.getNode().asExpr()
      )
      or
      // heuristic base on the step id and field name
      exists(string value, Expression expr |
        value.regexpMatch(".*(head|branch|ref).*") and expr = this.getArgumentExpr("ref")
      |
        expr.(StepsExpression).getStepId() = value
        or
        expr.(SimpleReferenceExpression).getFieldName() = value and
        not expr instanceof GitHubExpression
        or
        expr.(NeedsExpression).getNeededJobId() = value
        or
        expr.(JsonReferenceExpression).getAccessPath() = value
        or
        expr.(JsonReferenceExpression).getInnerExpression() = value
      )
    )
  }

  override string getPath() {
    if exists(this.(UsesStep).getArgument("path"))
    then result = this.(UsesStep).getArgument("path")
    else result = "GITHUB_WORKSPACE/"
  }
}

/** Checkout of a Pull Request HEAD ref using actions/checkout action */
class ActionsSHACheckout extends SHACheckoutStep instanceof UsesStep {
  ActionsSHACheckout() {
    this.getCallee() = "actions/checkout" and
    (
      exists(ActionsSHACheckoutFlow::PathNode source, ActionsSHACheckoutFlow::PathNode sink |
        ActionsSHACheckoutFlow::flowPath(source, sink) and
        this.getArgumentExpr(["ref", "repository"]) = sink.getNode().asExpr()
      )
      or
      exists(Expression reference |
        reference = this.getArgumentExpr("ref") and
        isRecognizedSHAReference(reference)
      )
      or
      // heuristic base on the step id and field name
      exists(string value, Expression expr |
        value.regexpMatch(".*(sha|commit).*") and expr = this.getArgumentExpr("ref")
      |
        expr.(StepsExpression).getStepId() = value
        or
        expr.(SimpleReferenceExpression).getFieldName() = value and
        not expr instanceof GitHubExpression
        or
        expr.(NeedsExpression).getNeededJobId() = value
        or
        expr.(JsonReferenceExpression).getAccessPath() = value
        or
        expr.(JsonReferenceExpression).getInnerExpression() = value
      )
    )
  }

  override string getPath() {
    if exists(this.(UsesStep).getArgument("path"))
    then result = this.(UsesStep).getArgument("path")
    else result = "GITHUB_WORKSPACE/"
  }
}

private predicate isRecognizedSHAReference(Expression reference) {
  containsHeadSHA(reference.getExpression())
  or
  exists(StepsExpression expression |
    expression = reference and
    (
      expression.getFieldName().regexpMatch("(?i).*(sha|commit).*")
      or
      exists(UsesStep producer |
        producer = expression.getTarget() and
        (
          producer.getCallee() = "eficode/resolve-pr-refs" and
          expression.getFieldName() = "head_sha"
          or
          producer.getCallee() = [
            "xt0rted/pull-request-comment-branch",
            "alessbell/pull-request-comment-branch",
            "gotson/pull-request-comment-branch"
          ] and
          expression.getFieldName() = "head_sha"
          or
          producer.getCallee() = "potiuk/get-workflow-origin" and
          expression.getFieldName() = ["sourceHeadSha", "mergeCommitSha"]
        )
      )
    )
  )
  or
  exists(NeedsExpression expression, Job job, Expression output |
    expression = reference and
    expression.getTarget() = job.getOutputs() and
    output = job.getOutputExpr(expression.getFieldName()) and
    (
      containsHeadSHA(output.getExpression())
      or
      output.getExpression().regexpMatch("(?i).*(head_sha|merge_sha|commit_sha).*")
    )
  )
  or
  exists(JobsExpression expression, Job job, Expression output |
    expression = reference and
    expression.getTarget() = job.getOutputs() and
    output = job.getOutputExpr(expression.getFieldName()) and
    (
      containsHeadSHA(output.getExpression())
      or
      output.getExpression().regexpMatch("(?i).*(head_sha|merge_sha|commit_sha).*")
    )
  )
  or
  exists(InputsExpression expression |
    expression = reference and
    expression.getFieldName().regexpMatch("(?i).*(head_sha|merge_sha|commit_sha).*")
  )
  or
  exists(JsonReferenceExpression expression |
    expression = reference and
    expression.getAccessPath().regexpMatch("(?i)\\.ref\\b") and
    expression.getInnerExpression().regexpMatch(
      "(?i)\\b(needs\\.Authorization|steps\\.(auth|authorization))\\.outputs\\.args\\b"
    )
  )
}

/** Checkout of a Pull Request HEAD ref using git within a Run step */
class GitMutableRefCheckout extends MutableRefCheckoutStep instanceof Run {
  GitMutableRefCheckout() {
    exists(string cmd | this.getScript().getACommand() = cmd |
      cmd.regexpMatch("git\\s+(fetch|pull).*") and
      (
        (containsHeadRef(cmd) or containsPullRequestNumber(cmd))
        or
        exists(string varname, string expr |
          expr = this.getInScopeEnvVarExpr(varname).getExpression() and
          (
            containsHeadRef(expr) or
            containsPullRequestNumber(expr)
          ) and
          exists(cmd.regexpFind(varname, _, _))
        )
      )
    )
  }

  override string getPath() { result = this.(Run).getWorkingDirectory() }
}

/** Checkout of a Pull Request HEAD ref using git within a Run step */
class GitSHACheckout extends SHACheckoutStep instanceof Run {
  GitSHACheckout() {
    exists(string cmd | this.getScript().getACommand() = cmd |
      cmd.regexpMatch("git\\s+(fetch|pull).*") and
      (
        containsHeadSHA(cmd)
        or
        exists(string varname, string expr |
          expr = this.getInScopeEnvVarExpr(varname).getExpression() and
          containsHeadSHA(expr) and
          exists(cmd.regexpFind(varname, _, _))
        )
      )
    )
  }

  override string getPath() { result = this.(Run).getWorkingDirectory() }
}

/** Checkout of a Pull Request HEAD ref using gh within a Run step */
class GhMutableRefCheckout extends MutableRefCheckoutStep instanceof Run {
  GhMutableRefCheckout() {
    exists(string cmd | this.getScript().getACommand() = cmd |
      cmd.regexpMatch(".*(gh|hub)\\s+pr\\s+checkout.*") and
      (
        (containsHeadRef(cmd) or containsPullRequestNumber(cmd))
        or
        exists(string varname |
          (
            containsHeadRef(this.getInScopeEnvVarExpr(varname).getExpression()) or
            containsPullRequestNumber(this.getInScopeEnvVarExpr(varname).getExpression())
          ) and
          exists(cmd.regexpFind(varname, _, _))
        )
      )
    )
  }

  override string getPath() { result = this.(Run).getWorkingDirectory() }
}

/** Checkout of a Pull Request HEAD ref using gh within a Run step */
class GhSHACheckout extends SHACheckoutStep instanceof Run {
  GhSHACheckout() {
    exists(string cmd | this.getScript().getACommand() = cmd |
      cmd.regexpMatch("gh\\s+pr\\s+checkout.*") and
      (
        containsHeadSHA(cmd)
        or
        exists(string varname |
          containsHeadSHA(this.getInScopeEnvVarExpr(varname).getExpression()) and
          exists(cmd.regexpFind(varname, _, _))
        )
      )
    )
  }

  override string getPath() { result = this.(Run).getWorkingDirectory() }
}

private predicate isRunCheckoutReference(
  PRHeadCheckoutStep checkout, Expression reference, string variable
) {
  reference = checkout.(Run).getInScopeEnvVarExpr(variable) and
  (
    checkout instanceof SHACheckoutStep and containsHeadSHA(reference.getExpression())
    or
    checkout instanceof MutableRefCheckoutStep and
    (
      containsHeadRef(reference.getExpression()) or
      containsPullRequestNumber(reference.getExpression())
    )
  ) and
  exists(string command |
    checkout.(Run).getScript().getACommand() = command and
    exists(command.regexpFind(variable, _, _))
  )
}

bindingset[condition]
private predicate hasTrustedAuthorAssociation(string condition) {
  exists(string normalized |
    normalized = normalizeExpr(condition) and
    normalized.regexpMatch(
      ".*\\bgithub\\.event\\.(pull_request|issue)\\.author_association\\b.*"
    ) and
    (
      normalized.regexpMatch(".*\\b(OWNER|MEMBER|COLLABORATOR)\\b.*")
      or
      exists(string firstTimer, string firstContributor, string mannequin, string noneValue |
        firstTimer = normalized.regexpFind("FIRST_TIMER", _, _) and
        firstContributor = normalized.regexpFind("FIRST_TIME_CONTRIBUTOR", _, _) and
        mannequin = normalized.regexpFind("MANNEQUIN", _, _) and
        noneValue = normalized.regexpFind("NONE", _, _)
      )
    )
  )
}

/**
 * Holds if the checkout is restricted to a PR author or repository that is
 * not attacker-controlled for the triggering event.
 */
predicate isTrustedCheckoutPath(PRHeadCheckoutStep checkout, Event event) {
  exists(ControlCheck check |
    check instanceof AssociationIfCheck and
    check.protects(checkout, event, "untrusted-checkout") and
    hasTrustedAuthorAssociation(check.(If).getCondition())
  )
  or
  exists(PullRequestTargetRepositoryIfCheck check |
    check.protects(checkout, event, "untrusted-checkout-toctou")
  )
  or
  exists(WorkflowRunRepositoryIfCheck check |
    check.protects(checkout, event, "untrusted-checkout-toctou")
  )
}

/** Gets the expression that controls the untrusted checkout, if one can be identified. */
AstNode getCheckoutReference(PRHeadCheckoutStep checkout) {
  exists(UsesStep uses | uses = checkout |
    result = uses.getArgumentExpr("ref")
    or
    not exists(uses.getArgumentExpr("ref")) and result = uses.getArgumentExpr("repository")
  )
  or
  isRunCheckoutReference(checkout, result, _)
  or
  checkout instanceof Run and
  result = checkout and
  not isRunCheckoutReference(checkout, _, _)
}

/** Gets a display label for the expression that controls the untrusted checkout. */
string getCheckoutReferenceText(AstNode reference) {
  result = reference.(Expression).toString()
  or
  not reference instanceof Expression and result = "the checkout command"
}

/** Adds checkout-reference provenance before the checkout step in path queries. */
predicate checkoutReferenceEdge(AstNode predecessor, AstNode successor) {
  predecessor = getCheckoutReference(successor) and
  not predecessor = successor
}
