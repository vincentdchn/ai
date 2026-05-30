---
name: check-config
description: Validates project.yaml is well-formed. Checks required fields, valid values, resolvable paths, and detects typos.
---

# Check Config

Read-only validation. Reports config errors with field path and suggestion.

## Step 1: Read project.yaml

Look for `project.yaml` in the project's config directory (`.ai/`, `.claude/`,
`.cursor/`, or whichever directory contains the skills/agents symlinks).

If file does not exist, report and stop.

## Step 2: Check required fields

These fields must be present and non-empty:

- `runtime` - one of: deno, node, go, python, rust
- `architecture.pattern` - one of: port-adapter, layered, hexagonal, mvc, none
- `quality_gates.commands.format`
- `quality_gates.commands.lint`
- `quality_gates.commands.test`

Report each missing field with its expected type/values.

## Step 3: Check paths resolve

For each path field, verify the directory exists:

```bash
test -d "{architecture.ports_dir}" || echo "MISSING: architecture.ports_dir -> {value}"
test -d "{architecture.adapters_dir}" || echo "MISSING: architecture.adapters_dir -> {value}"
test -d "{architecture.domain_dir}" || echo "MISSING: architecture.domain_dir -> {value}"
test -d "{testing.test_dir}" || echo "MISSING: testing.test_dir -> {value}"
test -d "{testing.mock_dir}" || echo "MISSING: testing.mock_dir -> {value}"
```

Skip fields that are absent from config (optional).

## Step 4: Check commands are plausible

For each command in `quality_gates.commands`, verify the base tool exists:

```bash
which deno || which npm || which pnpm || which go  # based on runtime
```

If the configured command references a tool not available on PATH, warn.

## Step 5: Detect unknown keys

Valid top-level keys: `config_dir`, `runtime`, `architecture`, `conventions`, `quality_gates`, `testing`, `git`.

Flag any top-level key not in this list as a likely typo.

Valid `conventions` sub-keys: `naming`, `error_handling`, `barrel_exports`, `domain_purity`, `observability`.

Flag unknown sub-keys.

## Output

```
## Config Validation

| Field | Status | Issue |
|---|---|---|
| runtime | OK | - |
| architecture.ports_dir | WARN | Directory does not exist: src/application/ |
| quality_gates.commands.audit | OK | - |
| conventions.observabilty | ERROR | Unknown key (typo for 'observability'?) |

Errors: N | Warnings: M
```

## Rules

- READ-ONLY - never modify project.yaml.
- Report suggestions, not just errors (e.g., "did you mean 'observability'?").
- Missing optional fields are not errors. Only flag required fields and typos.
