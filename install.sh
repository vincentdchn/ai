#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FORCE=false
EXAMPLE=""
CONFIG_DIR=".ai"

usage() {
  echo "Usage: $0 [--force] [--config-dir DIR] [--example cinos|node-react] /path/to/project"
  echo ""
  echo "Symlinks skills/ and agents/ into the target project's config directory."
  echo ""
  echo "Options:"
  echo "  --force           Overwrite existing symlinks"
  echo "  --config-dir DIR  Config directory name (default: .ai)"
  echo "  --example NAME    Copy an example project.yaml as starter config"
  echo "                    (cinos, node-react)"
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --force) FORCE=true; shift ;;
    --config-dir) CONFIG_DIR="$2"; shift 2 ;;
    --example) EXAMPLE="$2"; shift 2 ;;
    --help|-h) usage ;;
    -*) echo "Unknown option: $1"; usage ;;
    *) TARGET="$1"; shift ;;
  esac
done

if [[ -z "${TARGET:-}" ]]; then
  usage
fi

TARGET="$(cd "$TARGET" && pwd)"
DEST_DIR="$TARGET/$CONFIG_DIR"

if [[ ! -d "$DEST_DIR" ]]; then
  echo "Creating $DEST_DIR"
  mkdir -p "$DEST_DIR"
fi

link_dir() {
  local name="$1"
  local src="$SCRIPT_DIR/$name"
  local dest="$DEST_DIR/$name"

  if [[ -L "$dest" ]]; then
    if [[ "$FORCE" == "true" ]]; then
      rm "$dest"
      echo "Replaced symlink: $dest -> $src"
    else
      echo "Exists (skip): $dest (use --force to overwrite)"
      return
    fi
  elif [[ -e "$dest" ]]; then
    echo "ERROR: $dest exists and is not a symlink. Remove it manually."
    return 1
  fi

  ln -s "$src" "$dest"
  echo "Linked: $dest -> $src"
}

link_dir "skills"
link_dir "agents"

if [[ -n "$EXAMPLE" ]]; then
  EXAMPLE_FILE="$SCRIPT_DIR/examples/project.${EXAMPLE}.yaml"
  DEST_CONFIG="$DEST_DIR/project.yaml"

  if [[ ! -f "$EXAMPLE_FILE" ]]; then
    echo "ERROR: Example not found: $EXAMPLE_FILE"
    echo "Available: $(ls "$SCRIPT_DIR/examples/" | sed 's/project\.//;s/\.yaml//' | tr '\n' ' ')"
    exit 1
  fi

  if [[ -f "$DEST_CONFIG" && "$FORCE" != "true" ]]; then
    echo "Exists (skip): $DEST_CONFIG (use --force to overwrite)"
  else
    cp "$EXAMPLE_FILE" "$DEST_CONFIG"
    echo "Copied: $DEST_CONFIG (from $EXAMPLE example)"
  fi
fi

echo "Done."
