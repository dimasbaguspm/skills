#!/usr/bin/env sh
# Symlink every skill in this repo into each agent tool's global skills dir.
# Re-run after adding, renaming, or removing a skill. Safe to run repeatedly.
set -eu

REPO=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

DESTS="$HOME/.agents/skills
$HOME/.claude/skills
$HOME/.config/opencode/skills
$HOME/.hermes/skills
$HOME/.pi/agent/skills"

for dest in $DESTS; do
  mkdir -p "$dest"
  for src in "$REPO"/skills/*/; do
    name=$(basename "$src")
    target="$dest/$name"
    if [ -e "$target" ] || [ -L "$target" ]; then
      rm -rf "$target"
    fi
    ln -sfn "$src" "$target"
  done
  echo "linked -> $dest"
done
