# AI Skills Library

Reusable rules, skills, and agents for AI coding assistants, shared across projects via symlinks.
Each target project gets a `project.yaml` that adapts behavior to local conventions.
Harness-agnostic - works with Claude Code, Cursor, Windsurf, Aider, or any tool that reads markdown instructions.

## Install

```bash
./install.sh [--force] [--config-dir DIR] [--example cinos|node-react] /path/to/project
```

Symlinks `skills/` and `agents/` into the target project's config directory (default: `.ai/`).
Optionally copies a starter `project.yaml` from examples.

```bash
./install.sh --config-dir .claude --example cinos /path/to/project   # Claude Code
./install.sh --config-dir .cursor --example cinos /path/to/project   # Cursor
./install.sh --example cinos /path/to/project                        # Default (.ai/)
```

## Structure

```
rules/          Always-loaded conventions (short, declarative)
skills/         On-demand workflows invoked by name
agents/         Orchestrators that combine skills + tools
examples/       Starter project.yaml configs
```

Each file is self-documented - read the header for purpose and usage.

## When to add what

- "Always respect this" - rule
- "Run this when I ask" - skill
- "Do this whole job for me" - agent

## Configuration

Each project needs a `project.yaml`. See `project.schema.yaml` for the full schema and `examples/` for starter configs.
