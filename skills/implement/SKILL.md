---
name: implement
description: Full SDLC workflow - from task to PR. Plans, audits adversarially, implements, runs quality gates, and opens a PR.
skills: interface-scout, ddd-scaffold, run-and-fix, audit, pr-description
---

# Implement

From task description to merge-ready PR with adversarial audits at every gate.

## Trigger

`/implement <task description>`

## Flags

- `--no-pr` — Skip PR creation.
- `--no-audit` — Skip adversarial audits for trivial changes.

## Step 0: Load Project Config

Read `project.yaml` (default `.ai/`) for architecture, conventions, quality gates, testing, and git config.

---

## Full Pipeline

### Step 1: Understand & Scout

Parse input (ticket URL, issue, description). Identify affected layers.

Scout the codebase:
- Invoke `interface-scout` for existing patterns
- Find reference implementations to follow
- Identify ports/types to reuse

### Step 2: Plan

Create implementation plan, layer-ordered:
1. Ports/contracts (interfaces, errors, DTOs)
2. Domain (pure business rules)
3. Adapters (infrastructure)
4. Application service / orchestration
5. Tests
6. Wiring (composition root, config)

Include: file paths, key changes, order, testing strategy, risks.

Present to user for approval.

### Step 3: Audit the Plan

Invoke `audit` with directed context:
- The full plan and original task
- Current state of files involved
- Architectural decisions to challenge

Show findings. Incorporate blockers + important items into refined plan.

**STOP** — Wait for explicit user approval before implementing.

---

## Autonomous Execution

After approval, execute without human checkpoints.

### Phase 1: Scaffold (if needed)

New feature module → invoke `ddd-scaffold`. Extending existing code → skip.

### Phase 2: Implement

Spawn implementer subagent:

```
You are implementing the following plan precisely.

## Task
{task}

## Plan
{refined plan}

## Context
{codebase analysis from Step 1}

## Rules
- Follow the plan. Deviate only for obvious plan bugs.
- Production-ready code. No TODOs, no placeholders.
- Follow existing patterns from reference implementations.
- Layer order: ports → domain → adapters → app service → tests → wiring.
- Report: files modified, functions added/changed.
```

### Phase 3: Quality Gates

Invoke `run-and-fix` (format → lint → typecheck → tests). Continue to audit even if a gate fails after max retries.

### Phase 4: Audit the Implementation

Invoke `audit` with directed context:
- What was implemented and why
- The original intent / plan
- Focus areas relevant to this specific change

Expect a PASS/FAIL verdict.

### Phase 5: Fix

If audit found blockers or important issues, spawn fixer subagent:

```
Fix the audit findings below.

## Findings
{audit output from Phase 4}

## Rules
- Fix ALL blockers.
- Fix important items unless explicitly not applicable.
- Skip nitpicks unless trivial.
- Run tests after fixes.
- If no blockers/important: confirm and make no changes.
```

### Phase 6: Final Audit

Invoke `audit` in verification mode:
- Original task requirements
- Phase 4 findings and applied fixes
- Regression risk areas

Expect a PASS/FAIL verdict.

### Phase 7: PR (unless `--no-pr`)

On PASS:
1. Branch per `git.branch_format`
2. Atomic commits per `git.commit_format`
3. Invoke `pr-description`
4. Push and create PR

On FAIL: report remaining issues. Do not create PR.

---

## Rules

- Source conventions from `project.yaml` canonically.
- Scout existing code before implementing. Never invent structure.
- Run quality gates before auditing.
- Never proceed to implementation without user approval.
- Never weaken tests to pass audits.
- Never create PR on FAIL verdict.
