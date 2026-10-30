---
name: audit
description: Review a scoped change against its intent and the target repository's conventions, with evidence-backed findings.
skills: check-conventions
agents: code-reviewer
---

# Audit

Read-only review. Do not edit files, run quality gates, commit, or publish.

## Pin the scope

- With no arguments, review both staged and unstaged changes. Include task-related untracked files and identify them separately.
- For a branch or PR, use the caller's base or the actual PR target. Otherwise resolve the base from repository instructions and branch metadata.
- For explicit files, commits, or ranges, preserve that scope. State the comparison semantics before reviewing.
- When the base cannot be resolved from available evidence, ask rather than assume a branch name.

Read both index and worktree diffs. If a file has staged and unstaged edits, review both versions rather than only its final contents. Read nearby code and relevant callers as needed, without expanding into an unrelated repository audit.

## Build the review brief

Gather intent from the caller, acceptance criteria, linked issue, PR description, or commits. State missing context rather than inventing requirements.

Include:

- The exact scope, base or range, changed files, and relevant versions.
- The task, approved plan, and acceptance criteria that are available.
- Applicable local rules, with source paths and relevant passages.
- Concrete risks and questions raised by this change.
- Prior findings and actual check results, including failures and unrun checks.

Use [check-conventions](../check-conventions/SKILL.md) only for conventions relevant to these files. Repository instructions and representative local implementations determine the standards.

## Review the change

Review inline or send the brief to the read-only `code-reviewer` agent. Delegation is optional. If delegated, pass the complete scope and instruct the reviewer to read `rule://writing-style`, or [the local writing policy](../../rules/writing-style.md) when unavailable.

Check behavior against the task, affected callers, regression risks, and local conventions. For follow-up audits, verify prior findings and inspect the fixes for regressions.

Report only concrete issues introduced or exposed by the scoped change. Cite the changed `file:line`, the consequence, and the supporting requirement or convention. Search results locate evidence. Read the code before treating a match as a violation.

## Return findings

Read `rule://writing-style` before reporting, or use [the local writing policy](../../rules/writing-style.md) when that URI is unavailable.

State the scope and sources reviewed. List findings by severity with a concrete fix:

- `Critical`: security, data loss, or broken behavior with a demonstrated path.
- `Important`: a material correctness, requirement, or local-convention issue.
- `Nit`: an optional improvement with a specific benefit.

Use `FAIL` for unresolved critical or important findings. Use `PASS` when none remain in the reviewed scope. Use `INCOMPLETE` when missing access or evidence prevents the requested review. Say which scope remains unreviewed.

A review verdict is not a quality-gate result or permission to commit. Preserve failures and unrun checks in the report. Follow the [verification policy](../../rules/verification.md) and [authorization policy](../../AGENTS.md).
