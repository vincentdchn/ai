---
name: implement
description: Implement an agreed task using the target project's patterns, checks, and user review checkpoints.
skills: run-and-fix, audit, pr-description
---

# Implement

Use `/implement <task>` to plan, implement, check, and review a change. Follow the target repository's instructions.

## Establish the scope

1. Read the task, acceptance criteria, local instructions, and relevant code.
2. Find an existing implementation to follow. Derive structure, commands, and branch conventions from the repository.
3. Inspect the worktree and branch before editing. Create a needed task branch before edits when the worktree is clean.
4. If changes already exist, preserve them. Resolve branch handling with the user before editing. Never stash, discard, commit, or move their work automatically.

## Agree on the plan

Describe the affected files, behavior changes, risks, and checks. Order work by actual dependencies.

Wait for plan approval before implementing. If the user already approved a plan, use it without another approval round. Preserve every agreed step and review checkpoint. Ask before changes that materially alter the approved scope.

## Implement the agreed step

- Reuse local patterns and keep the change within scope.
- Update affected callers, tests, and documentation.
- Choose delegation only when independent work warrants it. No fixed agent pipeline or architectural sequence is required.
- Stop at the user's agreed review checkpoints.

## Check and review

1. Use [run-and-fix](../run-and-fix/SKILL.md) for the applicable project checks when verification is authorized.
2. Review the scoped diff against the task and local conventions. Use [audit](../audit/SKILL.md) when an independent review is useful or requested.
3. Fix findings within the approved scope. Rerun checks affected by each fix before claiming success.
4. Present the diff, observed check results, review findings, and limitations.

A failed or unrun required check blocks commit and publication. An audit pass cannot clear that block. Never weaken tests or checks to obtain a pass.

## Keep authorization separate

Follow the global [authorization policy](../../AGENTS.md). These boundaries also apply when this skill is installed alone:

- Plan approval authorizes implementation, not a commit.
- Show the diff and verification before requesting explicit commit approval.
- Commit only approved changes, then stop for the user's next instruction.
- Pushes and PR creation require explicit publication approval.
- Draft a PR body with [pr-description](../pr-description/SKILL.md) when requested. Drafting does not authorize publication.

Apply the [documentation policy](../../rules/documentation.md) and [verification policy](../../rules/verification.md). Read `rule://writing-style` before writing, or use [the local writing policy](../../rules/writing-style.md) when that URI is unavailable.
