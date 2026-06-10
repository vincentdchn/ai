---
description: Enforce strict inward-only dependency direction between architecture layers
---

Architecture pattern is defined in `project.yaml` -> `architecture.pattern`.

Dependency direction is strict and inward-only:
- Domain (architecture.domain_dir) depends on nothing
- Ports (architecture.ports_dir) depend on domain only
- Adapters (architecture.adapters_dir) depend on ports, never the reverse
- Only architecture.composition_root imports from both ports and adapters

No file outside composition_root may wire an adapter to a port.

If no project.yaml exists, infer architecture from directory structure and imports.
