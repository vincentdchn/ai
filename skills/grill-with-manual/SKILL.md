---
name: grill-with-manual
description: Grill a business, product, sales, pricing, or customer decision against the project's startup operating manual. Use for interview prep, scope calls, pricing, hiring, or stop/continue decisions.
disable-model-invocation: true
---

Run a `/grilling` session with the project's operating manual as the reference.

1. Find the manual (`docs/*operating-manual*.md`). If none exists, say so and run plain `/grilling`.
2. Read the manual's headings. Pick the sections that match the topic. Read those sections in full before the first question.
3. Before asking, check the project's decision sources the manual names (open questions, ADRs, research, transcripts). Never ask what they already answer.
4. Each question cites the manual section it comes from and gives a recommended answer grounded in repo evidence.
5. Flag every failure mode or pitfall the manual lists that the current plan triggers.
6. Record outputs in the manual's own templates (interview plan, assumption log, decision log, etc.). Don't invent new formats.
7. Mark each claim as evidence, practice, or hypothesis, as the manual does.
