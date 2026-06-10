---
description: Follow project.yaml naming patterns for files, classes, interfaces, errors, schemas, and adapters
---

All naming rules are in `project.yaml` -> `conventions.naming`.

Before naming any file or symbol, read the config:
- Files follow naming.files pattern
- Classes follow naming.classes pattern
- Interfaces follow naming.interfaces pattern
- Error classes end with naming.errors_suffix
- Schema types end with naming.schemas_suffix
- Adapter files follow naming.adapters_pattern

## Pattern expansion

`adapters_pattern` uses templates:
- `{service}` = lowercase external service name (e.g., `sqs`, `stripe`, `postgres`)
- `{name}` = lowercase functional name (e.g., `consumer`, `client`, `repository`)
- `{Name}` / `{Service}` = PascalCase variants

Examples with pattern `"{service}_{name}"`: `sqs_consumer.ts`, `stripe_client.ts`
Examples with pattern `"{Name}{Service}"`: `ConsumerSqs.ts`, `ClientStripe.ts`

If no project.yaml exists, infer from existing files in the project.
