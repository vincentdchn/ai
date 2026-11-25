---
description: Name code identifiers so readers can find the right code and understand it without reading the implementation.
globs:
  - "**/*.{ts,tsx,js,mjs,cjs,py,rs,go,java,kt,cs}"
condition: '.+'
scope:
  - "tool:edit(**)"
  - "tool:write(**)"
interruptMode: always
---

# Identifier naming

Use text search to find existing vocabulary and literal strings. Use the language server to resolve symbols and references. The [`naming-identifiers` skill](../skills/naming-identifiers/SKILL.md) covers how to choose, audit, and rename identifiers.

Apply these conventions to names you add or change:

- Search for the concept before naming it. Reuse the term from the repository's glossary or code. A synonym splits later searches.
- Name values by what they represent, such as `pendingInvoices`. Keep role names such as `result`, `data`, `item`, and `response` for short scopes where the meaning is clear.
- Use a domain term in an exported name. `Invoice` can stand alone, and `createClient` is easier to find than `create`. Search for the name and qualify it if the hits mix unrelated concepts.
- Put enough context in the symbol name to make a search hit understandable without its folder path.
- Start an action function with a verb. Name the object when the receiver does not supply it, as in `validateSupplierIban`. Give each verb one meaning across the codebase.
- Name all behavior a caller must know about. Rename or split a `get` function that writes data.
- Use positive names for booleans, such as `isActive` and `hasPermission`. Avoid `isNotValid`, which requires a double negative when negated.
- Include the unit in a quantity name, such as `timeoutMs` or `maxFileSizeBytes`.
- Spell out words unless the abbreviation is an established term, such as `id`, `url`, or `http`.
- Use domain names for files, such as `billing-plan-config.ts`. Avoid generic names such as `utils.ts`, `types.ts`, and `config.ts` unless the project or framework requires them.
- Keep each event name, error code, and stable log message searchable as a full literal. Log runtime values separately when the logger supports structured fields.

Keep renames inside the task:

- If a behavior or scope change makes a name inaccurate, update the name in the same change.
- If you notice an unrelated naming problem, report it without renaming it.

Follow the project's casing and naming exceptions. For example, a project can use `handler` for Lambda entry points.
