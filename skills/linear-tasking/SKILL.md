---
name: linear-tasking
description: Creates and updates Linear issues from a task breakdown plan. Applies dependency ordering and agent assignments.
---

# Linear Tasking

Pushes an implementation plan as Linear issues with proper dependencies.

## Step 1: Load project config

Read `project.yaml` -> `git.ticket_prefix` for issue naming context.

## Step 2: Validate input

Requires a structured plan with subtasks. Each subtask needs:
- Title (plain human-readable, imperative mood)
- DDD Layer classification
- Agent assignment
- Dependencies (which subtasks it depends on)
- Acceptance criteria

## Step 3: Create issues in dependency order

For each subtask in the plan:

1. Create Linear issue with:
   - Title: plain imperative sentence (not conventional commit format)
   - Description: files to create/modify, patterns to follow, acceptance criteria
   - Labels: DDD layer (ports, adapters, domain, tests, quality)
   - Estimate: based on LOC scope (1=small, 2=medium, 3=large)

2. Set `blockedBy` relationships based on dependency graph

3. Assign to current user

## Step 4: Output

Return list of created issues with:
- Issue identifier
- Title
- Dependencies
- Link

Remind the user: each issue gets its own branch (follow branch-naming rule).

## Rules

- NEVER create issues before the plan is explicitly approved by the user.
- ALWAYS set blockedBy dependencies to enforce ordering.
- ALWAYS use plain titles, not conventional commit prefixes.
- Issues should be independently understandable and reviewable.
