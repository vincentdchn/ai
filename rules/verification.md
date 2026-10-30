---
description: Evidence required before presenting an implementation step for review
---

# Verify an implementation step

Use the target repository's documented commands and tools. Read the relevant scripts, CI configuration, and installed library documentation before choosing a command. If a documented command fails, report its output; do not silently substitute a weaker check.

Before presenting an agreed implementation step, cover the applicable checks:

1. Run the project's formatter and linter. Read warnings as well as errors. Fix warnings introduced by the change or explain why they remain.
2. Run the applicable type or static checks.
3. Run the relevant automated tests and the integration or E2E checks required by the project. Keep regression tests for plausible behavior, boundary, or state-transition failures. Do not test source wording, wiring, or mock echoes.
4. Exercise the changed behavior for real. Use the browser for a screen, the running API for an endpoint, or the actual CLI for a command. Follow the project's viewport and accessibility checks. For instruction-only changes, use isolated decision scenarios and state that they do not prove full host integration.
5. Review the change against the installed library versions and their current documented APIs. Replace deprecated usage in scope.
6. Check the repository's dependency boundaries. Enforce a new boundary with its existing automated tooling when appropriate; do not impose an architecture pattern.
7. Remove code and temporary resources made obsolete by this change. Apply the authorization and ownership rules in [personal instructions](../AGENTS.md#destructive-operations).
8. Review touched docs and comments against the [documentation conventions](documentation.md) and the [writing policy](writing-style.md). Update the affected canonical sources.
9. For frontend work, apply the project's design, interaction, and accessibility review guidance. Do not install or execute an unrelated skill bundle automatically.

In the handoff, give each applicable check its observed result and evidence. Mark an inapplicable check `N/A` with the reason. Mark required checks that could not run as unrun; do not describe the step as verified or ready while required checks fail or remain unrun.

A green command does not replace manual review. A review PASS does not override failed checks. After fixes, rerun checks whose evidence is stale. Do not weaken assertions or suppress failures to obtain a pass.
