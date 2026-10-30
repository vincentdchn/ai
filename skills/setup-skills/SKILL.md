---
name: setup-skills
description: Optional, user-invoked setup of repository guidance for issue tracking, triage, or domain documentation. Not a prerequisite for other skills.
disable-model-invocation: true
---

# Set up requested repository guidance

Run only when the user requests setup. Ordinary implementation, review, and writing skills work from existing repository evidence without this workflow.

## Inspect before proposing

1. Identify which topic the user wants configured: issue tracking, triage, domain documentation, or a specified combination. Do not automatically set up all three.
2. Read the repository instructions and existing guidance for that topic. Inspect the actual tracker integration, labels, glossary, and decision-record locations when relevant.
3. Use existing sources and locations. A GitHub remote does not prove that GitHub Issues is the team's tracker. A monorepo does not prove that the product has multiple domain contexts.
4. Report what is already sufficient and which requested information is missing. Do not ask the user to repeat facts available through inspection.

Ask one unresolved decision at a time, with a recommendation grounded in the repository. Do not require a tracker, label vocabulary, glossary, or ADR directory that the requested work does not need.

## Draft the smallest useful change

- Update the existing canonical source rather than creating another configuration layer.
- Reuse the repository's documentation and instruction layout. Do not require `docs/agents/`, `.scratch/`, `CONTEXT.md`, or a particular ADR layout.
- Add a short reference from existing instructions only when it improves discovery. Preserve surrounding user content and avoid duplicate setup sections.
- If no suitable source exists, propose a location and explain its purpose before creating it.
- Describe only verified conventions and approved choices. Do not document a planned layout as if it already existed.

For a requested topic with no existing convention, these optional seeds can inform the draft:

- [GitHub tracker](issue-tracker-github.md)
- [GitLab tracker](issue-tracker-gitlab.md)
- [Local Markdown tracker](issue-tracker-local.md)
- [Triage vocabulary](triage-labels.md)
- [Domain documentation](domain.md)

Adapt a seed to the approved repository choices. Its sample paths, labels, and tools are examples, not required conventions. Do not copy all seeds or execute their example procedures during setup.

## Confirm, write, and verify

Present the proposed files and content. Wait for approval of the setup changes before writing. If that exact draft is already approved, do not ask again.

Write only the approved scope. Do not create tracker issues, change remote labels, install integrations, commit, or publish as a side effect of documenting their workflow.

Check local links, names, and instructions against the actual repository. Report the files written and remaining limits. If existing guidance already satisfies the request, report that no change is needed.

Follow the [documentation conventions](../../rules/documentation.md), [writing policy](../../rules/writing-style.md), and [authorization policy](../../AGENTS.md). Read the applicable writing skill before producing prose.
