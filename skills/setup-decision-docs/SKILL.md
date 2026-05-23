---
name: setup-decision-docs
description: Install this repo's decision-lifecycle convention into the project CLAUDE.md — scan the repo's layout, pick flat vs co-located, and merge a `## Decision-lifecycle records` section (where `brainstorm`/`trade-off`/`decision-log` files live, and when to read them) without trampling existing content. Use when the user says "/setup-decision-docs," "wire up decision docs here," "set up the trade-off/decision-log convention in this repo," or starts keeping decision records in a new project. Do NOT use for generic CLAUDE.md authoring (use `init` / `claude-md-improver`), for a single one-off record (just run `decision-log`), and NEVER write to the global ~/.claude/CLAUDE.md — project CLAUDE.md only.
metadata:
  version: 1.0
  last-update: 2026-05-23
  author: Batuhan Korur
---

# setup-decision-docs
Operational installer for the decision-lifecycle convention. Run inside a project to wire `brainstorm` → `trade-off` → `decision-log` into *that repo's* CLAUDE.md: detect the layout, adapt the template, and merge one section in safely. Distinct from `init` and `claude-md-management:claude-md-improver` (generic CLAUDE.md authoring/audit) — this installs *one specific convention*. Operational sibling to `merlin-sync`. The section it installs comes from `template.md` next to this file — the single source for the decision-lifecycle CLAUDE.md block.

## What it does
1. Confirms it's running in a real project repo that should keep decision records — and that the target is the **project** CLAUDE.md, never global.
2. Scans the repo: flat vs monorepo layout, existing `decisions/`/`tradeoffs/`/`brainstorms/` folders, an existing CLAUDE.md, and whether a `## Decision-lifecycle records` section already exists.
3. Adapts `template.md`'s "This repo's layout" block to what it found, and drops `brainstorm` lines if that doc-type isn't wanted here.
4. Merges the section into the project CLAUDE.md — create if missing, update in place if the heading exists, append if absent — after showing the diff and getting confirmation.

## When NOT to use
- Generic CLAUDE.md authoring or audit → `init` (new file) / `claude-md-improver` (improve existing).
- A single one-off decision → just run `decision-log`; you don't need the convention installed for one record.
- A throwaway / scratch repo with nothing worth recording → skip; say so and stop.
- The global `~/.claude/CLAUDE.md` → never. The convention is per-repo by design.

## Workflow (run in order)

1. **Confirm scope.** Verify cwd is a real project (has a VCS root or is plainly a project tree). If it's throwaway, or the user only wants one record, stop and point at `decision-log`. State explicitly that you're writing the **project** CLAUDE.md, not global.
2. **Scan layout + state.**
   - Monorepo signal: `apps/`, `services/`, or `packages/` present → **co-located**. Otherwise → **flat**.
   - Existing folders: check for `decisions/`, `tradeoffs/`, `brainstorms/`.
   - Existing root CLAUDE.md? If so, does it already contain a `## Decision-lifecycle records` heading?
3. **Pick doc-types.** `trade-off` + `decision-log` by default. Include `brainstorm` only if the user wants a rejected-options paper trail (its folder is usually absent). Ask one short question if unclear.
4. **Adapt `template.md`.** Read it. Fill the "This repo's layout" block from step 2 (flat → folders at root; co-located → `apps/<area>/…` paths) and delete the unused layout option. Drop the `brainstorm` lines if not selected.
5. **Merge safely + confirm.**
   - No CLAUDE.md → create it containing the section.
   - CLAUDE.md exists, no section → append the section at the end with `Edit`.
   - Section already exists → update it **in place** (idempotent re-run) — never add a second copy.
   - Show the diff (or the section to be added) and get confirmation **before** writing.
6. **Report.** Confirm the path written and the layout chosen. Note that the `decisions/`/`tradeoffs/` folders appear on first use — the lifecycle skills create them when they write the first file.

## Guardrails
- **Project CLAUDE.md only.** Refuse to run unless cwd is a project root — a VCS marker (`.git/`) or a recognizable project file (`package.json`, `pyproject.toml`, `Cargo.toml`, `go.mod`, …). Stop and report if cwd is `$HOME` or anywhere under `~/.claude/`; never touch the global `~/.claude/CLAUDE.md`.
- **Never trample.** Touch only the `## Decision-lifecycle records` section. Use `Edit` for in-place section updates; reserve `Write` for creating a CLAUDE.md that doesn't exist yet.
- **Idempotent.** Re-running updates the section in place. It must never produce a duplicate section.
- **Confirm before writing** to an existing CLAUDE.md — show the diff first; the user approves.
- **Don't invent folders.** Install the convention; don't create empty `decisions/`/`tradeoffs/` dirs. Those appear when the lifecycle skills first write a record.
