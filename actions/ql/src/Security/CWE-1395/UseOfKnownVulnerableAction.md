## Overview

The security of the workflow and the repository could be compromised when an
externally reachable, privileged workflow uses a vulnerable action in a
configuration that satisfies the affected advisory's exploitability
prerequisites. The query intentionally does not report every vulnerable
version reference: advisory prerequisites, effective reachability, and
meaningful impact are required to reduce inventory-only findings.

## Recommendation

Either remove the component from the workflow or upgrade it to a version that is not vulnerable.
For advisories with configuration-specific mitigations, also remove the
affected prerequisite (for example, disable Gradle configuration cache when
the vulnerable Gradle action is retained).

## References

- GitHub Docs: [Keeping your actions up to date with Dependabot](https://docs.github.com/en/code-security/dependabot/working-with-dependabot/keeping-your-actions-up-to-date-with-dependabot).
