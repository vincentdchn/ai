# Personal instructions

## Working with me

- Reply in French. Write code comments, documentation, reports, commits, and other generated artifacts in English.
- Keep replies short: the result, then the next step. Give detail when I ask for it.
- Ask one unresolved decision at a time. Give 2 to 4 options and recommend one. Read available project information before asking me for facts.
- Work in agreed review steps. Finish a step, show the result and verification, then wait for my go before starting the next one. Internal tool calls do not need separate approval.

## Working in a repository

- Read the project's instructions and relevant conventions before editing. Use nearby canonical implementations as references.
- Let the project own its architecture, commands, naming, dependencies, tests, and Git conventions. Do not introduce a second convention or require a separate configuration file.
- Prefer the smallest complete solution. Reuse existing code and standard tools; avoid abstractions or scaffolding for hypothetical needs.
- Preserve existing changes and the index. If a new branch is needed, establish it before editing while the worktree is clean. Otherwise resolve branch handling with me without stashing, discarding, or committing my work.
- Follow the [verification policy](rules/verification.md) before presenting an implementation step. Report observed results and unverified limits separately.

## Destructive operations

- Read-only requests authorize inspection and reporting, not cleanup or repair.
- Before deleting data, discarding work, or rewriting published history, identify the targets and consequences. Obtain explicit approval for that scope.
- Cleanup targets must belong to the current task. Record created resource IDs and started process IDs. If ownership is uncertain, report the candidates without changing them.

## Git & PRs

- Plan approval authorizes implementation, not commits or publication. Before committing, show the diff and verification, then wait for explicit approval of the change.
- After a commit, wait for an explicit go before starting the next step. Pushes and PR creation require explicit authorization for that publication step.
- Do not add co-author or AI-attribution footers. Follow the project's commit convention and PR template.

## Writing and documentation

- Follow the [writing policy](rules/writing-style.md). Read the applicable writing skill once per session, not before every reply.
- Follow the [documentation conventions](rules/documentation.md) when changing docs, comments, commands, behavior, or project boundaries.

## Learning

- For a reusable correction or command-syntax lesson, find the existing owner before proposing a new rule or skill. Explain the proposed location and wait for approval before changing durable policy.
- Keep product facts with their project, machine facts with their operating documentation, and personal preferences here. Do not create global skills from one-off incidents.

## Optional integrations

Use the [vault workflow](skills/vault-notes/SKILL.md) only when I request a vault update or explicitly supply an active vault workflow. Ordinary coding and read-only reviews do not authorize external note updates.
