---
name: pr-description
description: Draft a PR body from the actual branch diff, target base, and project template without publishing it.
---

# PR description

Draft only. Do not edit files, run checks, commit, push, or create a PR.

## Resolve the branch and template

1. Identify the current or requested branch and any existing PR.
2. Use the caller's requested base or the actual PR target. Otherwise resolve the base from repository instructions and branch metadata.
3. Find and read the applicable project PR template and contribution guidance. Respect template selection when the repository provides several.
4. If the base or template choice remains ambiguous after inspection, ask rather than assume.

Read the commits and merge-base diff for the resolved base and branch. Do not use a fixed default branch.

For a prospective branch PR, exclude uncommitted work from claims about the branch. If the user explicitly requests a draft for uncommitted changes, identify it as a prospective draft. If the requested branch comparison is empty, report that fact instead of inventing a PR body.

## Write the body

- Use the project's template headings and required fields. Do not replace them with a personal format.
- Explain the change and its reason from the diff, task, and commits. Group related behavior rather than listing every file.
- Fill verification fields with observed results only. Distinguish passed, failed, and unrun checks.
- Include manual verification evidence only when the template requests it. Never check an acceptance box without evidence.
- Preserve required issue links, rollout notes, and risk disclosures when supported by the available context.

If the project has no template, use a short summary and relevant observed check results. Do not add an automatic manual test plan or evidence checklist.

Read `rule://writing-style`, or [the local writing policy](../../rules/writing-style.md) when that URI is unavailable. Apply [technical-writing](../technical-writing/SKILL.md) to the PR prose.

Output only the PR body as plain Markdown. Do not wrap it in a code fence. If missing information prevents an honest draft, report the specific blocker instead.

Drafting grants no commit or publication authority. Follow the global [authorization policy](../../AGENTS.md). Failed or unrun required checks still block commit and publication.
