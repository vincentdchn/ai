---
name: pr-description
description: Generates a PR description from the current branch diff and project conventions. Output is a ready-to-use markdown body.
---

# PR Description

Generates a pull request body from the current branch changes.

## Step 1: Gather context

```bash
git log --oneline main..HEAD
git diff --stat main...HEAD
git diff main...HEAD
```

Read the project's instructions file for conventions and PR expectations.

## Step 2: Analyze changes

Group changes by area:

- Which layers were touched (domain, ports, adapters, tests)
- What's new vs what's modified
- What the commit messages say about intent

## Step 3: Generate PR body

Output a fenced markdown block with this structure:

```markdown
## Summary

1-3 bullet points. What changed and why.

## Changes

Group by area (not by file). Each group gets 1-2 lines:

- **Domain**: added X entity, updated Y validation
- **Adapters**: new SQS consumer for Z
- **Tests**: unit + integration coverage for the above
```

## Rules

- Short sentences. No filler. Every word earns its place.
- Lead with what matters to the reviewer, not implementation details.
- Group by logical area, not by file path.
- Include the test plan - reviewers need to know what was verified.
- Output ONLY the PR body markdown. No preamble, no explanation around it.
- If there are no commits ahead of main, say so and stop.
