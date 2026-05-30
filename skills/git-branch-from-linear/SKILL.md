---
name: git-branch-from-linear
description: Creates a git branch from a Linear issue with project-configured naming convention.
---

# Git Branch from Linear

Creates a correctly named branch from a Linear issue.

## Step 1: Load project config

Read `project.yaml` -> `git` section:
- `branch_format`: e.g., "{username}/{ticket}-{slug}"
- `ticket_prefix`: e.g., "CIN", "PROJ"

## Step 2: Get issue details

Use Linear MCP to fetch the issue:
- Issue identifier (e.g., CIN-123)
- Issue title

## Step 3: Generate branch name

Apply `branch_format` template:
- `{username}` -> git config user (short form, e.g., "vincentdchn")
- `{ticket}` -> lowercase issue identifier (e.g., "cin-123")
- `{slug}` -> kebab-case from title, max 40 chars, no trailing dash

Example: `vincentdchn/cin-123-implement-circuit-breaker`

## Step 4: Create branch

```bash
git checkout -b {branch_name}
```

## Step 5: Output

Report the branch name created. Remind the user to push and create a draft PR when ready.

## Rules

- ALWAYS lowercase the ticket identifier.
- ALWAYS truncate slug to keep total branch name under 80 chars.
- NEVER create a branch if uncommitted changes exist (warn the user first).
- Strip special characters from slug (keep only [a-z0-9-]).
