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

## Banned words

Never use: delve, foster, leverage, utilize, facilitate, empower, streamline, robust, cutting-edge, paradigm shift, game changer, tapestry, realm, beacon, multifaceted, meticulous, intricate, paramount, transformative, elevate, embark, supercharge, harness, ever-evolving, seamless, comprehensive.

Cut when they add nothing: just, literally, honestly, simply, actually, truly, fundamentally, importantly, crucially, inherently, inevitably. Same for the phrases "it's worth noting", "at the end of the day", "when it comes to", "in today's world", "the reality is", "in order to", "going forward".

## Patterns to cut

- **Binary contrasts** - "It's not X, it's Y." State Y directly.
- **Colon reveals** - "The detail that makes it work: X." Rewrite as a plain sentence.
- **Importance puffery** - "marks a pivotal moment", "underscores its significance", "stands as a testament". State the fact, skip the verdict.
- **Weasel attribution** - "experts agree", "studies show" with no named source. Name the source or cut the claim.
- **Superficial analysis** - trailing "-ing" clauses that gesture at meaning ("highlighting the team's commitment"). State the mechanism instead.
- **Summary-recap endings** - "In conclusion", "Overall", restating what was just said. End on the last concrete point or next action.
- **Fake-profound kickers** - a closing metaphor/aphorism for effect. Delete it; end on the clearest concrete line already in the text.

## Enforcement for subagents

Subagents spawned via Task/Agent start blank - they do NOT inherit `~/.claude/CLAUDE.md`. Any skill that spawns a subagent to produce text a human will read (review findings, PR bodies, reports) MUST paste this ruleset into that subagent's prompt, or explicitly instruct it to read `rule://writing-style` before writing. A pointer alone is not enough if the subagent has no reason to resolve it.
