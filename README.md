# AI Skills Library

Reusable rules, skills, and agents for AI coding assistants, shared across projects via symlinks.
A `project.yaml` config in each target project adapts behavior to local conventions.
Harness-agnostic - works with Claude Code, Cursor, Windsurf, Aider, or any tool that reads markdown instructions.

## Install

```bash
./install.sh [--force] [--config-dir DIR] [--example cinos|node-react] /path/to/project
```

Symlinks `skills/` and `agents/` into the target project's config directory (default: `.ai/`).
Optionally copies a starter `project.yaml` from examples.

For specific harnesses:
```bash
./install.sh --config-dir .claude --example cinos /path/to/project   # Claude Code
./install.sh --config-dir .cursor --example cinos /path/to/project   # Cursor
./install.sh --example cinos /path/to/project                        # Default (.ai/)
```

Or copy only what you need - skills and agents are independent.

## Structure

```
rules/          Always-loaded conventions (~50-75 words each, ~500 tokens total)
skills/         On-demand workflows invoked by name
agents/         Orchestrators that combine skills + tools for larger tasks
examples/       Starter project.yaml configs for different stacks
```

## When to add what

| Add a... | When... |
|----------|---------|
| **Rule** | It's a constraint the AI must respect in every code change. Short, declarative, always in context. |
| **Skill** | It's a multi-step procedure invoked on demand (verification, generation, analysis). Has defined inputs/outputs. |
| **Agent** | It orchestrates multiple skills and tools to complete a larger task. Has tool declarations and memory. |

Decision test:
- "Always respect this" -> rule
- "Run this when I ask" -> skill
- "Do this whole job for me" -> agent

## Rules (always loaded)

| Rule | Purpose |
|------|---------|
| adapter-conventions | Constructor config, destroy(), healthCheck(), composition root wiring |
| barrel-exports | Public API boundary enforcement |
| domain-purity | Inner layer isolation, no infra imports, no persistence fields |
| error-handling | Error style enforcement (result/throw/error-values) |
| layer-boundaries | Strict inward-only dependency direction |
| naming-conventions | File and symbol naming with pattern expansion |
| observability | Structured logging, no console.log |
| branch-naming | Git branch format from ticket, derived username from git config |
| testing-contract | Test coverage, mock patterns, integration guards |

## Skills (on-demand)

| Skill | Purpose |
|-------|---------|
| check-conventions | Validates code against all project conventions (grep-based) |
| check-config | Validates project.yaml is well-formed |
| ddd-scaffold | Generates DDD file structure for a new feature |
| interface-scout | Finds existing patterns and proposes new interfaces |
| pr-description | Generates PR body from branch diff |
| run-and-fix | Runs quality gates, auto-fixes, retries, coverage + git hygiene |
| audit-prompt | Generates self-contained audit prompt for independent review |

## Agents (orchestrators)

| Agent | Purpose |
|-------|---------|
| adapter-implementer | Implements infrastructure adapters for port interfaces |
| domain-implementer | Implements pure domain/business logic |
| task-breaker | Decomposes use cases into ordered implementation plans |
| test-author | Writes comprehensive tests with coverage gates |

## Configuration

Each project needs a `project.yaml` in its config directory. See `project.schema.yaml` for
the full schema and `examples/` for real configs.

The `config_dir` field in project.yaml tells skills where to look (default: `.ai/`).
Override it if your harness uses a different directory.

Configs covering:
- `project.cinos.yaml` - Deno monorepo, port/adapter, Result<T,E>
- `project.node-react.yaml` - Node/pnpm, layered, throw-based errors

## Adding a new project

1. Run `./install.sh --example cinos /path/to/project`
2. Edit `project.yaml` with your conventions
3. Done - skills auto-adapt to your config
