#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
OMP_DIR="$HOME/.omp/agent"

usage() {
  printf 'Usage: %s [--claude-dir DIR] [--omp-dir DIR]\n' "$0"
  printf 'Link personal instructions, rules, skills, and agents without replacing existing files.\n'
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --claude-dir|--omp-dir)
      if [[ $# -lt 2 || -z "$2" || "$2" == --* ]]; then
        printf 'ERROR: %s requires a directory.\n' "$1" >&2
        exit 2
      fi
      if [[ "$1" == --claude-dir ]]; then
        CLAUDE_DIR="$2"
      else
        OMP_DIR="$2"
      fi
      shift 2
      ;;
    --help|-h) usage; exit 0 ;;
    *) printf 'ERROR: Unknown argument: %s\n' "$1" >&2; usage >&2; exit 2 ;;
  esac
done

# Absolute paths keep the installed symlinks independent of the working directory.
if [[ "$CLAUDE_DIR" != /* || "$OMP_DIR" != /* ]]; then
  printf 'ERROR: Installation directories must be absolute paths.\n' >&2
  exit 2
fi

SOURCES=("$SCRIPT_DIR/AGENTS.md" "$SCRIPT_DIR/rules" "$SCRIPT_DIR/skills" "$SCRIPT_DIR/agents")
DESTINATIONS=("$CLAUDE_DIR/CLAUDE.md" "$CLAUDE_DIR/rules" "$CLAUDE_DIR/skills" "$CLAUDE_DIR/agents")
for source in "$SCRIPT_DIR"/rules/*.md; do
  SOURCES+=("$source")
  DESTINATIONS+=("$OMP_DIR/rules/$(basename "$source")")
done

# Detect conflicts before creating any links or removing retired links.
for index in "${!SOURCES[@]}"; do
  source="${SOURCES[$index]}"
  destination="${DESTINATIONS[$index]}"
  if [[ ! -e "$source" ]]; then
    printf 'ERROR: Missing source: %s\n' "$source" >&2
    exit 1
  fi
  if [[ -e "$destination" || -L "$destination" ]]; then
    if [[ ! "$destination" -ef "$source" ]]; then
      printf 'ERROR: Preserve existing path: %s. Resolve it before installing.\n' "$destination" >&2
      exit 1
    fi
  fi
done

mkdir -p "$CLAUDE_DIR" "$OMP_DIR/rules"
for index in "${!SOURCES[@]}"; do
  source="${SOURCES[$index]}"
  destination="${DESTINATIONS[$index]}"
  if [[ "$destination" -ef "$source" ]]; then
    printf 'Already linked: %s\n' "$destination"
  else
    ln -s "$source" "$destination"
    printf 'Linked: %s -> %s\n' "$destination" "$source"
  fi
done

# Only remove broken rule links owned by this repository, never custom rules.
for destination in "$OMP_DIR"/rules/*.md; do
  if [[ -L "$destination" && ! -e "$destination" ]]; then
    source="$(readlink "$destination")"
    case "$source" in
      "$SCRIPT_DIR"/rules/*.md)
        rm "$destination"
        printf 'Removed retired rule link: %s\n' "$destination"
        ;;
    esac
  fi
done
