---
name: check-conventions
description: Review scoped changes against documented repository conventions and established local patterns.
---

# Check conventions

Read-only analysis. Do not modify code, run quality gates, commit, or publish.

## Identify the scope and standards

1. Use the caller's file list, diff, or review range. With no scope, review staged and unstaged changes, plus task-related untracked files.
2. For a branch comparison, use the caller's base, actual PR target, or repository-native base. Never assume a default branch or substitute the previous commit.
3. Read applicable repository instructions, contribution guidance, tool configuration, and nearby implementations.
4. Select only conventions relevant to the changed code. If the caller requests `--only=<conventions>`, limit the review accordingly.

Accept `--files=<paths>` to narrow the scope. Read context and relevant callers when needed to understand a changed line.

Prefer an explicit local rule over an inferred pattern. If there is no written rule, cite representative implementations and label the convention as inferred. When local examples disagree, report the uncertainty rather than invent a standard.

## Assess each candidate

- Check the complete expression, import, function, or test before reporting a violation.
- Explain how the changed code conflicts with a cited local convention.
- Consider exceptions, generated code, and the surrounding implementation.
- Treat regex matches as leads, not proof. Do not infer behavior, dependency direction, or test coverage from filenames or text matches alone.
- Do not impose an architecture, error style, naming system, or test layout that the target project does not use.

Focus on violations introduced by the scoped changes. Mention older code only when it explains a concrete regression. Do not request stylistic changes already enforced by tooling unless observed failures are relevant to the task.

## Report evidence

State the files or range reviewed and the standards consulted. For each finding, include:

- The changed `file:line`.
- The convention source and relevant line or configuration key.
- The conflict and its practical consequence.
- A concrete correction and severity based on that consequence.

Separate documented violations from inferred-pattern suggestions. Do not declare a generic rule category blocking.

If no supported violation is found, say so. If evidence is missing, name the limitation instead of reporting a pass. This review does not replace the project's checks or clear failed or unrun gates.

Read `rule://writing-style` before reporting, or use [the local writing policy](../../rules/writing-style.md) when that URI is unavailable. Follow the global [authorization policy](../../AGENTS.md).
