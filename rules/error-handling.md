---
description: Follow project.yaml error style - result types, error hierarchy, and cause chaining
---

Error style is defined in `project.yaml` -> `conventions.error_handling`.

Follow the configured style exactly:
- If style: result - no raw throws in application/adapter layers
- If style: throw - all thrown errors extend error_handling.base_class
- If hierarchy: true - use abstract ModuleError -> concrete SpecificError
- If require_cause_chain: true - always pass { cause } when wrapping errors
- Never throw untyped strings or bare Error instances regardless of style

If no project.yaml exists, infer error style from existing code patterns.
