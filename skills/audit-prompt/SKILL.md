---
name: audit-prompt
description: Generates a self-contained audit prompt for an independent agent to review work. Output is a ready-to-run prompt, not the audit itself.
---

# Audit Prompt Generator

Generates a complete, self-contained prompt that another agent can use to independently review the current changes.

## Step 1: Gather context

```bash
git diff --stat HEAD~1
git log --oneline -3
```

Read the project's instructions file for conventions.

## Step 2: Generate audit prompt

The output prompt must include:
- What files were changed and why (from commit messages)
- The project's conventions to check against (from the instructions file)
- Specific things to verify: naming, architecture, error handling, test coverage
- Instructions to report findings with file:line format

## Step 3: Output format

Output the prompt as a fenced code block that can be copy-pasted into a new agent session.

The prompt should be:
- Self-contained (no external context needed)
- Specific (references actual file paths and conventions)
- Actionable (tells the reviewer exactly what to check)
- Objective (check conventions, not style preferences)

## Rules

- The output IS the prompt, not the audit itself.
- Include enough context that the reviewer doesn't need to ask questions.
- Reference specific conventions from the project's instructions file.
- Do not include subjective or opinion-based review criteria.
