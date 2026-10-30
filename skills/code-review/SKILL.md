---
name: code-review
description: Review an explicit change scope on separate Standards and Spec axes, using repository evidence and available requirements.
---

# Code review

Keep two review axes separate:

- **Standards** checks the change against documented repository rules and established local patterns.
- **Spec** checks the change against the originating issue, approved task, PRD, or acceptance criteria.

This is read-only. Do not edit code, run quality gates, commit, or publish a review without explicit authorization.

## Pin the scope

Use the caller's PR, branch, file list, commit range, or worktree scope.

- For a PR, use its actual target branch and diff.
- For a branch, use the supplied base or resolve it from repository instructions and branch metadata.
- For an exact commit, tag, or range, preserve the requested comparison. State whether the comparison uses that tree or a merge-base.
- With no explicit scope, review staged and unstaged changes, including task-related untracked files.

Resolve refs before reviewing. State the base, head, diff semantics, and whether uncommitted work is included. If a required base remains unknown, ask after inspecting the available metadata. For an empty diff, report no changes rather than launching a review.

Read the relevant code and callers, not only the patch. Do not expand the review to unrelated existing code.

## Find standards and requirements

For Standards, read applicable repository instructions, contribution guidance, tool configuration, and representative nearby code. Cite explicit rules. Label inferred patterns as inference.

For Spec, prefer the source supplied by the caller. Otherwise inspect issue links, PR context, commit messages, and relevant project documents. Use an existing issue-tracker workflow if available. No setup skill or issue-tracker file is required to review.

If no specification is available, report `Spec: NOT_REVIEWED` with the reason. Continue the Standards review without inventing requirements. If the caller explicitly requires Spec review, identify the missing source.

Read `rule://writing-style` before reporting, or use [the local writing policy](../../rules/writing-style.md) when that URI is unavailable.

## Review each axis

For Standards, report concrete conflicts with local rules. Flag complexity or duplication only when it creates a specific maintenance risk. These are judgment calls, not universal architectural violations. Prefer the simpler local pattern over a speculative abstraction.

For Spec, check missing requirements, incorrect behavior, and unrequested scope. Cite the requirement and the changed code for each finding. Distinguish an unavailable requirement from an unmet requirement.

Do not suppress correctness or security issues because they fall outside a checklist. Keep findings tied to the scoped change. Search matches are leads, not proof.

Review inline when that is enough. For substantial independent axes, delegation may help. If delegated, give each read-only reviewer:

- The exact scope, diff semantics, relevant versions, and available check results.
- The source paths or fetched contents for its axis.
- Its specific questions and required citations.
- An instruction to read `rule://writing-style`, or the resolved local writing-policy path when the URI is unavailable.

Do not require a multiagent pipeline or a setup step to run this skill.

## Report separately

Use `## Standards` and `## Spec`. For each finding, give the changed `file:line`, supporting source, practical consequence, severity, and concrete correction.

Keep documented violations separate from judgment calls. Omit speculative or duplicate findings. No findings is a valid result.

Give each axis its own result: `PASS`, `FAIL`, `INCOMPLETE`, or `NOT_REVIEWED`. `FAIL` means a material supported finding remains. `INCOMPLETE` means the requested review could not be completed. Do not let a pass on one axis conceal a failure on the other.

Report check results as supplied or observed, never as inferred from review. A review pass does not clear failed or unrun required checks or authorize a commit. Follow the global [verification policy](../../rules/verification.md) and [authorization policy](../../AGENTS.md).
