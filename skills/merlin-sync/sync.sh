#!/usr/bin/env bash
# Sync ~/.claude/CLAUDE.md and ~/.claude/skills/ to the ~/merlin repo, commit, and push.
set -euo pipefail

SRC_CLAUDE="$HOME/.claude/CLAUDE.md"
SRC_SKILLS="$HOME/.claude/skills/"
DEST="$HOME/merlin"
DEST_CLAUDE="$DEST/global-claude.md"
DEST_SKILLS="$DEST/skills/"

[[ -f "$SRC_CLAUDE" ]] || { echo "error: $SRC_CLAUDE not found" >&2; exit 1; }
[[ -d "$SRC_SKILLS" ]] || { echo "error: $SRC_SKILLS not found" >&2; exit 1; }
[[ -d "$DEST/.git" ]] || { echo "error: $DEST is not a git repository" >&2; exit 1; }

cp "$SRC_CLAUDE" "$DEST_CLAUDE"
mkdir -p "$DEST_SKILLS"
rsync -a --delete "$SRC_SKILLS" "$DEST_SKILLS"

cd "$DEST"
git add global-claude.md skills/ README.md

if git diff --cached --quiet; then
  echo "No changes to commit for global-claude.md, skills/, or README.md."
  exit 0
fi

TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"
git commit -m "Updated documents $TIMESTAMP"
git push
echo "Synced and pushed: $TIMESTAMP"
