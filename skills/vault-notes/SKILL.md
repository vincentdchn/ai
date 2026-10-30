---
name: vault-notes
description: Update explicitly requested project or daily notes in a supplied Obsidian vault. Do not run automatically after coding or read-only reviews.
---

# Update requested vault notes

Use only when the user requests a vault update or explicitly enables an active vault workflow. Resolve the active vault from supplied context. If its identity or write scope is missing, ask before creating or changing files. Do not assume that a hook provides it.

Read the relevant project note and its local conventions first. Apply the personal writing policy and preserve existing material. Keep vault text in English.

## Project notes

- Match supplied NEXT, WAITING, BLOCKED, and DECISION items to the requested work. Use priority and role to choose the depth of the update.
- Mark work complete only after it is genuinely completed. Add a dated entry under `# Notes Log` and update `current_state` when it meaningfully changes.
- Clear completed items, leaving `- ` for an empty section. Move items when their status changes.
- Use `- [[Person Name]] - what (since YYYY-MM-DD)` for waiting items.

## Daily notes

Read the current date and run `date +%H:%M` before writing a timestamp. Never guess it.

Add completed work under `## Daily Log` in `<vault>/Daily/YYYY-MM-DD.md` using `- HH:MM - Description ([[Project Name]])`. Do not add meetings when the vault already shows them through a query.

## Contacts and tools

Follow the vault's actual contact and tool folders. Read an existing contact when the person is relevant to the requested note update. Record newly supplied facts without inventing biographical details.

Use the vault's wiki-link convention for people and tools. Create missing contact or tool notes only within the authorized update scope. Do not create unrelated records from a passing mention.
