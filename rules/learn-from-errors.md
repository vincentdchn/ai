---
description: Persist correct command syntax when a command fails multiple times before finding the fix
alwaysApply: true
---

When a command fails multiple times before finding the correct syntax, persist the fix for future sessions.

What to persist:
- The correct command/syntax
- Why the naive attempt fails
- When this applies (tool, platform, context)

Skip:
- Typos, one-off path mistakes
- Context-dependent failures (file didn't exist yet, server wasn't running)
- Trivial corrections that won't recur

Persist using whatever mechanism the harness supports (memory, notes file, context). One entry per distinct pattern.
