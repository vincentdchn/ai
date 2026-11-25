# Naming reference

## Verbs

| Verb | Meaning |
| --- | --- |
| `get` | Reads local or in-memory state without I/O. |
| `fetch` | Reads from a remote source, such as an HTTP service. |
| `find` | Searches a collection. An empty result is normal. |
| `load` | Reads from disk or a persistent store. |
| `parse` | Converts raw text or bytes to a typed structure. |
| `validate` | Checks a value without changing it. |
| `ensure` | Creates or fixes a resource if needed. A second call leaves a valid resource unchanged. |
| `build` | Assembles a value in memory without I/O. |
| `create` | Brings a new entity into existence. The opposite is `delete`. |
| `add` | Puts an item into a collection. The opposite is `remove`. |
| `format` | Converts a typed structure to a display string. |
| `serialize` | Converts a typed structure to a wire format. |

## Patterns

| Kind | Pattern | Example |
| --- | --- | --- |
| Boolean state | `is` + adjective | `isActive` |
| Boolean possession | `has` + noun | `hasPermission` |
| Boolean ability | `can` + verb | `canRetry` |
| Boolean policy | `should` + verb | `shouldNotify` |
| Boolean parameter | The caller's choice | `includeArchived` |
| Collection | Plural noun | `suppliers` |
| Filtered collection | Qualifier + plural noun | `blockedSuppliers` |
| Map | Value + `By` + key | `supplierById` |
| Member | No repetition of the owner name | `invoice.total` |

Type suffixes such as `Dict`, `Str`, and `List` repeat information when the type already conveys it.

## Audit severities

| Severity | Failure | Example |
| --- | --- | --- |
| Critical | The name misstates the behavior. | `getSupplier` writes to the database. |
| Critical | Different names make one concept look like separate concepts. | `orgId` and `organizationId` refer to the same organization ID in one module. |
| Major | The name describes a code role rather than a domain concept. | `result`, `data`, `response`, or `item` in a wide scope. |
| Major | Search hits for an exported name or a file name mix unrelated concepts. | `create`, `validate`, or `config.ts`. |
| Minor | The name uses a nonstandard abbreviation, repeats its type, omits a unit, or uses a negative form. | `cfg`, `userList`, `timeout`, or `isNotValid`. |
