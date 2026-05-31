---
name: review-errors
description: Reviews failed Bash commands in the current session, extracts patterns, and saves reusable fixes to memory.
---

# Review Errors

Scans the current conversation for Bash commands that failed. Identifies recurring patterns and saves fixes worth remembering.

## Step 1: Identify failed commands

Look through the conversation for Bash tool calls that returned non-zero exit codes or error output.

## Step 2: Filter noise

Skip:
- Typos and one-off path mistakes
- Context-dependent failures (file didn't exist yet, server wasn't running)
- Commands that failed once then succeeded with a trivial fix

Keep:
- Same command failing multiple times before finding the right syntax
- Non-obvious flags or platform-specific quirks
- Tool-specific syntax that differs from the intuitive approach

## Step 3: Extract fixes

For each meaningful pattern, identify:
- The naive command that failed
- Why it failed
- The correct command/syntax that worked

## Step 4: Save to memory

For each fix worth remembering, save a memory of type `feedback` with:
- The correct command
- Why the naive attempt fails
- When this applies (tool, platform, context)

## Rules

- Only save fixes likely to recur across sessions.
- One memory per distinct pattern. Don't bundle unrelated fixes.
- If no meaningful errors occurred, say so and stop.
