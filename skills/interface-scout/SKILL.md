---
name: interface-scout
description: Read-only codebase analysis that finds existing port/adapter patterns and proposes new interfaces fitting project conventions.
---

# Interface Scout

Read-only analysis. Finds existing patterns and proposes new interfaces.

## Step 1: Load project config

Read `project.yaml` (in the project's config directory) for architecture layout, error handling, and naming conventions.

## Step 2: Scan existing interfaces

```bash
ls {ports_dir}
ls {adapters_dir}
```

If shared domain exists:
```bash
ls {shared_domain_dir}
```

## Step 3: Analyze patterns

For each existing interface, extract:
- Interface name and file path
- Method signatures (return types, error types)
- Associated error file and hierarchy
- Which adapters implement it
- Which domain types it references

## Step 4: Propose new interfaces

For each new interface needed:

```markdown
### Proposed: {InterfaceName}

**File**: `{ports_dir}/{name}`
**Error file**: `{ports_dir}/{name}_errors`

**Methods:**
- `{method}(args): {return_type}` - {purpose}
- `healthCheck(): {health_return_type}`

**Error hierarchy** (if hierarchy: true):
- `{Name}Error` (abstract, extends {base_class})
  - `{Specific}OperationError`
  - `{Name}HealthCheckError`

**Pattern reference:** follows `{existing_interface_path}`
```

## Step 5: Flag decisions

- If a new domain type is needed, flag whether it belongs in local or shared domain.
- If an existing interface could be extended instead of creating a new one, flag that.

## Output

```markdown
# Interface Scout Report

## Existing Patterns Found
| Interface | Location | Methods | Adapters |
| ...

## Proposed Interfaces
### 1. {InterfaceName}
{full proposal}

## Domain Type Decisions
- {type} -> local / shared (with justification)
```

## Rules

- READ-ONLY. Never modify files.
- ALWAYS reference existing interfaces as pattern examples.
- ALWAYS check shared domain before proposing new types.
- Default domain placement is app-local. Shared requires justification.
