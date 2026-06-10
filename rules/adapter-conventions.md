---
description: Adapter structure requirements - config injection, destroy/healthCheck methods, composition root wiring
globs:
  - "**/adapters/**"
  - "**/infrastructure/**"
---

Architecture paths are in `project.yaml` -> `architecture`.

Every adapter in adapters_dir must:
- Constructor takes a config/options object. Never read env vars inside the adapter.
- Expose `destroy()` for resource cleanup (clients, connections, intervals).
- Expose `healthCheck()` for lightweight connectivity verification.
- Be wired exclusively in architecture.composition_root (nowhere else imports + instantiates adapters).

If no project.yaml exists, infer adapter patterns from existing code in the project.
