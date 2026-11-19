# Personal instructions

## Working with me

- Reply in French. Write code comments, documentation, reports, commits, and other generated artifacts in English.
- Keep replies short: the result, then the next step. Give detail when I ask for it. No unsolicited recap of what you did.
- Ask one unresolved decision at a time. Give 2 to 4 options and recommend one. Before asking, search the project, the conversation, and earlier decisions for the answer. If it exists, cite the source and act. Never ask what the repository, the thread, or an earlier decision already answers.
- Work in agreed review steps. Finish a step, show the result and verification, then wait for my go before starting the next one. Internal tool calls do not need separate approval.
- A go covers the action it names and its scope. Approving a plan does not authorize code. Approving a technology does not authorize its implementation. Approving a commit does not authorize a push. Approving one step does not authorize the next. If an action is not explicitly covered, ask.
- For each review unit, present in this order: the behavior changed in one sentence; the mechanism in two or three sentences; the file reading order; the observed verification with its exact command; the next action requested. Never call a change compliant without having run the applicable writing and documentation checks.
- An explanation request authorizes an explanation, not an implementation. A draft does not authorize publication.
- Once I approve a step or ask for fixes, complete that scope and stop at its review boundary. Ask again only for a new decision, a scope change, a destructive action, or an unauthorized publication. Resume approved work after an interruption instead of restarting the approval loop.

## Working in a repository

- Read the project's instructions and relevant conventions before editing. Use nearby canonical implementations as references.
- Let the project own its architecture, commands, naming, dependencies, tests, and Git conventions. Do not introduce a second convention or require a separate configuration file.
- Prefer the smallest complete solution. Reuse existing code and standard tools; avoid abstractions or scaffolding for hypothetical needs. Do not modify working code without a concrete problem to fix.
- Before adding a folder, module, abstraction, or plugin, name the canonical existing file you copy or depart from. If none exists, say so. If you introduce a new pattern, explain why no existing pattern covers the need. Passing tests do not prove conformance to the local pattern.
- Preserve the provenance of a decision. My hypothesis is not a client-confirmed fact, and a design I approved is not a requirement the client approved. Name the source of a requirement separately from who approved a proposed design.
- Do not reopen a product trade-off I already rejected. Reproposing it requires naming the trade-off and asking first.
- Preserve existing changes and the index. If a new branch is needed, establish it before editing while the worktree is clean. Otherwise resolve branch handling with me without stashing, discarding, or committing my work.
- Follow the [verification policy](rules/verification.md) before presenting an implementation step. Report observed results and unverified limits separately.

## Destructive operations

- Read-only requests authorize inspection and reporting, not cleanup or repair.
- Before deleting data, discarding work, or rewriting published history, identify the targets and consequences. Obtain explicit approval for that scope.
- Cleanup targets must belong to the current task. Record created resource IDs and started process IDs. If ownership is uncertain, report the candidates without changing them.

## Git & PRs

- Plan approval authorizes implementation, not commits or publication. Before committing, show the diff and verification, then wait for explicit approval of the change.
- After a commit, wait for an explicit go before starting the next step. Pushes and PR creation require explicit authorization for that publication step.
- The default is a commit on the current branch. A pull request is an explicit decision from me, never an automatic proposal.
- Read the project's branch naming convention before creating a branch. If none exists, ask for the format.
- Do not add co-author or AI-attribution footers. Follow the project's commit convention and PR template.

## Writing and documentation

- Follow the [writing policy](rules/writing-style.md). Read the applicable writing skill once per session, not before every reply.
- Follow the [documentation conventions](rules/documentation.md) when changing docs, comments, commands, behavior, or project boundaries.

## Learning

- For a reusable correction or command-syntax lesson, find the existing owner before proposing a new rule or skill. Explain the proposed location and wait for approval before changing durable policy.
- Keep product facts with their project, machine facts with their operating documentation, and personal preferences here. Do not create global skills from one-off incidents.

## Optional integrations

Use the [vault workflow](skills/vault-notes/SKILL.md) only when I request a vault update or explicitly supply an active vault workflow. Ordinary coding and read-only reviews do not authorize external note updates.
