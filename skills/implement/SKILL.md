---
name: implement
description: Full SDLC workflow - from task to PR. Plans, audits adversarially, implements, runs quality gates, and opens a PR. Supports audit-only mode for existing changes.
skills: interface-scout, ddd-scaffold, run-and-fix, check-conventions, pr-description
---

# Implement

Full software development lifecycle in one skill. From task description to merge-ready PR with adversarial audits at every stage.

## Trigger

When user types `/implement` followed by a task description or flag.

## Modes

### Mode 1: Full pipeline (default)
`/implement <task description>`

Full cycle: understand → plan → audit plan → refine → implement → quality gates → audit code → fix → final audit → PR.

### Mode 2: Audit loop only
`/implement --audit` or `/implement --verify`

Skips planning and implementation. Assumes code changes already exist in the working tree. Jumps directly to the audit loop: generate audit prompt → audit → fix → final audit.

Use this when:
- You've already written the code manually or with another agent
- You want to validate existing changes before committing
- You're iterating on a previous `/implement` that failed final audit

### Flags

- `--audit` / `--verify` - Audit-only mode (Mode 2)
- `--no-pr` - Skip PR creation at the end
- `--no-audit` - Skip adversarial audits (plan + code) for trivial changes

## Step 0: Load project config

Read `project.yaml` (in the project's config directory, default `.ai/`) for:
- `architecture.*` - layer layout, composition root, barrel file
- `conventions.*` - naming, error handling, barrel exports, domain purity, observability
- `quality_gates.*` - format, lint, typecheck, test commands and retry config
- `testing.*` - framework, patterns, directories
- `git.*` - branch format, commit format, ticket prefix

This is the canonical convention source. Supplement with CLAUDE.md or equivalent instructions file if present.

---

## Full Pipeline (Mode 1)

### Step 1: Understand & Scout

Parse the input (ticket URL, issue body, or plain description). Identify:
- What capability is being added or changed
- Which layers are affected (ports, domain, adapters, app service)
- Whether this is new functionality or a modification

Scout the codebase:
- Invoke skill `interface-scout` or manually scan for similar existing features
- Identify ports/interfaces to create or extend
- Identify existing utilities/types to reuse
- Find reference implementations to follow (never invent structure from scratch)

### Step 2: Create Implementation Plan

Create a detailed plan following layer ordering:
1. Ports/contracts (interfaces, error types, DTOs)
2. Domain logic (pure business rules)
3. Adapters (infrastructure implementations)
4. Application service / orchestration
5. Tests
6. Wiring (composition root, config)

The plan must include:
- Files to modify/create (with full paths)
- Key changes per file
- Order of operations (respecting layer dependencies)
- Testing strategy (which test types, what to cover)
- Whether scaffolding is needed (new module vs extending existing)
- Risks and edge cases

Decision points to address in the plan:
- **Scaffold vs extend?** New module if the feature is self-contained. Extend if it's adding behavior to existing concepts.
- **Shared vs app-local domain?** App-local by default. Shared only if consumed by >1 app today.
- **New port or extend existing?** New port if the responsibility is distinct.

Present the plan to the user for approval.

### Step 3: Audit the Plan

Once the user approves the plan, generate a self-contained audit prompt and spawn a reviewer subagent.

The audit prompt must include:
1. The full plan and original task
2. File paths involved and their current state
3. Project conventions from `project.yaml` to check against
4. Architecture pattern and layer rules

Instruct the reviewer to:
- Challenge assumptions in the plan
- Identify missing edge cases
- Flag potential regressions
- Question architectural choices against project conventions
- Check for simpler alternatives
- Report findings as: BLOCKER / IMPORTANT / NITPICK with file:line references

Show the audit results to the user.

### Step 4: Refine the Plan

Incorporate the audit findings:
- All blockers (mandatory)
- Important items (address or explicitly justify skipping)
- Nitpicks (at your discretion)

Present the refined plan for final approval.

**STOP HERE** - Wait for explicit user approval before proceeding to implementation.

---

## Autonomous Execution

Once the user approves the refined plan, execute the following phases autonomously. No human checkpoints between phases.

### Phase 1: Scaffold (if needed)

If the plan calls for a new feature module, invoke skill `ddd-scaffold` to generate the file structure. Skip if extending existing code.

### Phase 2: Implement

Spawn a subagent with label `implementer`:

```
You are a senior software engineer. Implement the following plan precisely.

## Task
{task}

## Implementation Plan
{plan}

## Context
{codebase analysis from Step 1 - file structure, reference implementations, dependencies}

## Instructions
- Follow the plan exactly. Do not deviate unless you find an obvious bug in the plan itself.
- Write clean, production-ready code.
- No TODO comments, no placeholder implementations.
- Follow existing patterns found in reference implementations.
- Implement layer by layer: ports → domain → adapters → app service → tests → wiring.
- Report what you changed: files modified, functions added/changed.
```

### Phase 3: Quality Gates

Invoke skill `run-and-fix` to execute the project's quality gate sequence:
1. Format
2. Lint
3. Type check
4. Tests

If any gate fails after max retries, report and continue to audit (the auditor will catch it).

### Phase 4: Generate Audit Prompt & Audit

Spawn a subagent with label `audit-prompt-gen` to create a self-contained audit prompt, then spawn a subagent with label `auditor` to execute it.

The audit prompt must include:
- All files changed with their paths
- The intent behind each change
- Project conventions from `project.yaml` to check against
- The `check-conventions` checks as the convention baseline
- Instruction to READ actual files and RUN tests
- Finding format: BLOCKER / IMPORTANT / NITPICK with file:line

### Phase 5: Fix

Spawn a subagent with label `fixer`:

```
You are a senior software engineer. Fix the issues found in the audit.

## Original Task
{task}

## Audit Findings
{audit output from Phase 4}

## Instructions
- Fix ALL blockers.
- Fix important items unless you can justify why they're not applicable.
- Skip nitpicks unless trivial to address.
- For each fix, explain what you changed and why.
- Run tests after fixes to verify nothing is broken.
- If the audit found no blockers or important issues, just confirm the code is good and make no changes.
```

### Phase 6: Final Audit

Spawn a subagent with label `final-audit-prompt-gen` to generate a verification audit prompt, then spawn `final-auditor` to execute it.

The final audit prompt must include:
- The original task and what was supposed to be achieved
- The first audit's blocker/important findings
- What fixes were applied
- Project conventions
- Instruction to verify: original task addressed, all blockers resolved, no new issues introduced
- Request a verdict: PASS (ready to ship) or FAIL (list remaining issues)

### Phase 7: Create PR (unless `--no-pr`)

If the final audit passes:

1. Create a branch following the `git.branch_format` from project.yaml
2. Commit with atomic, logical commits following `git.commit_format`
3. Invoke skill `pr-description` to generate the PR body
4. Push and create the PR

If the final audit fails:
- Report findings to the user
- Do NOT create the PR
- Let the user decide next steps

---

## Audit-loop-only (Mode 2)

When triggered with `--audit` or `--verify`:

1. Run `git diff` and `git diff --cached` to capture what changed
2. Load project config (Step 0)
3. Ask the user: "What was the intent behind these changes?" (unless provided as argument)
4. Execute Phases 4-7 from above, using the git diff as the implementation context

---

## Presenting Results

After the workflow completes, present:
1. What was implemented (files changed, grouped by layer)
2. Key audit findings and how they were addressed
3. Final audit verdict (PASS/FAIL)
4. PR link (if created)
5. If FAIL: what remains to be fixed

## Rules

- ALWAYS source conventions from `project.yaml` as the canonical config.
- ALWAYS scout existing code before implementing. Never invent structure from scratch.
- ALWAYS make audit prompts self-contained - no external context needed.
- ALWAYS run quality gates (`run-and-fix`) before auditing.
- ALWAYS instruct auditor subagents to check against `check-conventions` patterns.
- NEVER proceed to implementation without explicit user approval of the refined plan.
- NEVER weaken tests or skip quality gates to pass audits.
- NEVER create a PR if the final audit fails.
- Adapt audit depth to task complexity: simple rename = light touch, new feature = thorough.
