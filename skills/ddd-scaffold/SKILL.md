---
name: ddd-scaffold
description: Generates DDD file structure for a new feature following project architecture conventions. Adapts templates to the project's runtime, error style, and naming.
---

# DDD Scaffold

Generates the minimal file structure for a new feature following the project's architecture conventions.

## Step 1: Load project config

Read `project.yaml` (in the project's config directory) to determine:
- `runtime` and file extensions
- `architecture.*` for directory layout
- `conventions.naming.*` for file/class naming
- `conventions.error_handling.*` for error patterns
- `testing.*` for test file patterns

## Step 2: Find reference implementation

Before generating any code, scan existing implementations:

```bash
ls {ports_dir}
ls {adapters_dir}
```

Read at least one existing port + adapter pair as the concrete reference. Never invent structure from scratch - derive from real files in the repo.

## Step 3: Generate files

Based on architecture pattern and config, create:

### Port interface (`{ports_dir}/{name}.{ext}`)

- Define interface with methods returning the project's error style
- If `error_handling.style: result` -> methods return `Result<T, E>`
- If `error_handling.style: throw` -> methods throw typed errors
- Include `healthCheck()` method (for port-adapter pattern)

### Error file (`{ports_dir}/{name}_errors.{ext}`)

- If `error_handling.hierarchy: true` -> abstract base + concrete errors
- If `error_handling.base_class` defined -> extend from it
- Include contextual fields (operation, reason)
- If `require_cause_chain: true` -> include cause parameter

### Adapter (`{adapters_dir}/{service}_{name}.{ext}`)

Following `conventions.naming.adapters_pattern`:
- Implements port interface
- Constructor takes config object (no env reads)
- `destroy()` method for cleanup
- `healthCheck()` for connectivity check
- Uses project's logger/observability pattern

### Test mock (`{mock_dir}/{name}.{ext}`)

Following `testing.mock_pattern`:
- Implements the port interface
- In-memory storage
- Test control methods (setHealthy, setShouldFail, getStorage, clear)

### Test file (`{test_dir}/{name}.test.{ext}`)

- Uses project's test framework
- Imports mock
- Placeholder tests for success and failure paths

## Step 4: Domain placement decision

Before creating domain files:

1. **Is this concept specific to one app?** -> Place in `{domain_dir}` (default)
2. **Consumed by >1 app today?** -> Consider `{shared_domain_dir}` with strict rules:
   - No persistence fields (if `domain_purity.no_persistence_fields: true`)
   - Minimal fields: business identity + attributes only

## Step 5: Output

List created files and TODO markers. Suggest next step (usually adapter-implementer or test-author).

## Rules

- ALWAYS scan existing code first for patterns.
- ALWAYS follow project naming conventions from config.
- NEVER export adapters or mocks from barrel files.
- Wire adapters only in `{composition_root}`.
