---
name: merlin-sync
description: Back up the user's global ~/.claude/CLAUDE.md and ~/.claude/skills/ directory to the ~/merlin git repository, then commit and push. Use when the user says "/merlin-sync," "back up my claude config," "sync merlin," "push my skills to github," "save my global claude," or similar. CLAUDE.md is copied to ~/merlin/global-claude.md; ~/.claude/skills/ is mirrored to ~/merlin/skills/ (rsync --delete, so skills removed locally are also removed from the repo). Skips commit/push when there are no changes. Do NOT use for project-specific .claude content or for any repo other than ~/merlin.
metadata:
  version: 1.0
  last-update: 2026-05-15
  author: Batuhan Korur
---

# merlin-sync

Back up the user's global Claude config to GitHub via the `~/merlin` repo.

## What it does
1. Copies `~/.claude/CLAUDE.md` → `~/merlin/global-claude.md`.
2. Mirrors `~/.claude/skills/` → `~/merlin/skills/` using `rsync -a --delete` (skills deleted locally are removed from the repo).
3. Stages **only** `global-claude.md` and `skills/` (scoped `git add` — unrelated dirty files in `~/merlin` like README edits or untracked dirs are left alone).
4. If nothing in scope changed, prints a clean notice and exits without committing.
5. Otherwise commits with message `Updated documents YYYY-MM-DD HH:MM:SS` and `git push`es.

## How to run
Execute the bundled script:

```bash
bash ~/.claude/skills/merlin-sync/sync.sh
```

Report the script's output back to the user verbatim (commit timestamp, or "no changes" notice). If the push fails (network, auth, non-fast-forward), surface the error and do **not** retry destructively — ask the user how to proceed.

## Guardrails
- The script asserts that `~/.claude/CLAUDE.md`, `~/.claude/skills/`, and `~/merlin/.git` all exist before touching anything. If any check fails, stop and report.
- Do not pass `--force` to push. Do not amend prior commits. Do not run `git reset` or `git clean`.
- Do not invoke this skill on any directory other than `~/merlin`.
- The script's `git add` is scoped to `global-claude.md` and `skills/` only — unrelated dirty files in `~/merlin` are intentionally left untouched. Do not broaden the scope.

## When NOT to use
- Project-specific `.claude/` directories (this skill is hard-coded to the global config).
- When the user wants to pull *from* merlin to restore — this is one-way (local → repo).
- Mid-edit of a skill file — wait for a natural save point so the commit captures finished state.
