<!--
Source template for the `setup-decision-docs` skill. The skill reads this, adapts the
"This repo's layout" block to the detected repo structure, then merges the section below
into the *project* CLAUDE.md. Single source for the decision-lifecycle CLAUDE.md block.
Everything below the marker is what gets installed.
-->

## Decision-lifecycle records
This repo records non-trivial choices with the `brainstorm` → `trade-off` → `decision-log` skills.

### Filing (universal — don't change per repo)
- One record per file; never edit a committed one — supersede it (`Superseded by [link]` on the old).
- Filename: `YYYY-MM-DD-short-slug.md`.
- Folders: `tradeoffs/` and `decisions/`. `brainstorms/` only when a brainstorm is worth a paper
  trail — most produce no file, so the folder is often absent.
- Cross-links: on commit, trade-off ↔ decision-log (`Analysis:` / `Decided in:`); a brainstorm
  links to the trade-off or decision it fed once promoted.

### This repo's layout
<!-- setup-decision-docs fills exactly one of these from the repo scan, then deletes the other. -->
- **Flat:** `tradeoffs/`, `decisions/` (and `brainstorms/` if used) at the repo root.
- **Co-located (monorepo):** area-specific under `apps/<area>/`, `services/<name>/`; cross-cutting at the root.

### Read before answering (the high-value part)
- "Why is X this way?" → grep `decisions/` then `tradeoffs/` before answering.
- Before a new trade-off analysis → grep `tradeoffs/` for an overlapping one; don't re-run it.
- "Did we ever consider X?" → `brainstorms/` (rejected before weighing), then `tradeoffs/`.

### Search
- Keyword grep first (`grep -ri "<topic>" decisions/ tradeoffs/`); filename scan as fallback;
  no central index. Reconsider indexing only past ~50 entries in a folder.
