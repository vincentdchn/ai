---
name: check-conventions
description: Validates code against all project architecture conventions. Reads project.yaml to determine applicable checks and runs them. Replaces individual check-* skills.
---

# Check Conventions

Read-only analysis. Reports all convention violations with file path and line number.

## Arguments

- `--only=check1,check2` - run only specified checks (default: all applicable)
- `--files=path1,path2` - check only these files (default: all modified files vs main)

## Step 1: Load project config

Read `project.yaml` (in the project's config directory, default `.ai/`) to determine which checks apply.

## Step 2: Identify scope

```bash
git diff --name-only main...HEAD 2>/dev/null || git diff --name-only HEAD~1
```

If `--files` argument provided, use that instead.

## Step 3: Determine applicable checks

| Check | Applies when |
|---|---|
| layer-boundaries | architecture.pattern is defined |
| error-handling | conventions.error_handling is defined |
| barrel-exports | architecture.barrel_file is defined |
| naming-conventions | always |
| testing-contract | always |
| observability | conventions.observability is defined |
| domain-purity | modified files include domain_dir or shared_domain_dir |
| infra-encapsulation | architecture.pattern is port-adapter or hexagonal |

Skip checks whose config section is absent. Respect `--only` filter if provided.

## Step 4: Run checks

### Layer Boundaries

Adapt grep patterns to the project runtime:

**JS/TS (deno, node):**
```bash
grep -rn "from.*[\"'].*adapters/" {ports_dir} || true
grep -rn "from.*adapters/\|from.*application/" {domain_dir} || true
grep -rln "from.*application/" src/ | xargs grep -ln "from.*adapters/" | grep -v {composition_root} || true
```

**Go:**
```bash
grep -rn '".*adapters/' {ports_dir} || true
grep -rn '".*adapters/\|".*application/' {domain_dir} || true
```

**Python:**
```bash
grep -rn "from adapters\|import adapters" {ports_dir} || true
grep -rn "from adapters\|from application\|import adapters\|import application" {domain_dir} || true
```

### Error Handling

For style: result:
```bash
grep -rn "throw new\|throw " {ports_dir} {adapters_dir} | grep -v "_errors" || true
```

For style: throw:
```bash
grep -rn 'throw "' src/ || true
grep -rn "throw new Error(" src/ || true
```

### Barrel Exports

```bash
find . -name "{barrel_file}" -not -path "*/node_modules/*" -not -path "*/.git/*"
```

For each barrel file, check against each entry in barrel_exports.exclude:
```bash
grep -n "from.*adapters/" {barrel_file} || true
grep -n "from.*mock\|from.*_mocks" {barrel_file} || true
grep -n "from.*test_helper\|from.*testing" {barrel_file} || true
grep -n "from.*internal\|from.*private" {barrel_file} || true
```

### Naming Conventions

```bash
find src/ -name "*.ts" -o -name "*.js" -o -name "*.go" -o -name "*.py" -o -name "*.rs" | \
  grep -v node_modules | grep -v .git
```

Apply pattern from naming.files config. Check class/type names:
```bash
grep -rn "^export class\|^class\|^export interface\|^export type" src/
```

### Testing Contract

```bash
# Find implementation files without tests
find {adapters_dir} {domain_dir} -name "*.ts" -o -name "*.go" -o -name "*.py" | \
  grep -v "_test\|.test\|.spec"

# Check mocks implement interfaces
grep -rn "^export class" {mock_dir} | grep -v "implements" || true

# Find unguarded integration tests
find {test_dir} -name "*integration*" | xargs grep -L "{integration_guard}" || true
```

### Observability

```bash
# Unstructured logging (if style: structured)
grep -rn "logger\.\(info\|warn\|error\|debug\)" src/ | grep -v "{" || true

# Console.log in production code
grep -rn "console\.log" src/ | grep -v "test\|spec\|mock" || true
```

### Domain Purity

For each pattern in no_infra_imports, adapt to runtime:

**JS/TS:**
```bash
grep -rn "from.*{pattern}\|import.*{pattern}" {domain_dir} {shared_domain_dir} || true
```

**Go:**
```bash
grep -rn '"{pattern}' {domain_dir} {shared_domain_dir} || true
```

**Python:**
```bash
grep -rn "from {pattern}\|import {pattern}" {domain_dir} {shared_domain_dir} || true
```

If no_persistence_fields: true:
```bash
grep -rn "partitionKey\|sortKey\|pk\|sk\|_id\|s3Key\|s3Path\|sqsHandle\|receiptHandle\|sequenceNumber" {domain_dir} {shared_domain_dir} || true
```

### Infra Encapsulation

Adapt to runtime:

**JS/TS:**
```bash
grep -rn "from.*@aws-sdk\|from.*@azure\|from.*@google-cloud\|from.*pg\|from.*redis" {ports_dir} || true
grep -rn "^export class" {adapters_dir} | grep -v "implements" || true
grep -n "from.*adapters/" {barrel_file} || true
```

**Go:**
```bash
grep -rn '"github.com/aws\|"cloud.google.com\|"github.com/Azure' {ports_dir} || true
```

**Python:**
```bash
grep -rn "from boto3\|import boto3\|from google.cloud\|import redis\|from sqlalchemy" {ports_dir} || true
```

## Output

```markdown
## Convention Check Report

### Summary
- Checks run: N
- Checks passed: X/N
- Total violations: M

### Passed
- [x] Layer boundaries
- [x] Naming conventions
...

### Violations (M found)
1. **[layer-boundaries]** `src/ports/consumer.ts:12` - imports from adapters/
2. **[naming]** `src/adapters/MyAdapter.ts` - file should be snake_case
3. **[domain-purity]** `src/domain/order.ts:5` - imports @aws-sdk/client-sqs

### Severity
- BLOCKING: layer-boundaries, error-handling, domain-purity, infra-encapsulation
- WARNING: naming, barrel-exports, testing-contract, observability
```

## Rules

- READ-ONLY. Never modify files.
- Report violations with exact file path and line number.
- Skip inapplicable checks (missing config section = skip).
- Only report concrete violations, not subjective opinions.
- Blocking violations should fail quality gates. Warnings are advisory.
