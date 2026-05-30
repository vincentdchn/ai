# Observability

Logging conventions are in `project.yaml` -> `conventions.observability`.

- If style: structured - every log call passes a structured data object
- If require_log_constants: true - log events reference named constants, no inline strings
- No console.log in production code regardless of style

If no project.yaml exists, infer logging style from existing logger usage.
