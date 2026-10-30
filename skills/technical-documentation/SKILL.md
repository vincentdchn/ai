---
name: technical-documentation
description: "Optional ambiguity review of supplied English text. Use when explicitly asked to simplify dense wording, remove ambiguity, or provide a before-and-after rewrite. Not an automatic writing policy."
version: 0.2.0
---

# Review text for ambiguity

Use this mode when a reader could misinterpret an instruction, a tool description, an error message, or an agent handoff. Apply it to the supplied text, not to every conversation or document by default.

Read `technical-writing` for the canonical technical-prose rules. That skill reads `unslop` once per session for voice. This skill adds a review workflow, not another STE rule catalog.

## Preserve the meaning

1. Read the whole input before editing. Identify its reader, purpose, facts, conditions, and scope.
2. Flag specific ambiguities. Look for unclear actors, pronouns with multiple possible antecedents, noun strings, misplaced qualifiers, and instructions with unclear order.
3. Rewrite only where the change improves understanding. Preserve technical terms, numbers, safety conditions, exceptions, and uncertainty.
4. If the intended meaning cannot be recovered from the supplied context, state the possible readings. Do not silently choose one.
5. Leave clear sentences unchanged. Do not shorten a sentence at the cost of precision.

Keep the target repository's terminology and formatting. Do not impose a restricted word dictionary or ban a grammatical tense merely because a controlled-language standard does so.

## Return the requested form

For a requested rewrite, return the edited text. For a requested review or before-and-after comparison, use this form:

| Ambiguity | Original | Rewrite |
| --- | --- | --- |
| Unclear actor | The file is removed after validation. | After the validator accepts the file, the importer removes it. |

The example assumes the supplied context identifies the validator and importer. Never add actors or behavior without that evidence.

Mention any unresolved interpretation or any longer wording retained to protect precision. If the input needs no changes, say so without inventing violations.

## Boundaries and sources

Do not flatten creative or persuasive copy unless the user asks for that trade-off. Do not claim ASD-STE100 certification or compliance. Exact approved terminology for regulated documentation requires the official standard and domain review.

Consult the [official ASD-STE100 site](https://www.asd-ste100.org/) when exact standard requirements matter. The canonical transferable prose guidance lives in `technical-writing`.
