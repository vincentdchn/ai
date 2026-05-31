# Global Instructions

## Language

- **All generated content must be in English** — PR descriptions, commit
  messages, code comments, Slack drafts, reports, documentation. No exceptions
  regardless of conversation language.

## Writing Style

All generated text (messages, docs, Slack drafts, reports, PR descriptions):

- **Short sentences. No filler.** Every word earns its place.
- **No AI verbosity** — no "I'd be happy to", no "Here's a comprehensive
  overview", no transitional fluff.
- **Structure over prose** — bullets > paragraphs. Tables > lists when
  comparing.
- **One idea per sentence.** If a sentence has "and" + "also" + a subordinate
  clause, split it.
- **No hedging without reason** — "I recommend X" not "You might want to
  consider perhaps trying X".
- **Front-load the point** — lead with the conclusion/action, context follows
  only if needed.
- **Match the medium**: Slack = 1-3 lines max per thought. Docs = surgical
  sections. Email = action first, context below.
- **No em dashes (—)** — use regular dashes (-) or rewrite the sentence instead.

## Documentation

- **Single source of truth** - every fact lives in exactly one place. If
  something is documented in a file header, code, or schema, reference it rather
  than repeating it. Duplication means multiple places to update.
- **Document all public symbols** - classes, interfaces, errors, functions,
  types. Not just functions.
- **Focus on when/why, not what** - the signature already tells what it does.
  Explain when it happens, what triggers it, what conditions produce it.
- **Errors get production context** - document real triggers (OOM, timeouts,
  quota exhaustion), not just "something went wrong".
- **One JSDoc block per symbol** - not a module-level summary listing
  everything.
- **Document target state only** - never reference internal phases, roadmap
  steps, or "Phase N" in code comments. The code describes what IS, not how we
  got here.

## Git & PRs

- **NEVER** add a `Co-Authored-By` line to commit messages.
- **NEVER** add "Generated with Claude Code" or any AI attribution footer to PR
  descriptions.

## Self-Improvement

### On user corrections

After every user correction, run this inline (same turn, after fixing the
immediate issue):

1. **Triage**: Can this correction be expressed as a generalizable rule beyond
   this specific moment? If no, stop.
2. **Persist**: Pick the best mechanism - memory (soft recall), CLAUDE.md (hard
   rule), hook (enforcement), skill (workflow), or settings (permissions/env).
3. **Propose**: State what you'd persist and where. Apply only after user
   approval.
4. **Conflicts**: If the new rule contradicts an existing one, replace it with a
   "supersedes" note explaining why.

### On command errors (end-of-session review)

Before wrapping up a long session (5+ tool calls), self-review Bash commands
that failed:

1. **Detect patterns**: Did the same command fail multiple times? Was a wrong
   flag, syntax, or path used before finding the correct one?
2. **Extract the fix**: Identify the correct command/syntax that eventually
   worked.
3. **Save to memory**: If the error is likely to recur (tool-specific syntax,
   platform quirk, non-obvious flag), save a memory of type `feedback` with the
   correct command and why the naive attempt fails.
4. **Skip if trivial**: Typos, one-off path mistakes, or context-dependent
   failures (file didn't exist yet) don't need saving.
