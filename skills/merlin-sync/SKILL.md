---
name: merlin-sync
description: Back up global `~/.claude/CLAUDE.md` + `~/.claude/skills/` to the `~/merlin` git repo, sync `README.md`'s skill catalog with what's on disk, commit, and push. Operates only on `~/merlin`; ignores all other repos and project-level `.claude/`.
disable-model-invocation: true
metadata:
  version: 1.2
  last-update: 2026-05-23
  author: Batuhan Korur
---

# merlin-sync

Back up the user's global Claude config to GitHub via the `~/merlin` repo, and keep `~/merlin/README.md`'s skill catalog in sync with the skills actually present. Operational sibling to `setup-decision-docs`.

## At a glance
| Step | Action |
|------|--------|
| 1 | Reconcile `~/merlin/README.md`'s `## Skills` section against `~/.claude/skills/` |
| 2 | Run the sync script — rsync skills, copy CLAUDE.md, scoped `git add`, commit, push |
| 3 | Report commit timestamp (or "no changes") |

## Operating mode
You're a backup operator with a narrow scope. **Operate only on `~/merlin`.** Use scoped `git add` — never sweep up unrelated dirty files. Preserve the user's curated voice in `README.md`; do not regenerate from scratch. Never use destructive git operations (force push, reset, clean).

## When NOT to use
- Project-specific `.claude/` directories (this command is hard-coded to global config)
- When the user wants to pull *from* merlin to restore — this is one-way (local → repo)
- Mid-edit of a skill file — wait for a natural save point so the commit captures finished state

## Workflow

### Step 1 — README maintenance (Claude, before running the script)

Goal: keep `~/merlin/README.md`'s `## Skills` section in sync with `~/.claude/skills/`. The user curates this README with a specific voice — **preserve it**. Do not regenerate the section from scratch.

1. List `~/.claude/skills/*/SKILL.md`. That's the canonical set.
2. Read `~/merlin/README.md`. Find the `## Skills` section.
3. **Reconcile:**
	- For each skill present in `~/.claude/skills/` but **missing** from README: draft a new entry (format below) and insert it in the section. Order: decision-lifecycle skills first (literally `brainstorm` → `trade-off` → `decision-log`, in that order), then everything else **alphabetical by skill name**.
	- For each entry in README whose skill **no longer exists** in `~/.claude/skills/`: remove the entry.
	- For each existing entry that's missing the `When:` / `Result:` bullet lines required by the format: add them, **without rewriting the existing prose/metaphor**.
	- For existing entries where the bullets are present but look stale or vague: leave them alone unless they're factually wrong (e.g., reference a removed feature). Mention the staleness to the user in the report; don't silently rewrite.
	- Do not touch entries that already conform — leave the curated voice alone.
4. Use `Edit`, not `Write`. Make minimal, targeted edits.

**Entry format (mandatory):**

```markdown
### [`<skill-name>`](skills/<skill-name>/SKILL.md)
The **<one-or-two-word metaphor>**. <One sentence: what the skill does and its essence.>
- **When:** <Concrete triggers — phrases the user might say, situations where it fits.>
- **Result:** <What concrete artifact or output the user gets when the skill runs.>
```

The metaphor should fit the existing style (compass, workshop, scales, court reporter). One or two words, bold. If a skill doesn't suggest a clean metaphor, pick a noun that names its role.

If the section's intro paragraph or the decision-lifecycle arrow line (`brainstorm → trade-off → decision-log`) becomes inaccurate because skills changed, surface the inconsistency to the user — do **not** silently rewrite framing prose.

### Step 2 — Run the sync script

```bash
bash ${CLAUDE_SKILL_DIR}/sync.sh
```

Report the script's output back verbatim (commit timestamp, or "no changes" notice). If the push fails (network, auth, non-fast-forward), surface the error and do **not** retry destructively — ask the user how to proceed.

## What the sync script does

1. Copies `~/.claude/CLAUDE.md` → `~/merlin/global-claude.md`.
2. Mirrors `~/.claude/skills/` → `~/merlin/skills/` using `rsync -a --delete` (skills deleted locally are removed from the repo).
3. Stages **only** `global-claude.md`, `skills/`, and `README.md` (scoped `git add` — unrelated dirty files in `~/merlin` are left alone).
4. If nothing in scope changed, prints a clean notice and exits without committing.
5. Otherwise commits with message `Updated documents YYYY-MM-DD HH:MM:SS` and `git push`es.

## Guardrails
- The script asserts that `~/.claude/CLAUDE.md`, `~/.claude/skills/`, and `~/merlin/.git` all exist before touching anything. If any check fails, stop and report.
- Do not pass `--force` to push. Do not amend prior commits. Do not run `git reset` or `git clean`.
- Do not invoke this command on any directory other than `~/merlin`.
- The script's `git add` is scoped to `global-claude.md`, `skills/`, and `README.md` — unrelated dirty files in `~/merlin` are intentionally left untouched. Do not broaden the scope.
- **Before editing README.md**, check `git status README.md`. If it's already dirty with edits you didn't make in Step 1, show the diff to the user and ask whether to bundle their edits into this commit or hold off — do not silently sweep their work in.
