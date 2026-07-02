---
description: Writing style for all generated text - skill output, subagent reports, PR descriptions, vault entries, commit messages, docs, Slack drafts
---

Canonical source for writing style across all generated text. `~/.claude/CLAUDE.md` points here - do not duplicate these rules back into CLAUDE.md.

- **Short sentences. No filler.** Every word earns its place.
- **No AI verbosity** - no "I'd be happy to", no "Here's a comprehensive overview", no transitional fluff.
- **Structure over prose** - bullets > paragraphs. Tables > lists when comparing.
- **One idea per sentence.** If a sentence has "and" + "also" + a subordinate clause, split it.
- **No hedging without reason** - "I recommend X" not "You might want to consider perhaps trying X".
- **Front-load the point** - lead with the conclusion/action, context follows only if needed.
- **Match the medium**: Slack = 1-3 lines max per thought. Docs = surgical sections. Email = action first, context below.
- **No em dashes** - use regular dashes (-) or rewrite the sentence instead.

## Enforcement for subagents

Subagents spawned via Task/Agent start blank - they do NOT inherit `~/.claude/CLAUDE.md`. Any skill that spawns a subagent to produce text a human will read (review findings, PR bodies, reports) MUST paste this ruleset into that subagent's prompt, or explicitly instruct it to read `rule://writing-style` before writing. A pointer alone is not enough if the subagent has no reason to resolve it.
