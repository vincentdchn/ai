# Domain Purity

Purity constraints are in `project.yaml` -> `conventions.domain_purity`.

Domain code (architecture.domain_dir and architecture.shared_domain_dir) is the
innermost layer:
- No imports from adapters_dir or ports_dir
- No imports matching any entry in domain_purity.no_infra_imports
- If no_persistence_fields: true - no DB keys, storage paths, queue handles, TTLs
- Domain entities contain business identity + business attributes only

When adding shared domain types: default to app-local. Only use shared_domain_dir
if consumed by multiple apps today.

Port interfaces (architecture.ports_dir) must contain no vendor/SDK types
(e.g., AWS, Azure, GCP, database drivers). Ports define contracts in domain terms only.

If no project.yaml exists, infer domain boundaries from directory structure and imports.
