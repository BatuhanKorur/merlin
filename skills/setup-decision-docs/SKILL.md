---
name: setup-decision-docs
description: Install the decision-lifecycle convention (`brainstorm` / `trade-off` / `decision-log`) into the current project's CLAUDE.md — scans the repo layout, adapts the template, and merges one section idempotently. Project CLAUDE.md only; refuses to touch global.
disable-model-invocation: true
metadata:
  version: 1.2
  last-update: 2026-05-23
  author: Batuhan Korur
---

# setup-decision-docs

Operational installer for the decision-lifecycle convention. Run inside a project to wire `brainstorm` → `trade-off` → `decision-log` into *that repo's* CLAUDE.md: detect the layout, adapt the template, and merge one section in safely. Operational sibling to `merlin-sync` (the global-config backup command).

The section it installs comes from `template.md` next to this file — the single source for the decision-lifecycle CLAUDE.md block. Distinct from `init` and `claude-md-improver` (generic CLAUDE.md authoring/audit) — this installs *one specific convention*.

## At a glance
| Step | Action |
|------|--------|
| 1 | Confirm scope — verify cwd is a real project; refuse if home or under `~/.claude/` |
| 2 | Scan repo layout (flat vs monorepo) + existing CLAUDE.md state |
| 3 | Pick doc-types (default: `trade-off` + `decision-log`; `brainstorm` opt-in) |
| 4 | Adapt `template.md` to the detected layout |
| 5 | Merge into project CLAUDE.md — create, append, or update in place |
| 6 | Report the path written and the layout chosen |

## Operating mode
You're installing a specific, opinionated convention into a project. **Project CLAUDE.md only — never global, never trample existing content.** Show diffs and get confirmation before writing. Re-runs must be idempotent: update the section in place, never produce a duplicate.

## When NOT to use
- Generic CLAUDE.md authoring or audit → `init` (new file) / `claude-md-improver` (improve existing)
- A single one-off decision → just run `decision-log`; you don't need the convention installed for one record
- A throwaway / scratch repo with nothing worth recording → skip; say so and stop
- The global `~/.claude/CLAUDE.md` → never. The convention is per-repo by design.

## Workflow

1. **Confirm scope.**
	- Verify cwd is a real project (has a VCS root, or is plainly a project tree).
	- If it's throwaway, or the user only wants one record, stop and point at `decision-log`.
	- State explicitly that you're writing the **project** CLAUDE.md, not global.

2. **Scan layout + state.**
	- Monorepo signal: `apps/`, `services/`, or `packages/` present → **co-located**. Otherwise → **flat**.
	- Existing folders: check for `decisions/`, `tradeoffs/`, `brainstorms/`.
	- Existing root CLAUDE.md? If so, does it already contain a `## Decision-lifecycle records` heading?

3. **Pick doc-types.** `trade-off` + `decision-log` by default. Include `brainstorm` only if the user explicitly wants a rejected-options paper trail (most repos skip it; the folder is usually absent). **Always ask the brainstorm question unless the user has already stated a preference** — existing folder structure (e.g., `decisions/`) signals decision-log usage but tells you nothing about brainstorm intent.

4. **Adapt `template.md`.** Read it (`${CLAUDE_SKILL_DIR}/template.md`). Make these specific adaptations:
	- **Layout block:** keep the bullet matching the detected layout (Flat or Co-located); delete the other and the comment above them.
	- **If `brainstorm` was not selected**, drop:
		- the `(and brainstorms/ if used)` parenthetical from the Flat layout bullet,
		- the `"Did we ever consider X?"` bullet in the "Read before answering" section.
	- Leave the opening sentence and the Filing paragraph as-is — they read correctly either way.

5. **Merge safely + confirm.**
	- No CLAUDE.md → create it containing the section.
	- CLAUDE.md exists, no section → append the section at the end with `Edit`.
	- Section already exists → update it **in place** (idempotent re-run) — never add a second copy. Re-runs repeat steps 2–4 fresh, so layout changes (e.g., monorepo conversion, new folders) are reflected in the updated section.
	- Show the diff (or the section to be added) and get confirmation **before** writing.

6. **Report.** Confirm the path written and the layout chosen. Note that the `decisions/`/`tradeoffs/` folders appear on first use — the lifecycle skills create them when they write the first file.

## Guardrails
- **Project CLAUDE.md only.** Refuse to run unless cwd is a project root — a VCS marker (`.git/`) or a recognizable project file (`package.json`, `pyproject.toml`, `Cargo.toml`, `go.mod`, …). Stop and report if cwd is `$HOME` or anywhere under `~/.claude/`; never touch the global `~/.claude/CLAUDE.md`.
- **Never trample.** Touch only the `## Decision-lifecycle records` section. Use `Edit` for in-place section updates; reserve `Write` for creating a CLAUDE.md that doesn't exist yet.
- **Idempotent.** Re-running updates the section in place. It must never produce a duplicate section.
- **Confirm before writing** to an existing CLAUDE.md — show the diff first; the user approves.
- **Don't invent folders.** Install the convention; don't create empty `decisions/`/`tradeoffs/` dirs. Those appear when the lifecycle skills first write a record.
