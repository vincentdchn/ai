---
description: Documentation ownership and current-state conventions for docs and code comments
---

# Documentation conventions

- Describe the current behavior and constraints. Keep migration history in ADRs, changelogs, or explicitly historical guides; do not turn reference docs or code comments into a change log.
- Give each fact one canonical owner. Link to that owner instead of maintaining another definition. Short routing summaries and generated views are acceptable when their source is clear.
- Keep commands with the project's scripts or command reference, architecture decisions with its decision records, and product terminology with its domain documentation. A plan is not evidence that a behavior exists.
- Explain non-obvious contracts, invariants, triggers, and real failure conditions. Do not restate signatures or require boilerplate documentation on every symbol.
- Keep a shared contract on its interface or other authoritative declaration. Implementation comments explain local reasoning, not a copy of that contract.
- Follow the project's comment style. Do not put roadmap phases, task identifiers, or implementation-plan references in comments describing current behavior.
- Update the affected documentation when behavior, commands, conventions, or boundaries change. Link from other documents instead of propagating independent copies.
- After an authorized external-service change, update the owning project's infrastructure documentation with the resulting configuration and how to inspect it. Record names and purposes, never secret values.
- Use [technical-writing](../skills/technical-writing/SKILL.md) for technical prose. Preserve exact identifiers, commands, quoted source, and API payloads.
