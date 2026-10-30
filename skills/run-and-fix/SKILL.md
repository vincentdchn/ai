---
name: run-and-fix
description: Discover and run applicable project checks, fix scoped failures, and report observed results without weakening gates.
---

# Run and fix

Use the global [verification policy](../../rules/verification.md) and the target project's local instructions. This workflow authorizes checks and scoped fixes, not commits or publication.

## Discover the checks

1. Identify the changed files and the requested verification scope.
2. Read the project's documented commands, package scripts, runtime configuration, and CI workflows.
3. Resolve the package manager and working directory from repository evidence, including lockfiles and workspace configuration.
4. Record each applicable command, its source, prerequisites, and whether the project requires it.

Do not invent commands from a language or manifest name. A package manifest does not establish an `npm` workflow or a standalone compiler command. If sources conflict, resolve which workflow applies before running it.

Use the project's check order. Run only applicable gates. Include builds, security checks, coverage, or integration checks when the project requires them for this scope. Use only documented coverage thresholds.

If a required command or prerequisite cannot be resolved, mark the gate `NOT_RUN` and explain the blocker. Missing credentials, unavailable services, or an unknown command do not make a required gate inapplicable.

## Run and fix

1. Run a gate with the documented command in the correct working directory.
2. On failure, inspect the output and relevant code. Apply a minimal fix within the task's scope.
3. Rerun the failed gate. Use the project's retry limit, or stop after three unsuccessful fix attempts.
4. After a fix, rerun earlier checks whose results the edit invalidated.
5. Continue only when the current gate passes.

If a failure remains, stop automatic fixes and subsequent gates. Report the failure, attempted fixes, and remaining checks as `NOT_RUN`. Read-only diagnosis may continue.

Never weaken assertions, lower thresholds, disable checks, or hide failures. Change an incorrect test only when the specification supports the correction. Do not apply dependency or security remediation outside the approved scope.

Respect the worktree. Do not overwrite unrelated changes or run destructive setup commands without approval. If a formatter would rewrite unrelated work, use a supported scoped command or report the limitation.

## Report the actual state

For each gate, report the exact command, working directory, status, attempts, and useful output:

- `PASS`: the command succeeded for the current changes.
- `FAIL`: the command failed or a required threshold was not met.
- `NOT_RUN`: the gate was not executed, or edits invalidated its result and it has not been rerun.
- `N/A`: repository evidence establishes that the gate does not apply. Cite that evidence.

Keep check results separate from review findings. Report all gates passed only when every required applicable gate passed for the current changes.

Return results without committing or publishing. A failed or unrun required gate blocks both, regardless of an audit verdict. Follow the global [authorization policy](../../AGENTS.md).

Read `rule://writing-style` before reporting, or use [the local writing policy](../../rules/writing-style.md) when that URI is unavailable.
