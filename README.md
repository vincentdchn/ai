# Personal AI configuration

Personal instructions, writing skills, and reusable workflows for coding assistants. Project architecture, commands, dependencies, and product decisions belong to the target repository.

## Read the relevant source

| Source | Owns |
| --- | --- |
| [AGENTS.md](AGENTS.md) | Language, collaboration, review checkpoints, authorization, and learning |
| [Documentation conventions](rules/documentation.md) | Canonical sources, current-state docs, and code comments |
| [Verification policy](rules/verification.md) | Evidence required before an implementation handoff |
| [Writing policy](rules/writing-style.md) | Routing to the canonical writing skills and delegated-writer instructions |
| [Unslop](skills/unslop/SKILL.md) | Voice, filler, and AI-pattern guidance |
| [Technical writing](skills/technical-writing/SKILL.md) | Document structure and technical prose |
| `skills/` | On-demand procedures that follow the target project's conventions |
| `agents/` | Reviewer definitions for explicit delegation |

The root instructions give the starting rules and link to the details. Workflows read repository evidence rather than requiring a separate project configuration. The approach follows [AI Hero's progressive-disclosure guidance](https://www.aihero.dev/a-complete-guide-to-agents-md).

## Install the personal sources

Run from this checkout:

```bash
./install.sh
```

The installer links `AGENTS.md` to `~/.claude/CLAUDE.md`, and links `rules/`, `skills/`, and `agents/` into `~/.claude/`. It also links each personal rule into `~/.omp/agent/rules/`.

Existing paths must already resolve to the same source. Conflicting files, directories, and links are preserved, and installation stops before creating links. Broken omp rule links are removed only when they point into this checkout's `rules/` directory. Custom rules and links to other sources remain intact.

To use other global configuration directories, supply absolute paths:

```bash
./install.sh --claude-dir /path/to/claude-home --omp-dir /path/to/omp-agent
```

The defaults are based on `HOME`, not an active host profile. An Orca profile that imports `~/.claude/CLAUDE.md` can keep its import file. Reload the host or start a new session to load changed instruction and skill inventories. Other hosts need their own supported import or link configuration; the installer does not edit their settings.

## Use a workflow when needed

- [Implement](skills/implement/SKILL.md) follows an agreed task and review checkpoints.
- [Run and fix](skills/run-and-fix/SKILL.md) discovers exact project checks and reports their results.
- [Audit](skills/audit/SKILL.md) reviews a supplied scope, including staged and unstaged work by default.
- [Code review](skills/code-review/SKILL.md) separates standards review from specification review.
- [PR description](skills/pr-description/SKILL.md) drafts from the actual diff and project template without publishing.
- [Technical documentation](skills/technical-documentation/SKILL.md) reviews supplied text for ambiguity on request.
- [Vault notes](skills/vault-notes/SKILL.md) updates a supplied vault only within an explicit note-update request or active vault workflow.

Planning, domain-language, and tracker-setup skills are optional procedures, not prerequisites for ordinary work. Do not run a fixed agent pipeline or impose a library's architecture on every project.

## Maintain one owner

Keep personal preferences here, product facts in their project, and machine facts in operating documentation. Reuse an existing skill before adding another incident-derived recipe. Reference canonical policies instead of copying their rule catalogs into workflows.

A plan approval does not authorize commits or publication. The complete boundaries live in [AGENTS.md](AGENTS.md#git--prs); verification requirements live in the [verification policy](rules/verification.md).
