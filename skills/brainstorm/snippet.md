<!--
Per-repo CLAUDE.md snippet for the `brainstorm` skill.
Paste into the project's CLAUDE.md, then adapt the "This repo's layout" block.
Use alongside the `problem-frame`, `trade-off`, and `decision-log` snippets — these four skills cross-link.
-->

## Brainstorms

Option-set widening uses the `brainstorm` skill before any `trade-off`. Brainstorms are **ephemeral by default** — survivors flow into a trade-off doc and nothing else persists. Save a brainstorm as its own file only when the candidate set was non-obvious and the rejected-option reasoning is worth preserving.

**Universal rules (don't change per repo):**

- One brainstorm per file *when a file is produced*. Most brainstorms produce no file.
- Filename: `YYYY-MM-DD-short-slug.md` — e.g. `2026-05-10-data-layer-options.md`.
- When a file is produced, it lives in `brainstorms/` folders inside this repo (parallel to `frames/`, `tradeoffs/`, and `decisions/`).
- **Cross-links:**
	- On handoff, add `*Brainstorm:** [link]` to the resulting trade-off doc (or decision-log entry, if no trade-off was needed).
	- Add `*Frame:** [link]` and `*Trade-off:** [link]` back to the brainstorm doc once those exist.

**This repo's layout:**

<!-- Pick one, delete the others. Only relevant when brainstorm files are produced. -->

- **Flat:** all brainstorm files in `brainstorms/` at the repo root.
- **Co-located (monorepo):** area-specific in `apps/<area>/brainstorms/`, `services/<name>/brainstorms/`; cross-cutting in `brainstorms/` at root.
- **Custom:** describe here.

**When to read existing brainstorms:**

- Before starting a new brainstorm on a related topic, grep `brainstorms/` to avoid re-generating an option set someone already explored and rejected.
- When asked "did we ever consider X?" — `brainstorms/` is the right place to look. `tradeoffs/` only records what was weighed; `brainstorms/` records what was rejected before weighing.

**Search approach:**

- Keyword grep first (`grep -ri "<topic>" brainstorms/`).
- Filename scan as fallback — `YYYY-MM-DD-slug.md` is easy to skim.
- If multiple docs exist for one topic, read in order: `frames/` (what problem) → `brainstorms/` (what was on the table) → `tradeoffs/` (what was weighed) → `decisions/` (what was chosen).
- No central index. Reconsider if this folder exceeds ~30 entries — brainstorms are meant to be sparse.
