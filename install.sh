#!/usr/bin/env sh
# Link this repo's skills into each agent tool's global skills dir.
#
#   ./install.sh                      from a git checkout: link that checkout
#   curl -fsSL <raw>/install.sh | sh  managed install: clone/pull, then link
#
# The managed location defaults to ~/.local/share/skills; override with
# SKILLS_DIR. Safe to re-run: existing links are replaced, other skills in the
# destination dirs are left alone.
set -eu

REPO_URL="https://github.com/dimasbaguspm/skills.git"

# Piped into sh, $0 is the shell (not a path), so fall back to a managed clone.
# Run as ./install.sh, $0 is the script, so link the checkout it lives in.
if [ -f "$0" ]; then
  REPO=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
else
  command -v git >/dev/null 2>&1 || { echo "error: git is required" >&2; exit 1; }
  REPO="${SKILLS_DIR:-$HOME/.local/share/skills}"
  if [ -d "$REPO/.git" ]; then
    echo "updating $REPO"
    git -C "$REPO" pull --ff-only
  elif [ ! -d "$REPO/skills" ]; then
    echo "cloning into $REPO"
    git clone --depth 1 "$REPO_URL" "$REPO"
  fi
fi

[ -d "$REPO/skills" ] || { echo "error: no skills/ found in $REPO" >&2; exit 1; }

DESTS="$HOME/.agents/skills
$HOME/.claude/skills
$HOME/.config/opencode/skills
$HOME/.hermes/skills
$HOME/.pi/agent/skills"

for dest in $DESTS; do
  mkdir -p "$dest"
  for src in "$REPO"/skills/*/; do
    [ -d "$src" ] || continue
    name=$(basename "$src")
    target="$dest/$name"
    if [ -e "$target" ] || [ -L "$target" ]; then
      rm -rf "$target"
    fi
    ln -sfn "$src" "$target"
  done
  echo "linked -> $dest"
done
