---
description: Personal writing policy and canonical skill routing for human-readable output
---

# Writing policy

- Use [unslop](../skills/unslop/SKILL.md) for human-readable output. It owns voice, filler, and AI-pattern guidance. Read it once per session.
- For technical docs, RFCs, READMEs, PR descriptions, and commit messages, use [technical-writing](../skills/technical-writing/SKILL.md). It applies unslop and owns document structure and technical prose.
- Keep the rules in those skills. Do not maintain another banned-word list, punctuation catalog, or partial STE checklist in a rule or workflow.
- Match the medium. Conversation gives the result and next step; a review reports actionable findings; a PR follows the project's template. Expand only when the reader needs the detail.
- Write on my behalf in the first person, not about me in the third person. Do not restate the diff in review comments. Put code-specific feedback inline when the available review tool supports it.
- Preserve code, configuration, logs, API payloads, exact identifiers, and quoted technical source verbatim unless their modification is the task.
- Give delegated writers an explicit instruction to read this policy and the applicable skill before writing, with resolvable paths or supplied source text. Do not assume they inherit the parent's context. A passive pointer is not a reading instruction.
