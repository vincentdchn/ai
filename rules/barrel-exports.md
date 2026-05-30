# Barrel Exports

Barrel file is defined in `project.yaml` -> `architecture.barrel_file`.
Exclusions are in `conventions.barrel_exports.exclude`.

The barrel file is the public API boundary. Never export anything listed in the
exclude array (typically: adapters, mocks, test_helpers, internals).

Only domain types, port interfaces, schemas, and errors belong in the public API.

If no project.yaml exists, infer barrel boundaries from existing barrel files in the project.
