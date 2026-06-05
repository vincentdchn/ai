---
name: audit
description: Generates a context-specific audit brief and executes review via code-reviewer agent. Usable standalone or as a building block within other skills.
skills: check-conventions
agents: code-reviewer
---

# Audit

Analyzes changes, generates a brief adapted to the specific work, and spawns `code-reviewer` to execute the review.

## Trigger

`/audit` or invoked programmatically by other skills (e.g. `implement`).

## Inputs

Accepts one of:
- No argument → reviews unstaged + staged changes
- Branch name → reviews diff against main
- File list → reviews those files
- **Directed context** (when called by another skill): intent, plan, prior findings, focus areas

## Workflow

### 1. Determine Scope

```bash
git diff --stat
git diff --cached --stat
```

Or use the provided branch/file list. Read changed files.

### 2. Understand Intent

- From commit messages, PR description, or caller-provided context
- If ambiguous and interactive: ask the user in one question
- Identify which layers/modules are touched and what the change accomplishes

### 3. Generate Brief

Craft a self-contained audit brief specific to this change. The brief adapts to what was done:

**For new feature code:**
- Contract completeness (are all edge cases handled?)
- Integration points (what could break downstream?)
- Convention adherence for the specific layers touched

**For bug fixes:**
- Root cause addressed vs symptom suppressed?
- Regression test present?
- Related code paths that share the same pattern

**For refactors:**
- Behavioral equivalence (does output change?)
- Missed call sites
- Dead code left behind

**Always include in the brief:**
- Changed files with what each change accomplishes
- Project conventions relevant to these specific files (from `project.yaml`)
- Concrete questions the reviewer should answer

### 4. Execute Review

Spawn `code-reviewer` agent with the generated brief. Return its output verbatim.

## Output

The `code-reviewer` verdict: structured findings (Critical/Important/Nit) + PASS/FAIL.

## Verification Mode

When called with prior findings to verify (e.g. implement's final audit):

Brief focuses on:
- Were previous blockers resolved?
- Did fixes introduce new issues?
- Are original requirements met?

## Rules

- Brief is always self-contained. Reviewer needs zero external context.
- Brief is always specific. Never a generic checklist.
- Adapt brief depth to change complexity: rename = light, new feature = thorough.
- Never modify code. Read-only.
