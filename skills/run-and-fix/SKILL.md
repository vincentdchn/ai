---
name: run-and-fix
description: Runs project quality gates in sequence, auto-fixes failures, retries up to N times per step before escalating. Adapts to any runtime via project.yaml.
---

# Run and Fix

Executes quality gates sequentially, fixing failures along the way.

## Step 1: Load project config

Read `project.yaml` (in the project's config directory, default `.ai/`) to get:
- `quality_gates.commands` (format, lint, typecheck, test, audit)
- `quality_gates.retry_max` (default: 3)
- `quality_gates.coverage_threshold`

If no `project.yaml` exists, detect from project root files:
- `deno.json` / `deno.jsonc` -> deno fmt / deno lint / deno task check / deno task test
- `package.json` -> npm run format / npm run lint / tsc --noEmit / npm test
- `go.mod` -> gofmt / golangci-lint run / (skip typecheck) / go test ./...
- `Cargo.toml` -> cargo fmt / cargo clippy / (skip typecheck) / cargo test

## Step 2: Execute gates in order

Run each step. On failure, analyze the error, apply a minimal fix, re-run.
Move to the next step only when the current one passes.

### Gate sequence

1. **Format** - Run format command. Auto-fixes formatting. Rarely fails.
2. **Lint** - Run lint command. On failure: read error, apply fix, re-run.
3. **Type check** - Run typecheck command (skip if null). On failure: fix types, re-run.
4. **Tests** - Run test command. On failure: fix code or test, re-run. Do NOT weaken assertions.
5. **Audit** - Run audit command (skip if null). On failure: report to user, do NOT auto-fix.

## Iteration Protocol

```
for each step:
  attempt = 0
  while step fails AND attempt < retry_max:
    analyze error output
    apply minimal targeted fix
    re-run step
    attempt++
  if step still fails:
    STOP and report to user with:
      - which step failed
      - error output
      - what was tried
      - suggested manual fix
```

## Step 3: Coverage verification (optional)

If `quality_gates.commands.coverage` is defined:

1. Run coverage command.
2. Verify `coverage_threshold`% minimum line coverage on modified files.
3. If below threshold: identify uncovered branches, report to user. Do NOT generate weak tests.
4. BLOCK until threshold is met.

## Step 4: Git hygiene (optional)

If running as a final pre-commit check:

```bash
git diff --stat main...HEAD
```

Check for:
- Unintended file changes (lock files, unrelated files)
- Files that should be in .gitignore (coverage/, dist/, node_modules/)
- Large binary files or generated content

Report findings but do not auto-fix.

## Output Format

```
## Quality Gate Results

| Step       | Status | Attempts | Notes                    |
|------------|--------|----------|--------------------------|
| Format     | PASS   | 1        | Auto-fixed 3 files       |
| Lint       | PASS   | 2        | Fixed unused import      |
| Type check | PASS   | 1        | -                        |
| Tests      | PASS   | 1        | 42 tests, all passing    |
| Audit      | PASS   | 1        | No vulnerabilities found |
| Coverage   | PASS   | -        | 85% (threshold: 80%)     |
| Git hygiene| PASS   | -        | No unintended changes    |

All gates passed.
```

## Rules

- ALWAYS run format first (it fixes issues other steps would flag).
- NEVER weaken a test assertion to make it pass.
- NEVER skip a step (except null commands).
- NEVER auto-fix security audit issues without user approval.
- After fixing lint/typecheck errors, re-run format to ensure consistency.
- Follow project conventions from CLAUDE.md for any code changes.
