<!--
Per-repo CLAUDE.md snippet for the `trade-off` skill.
Paste into the project's CLAUDE.md, then adapt the "This repo's layout" block.
Use alongside the `decision-log` snippet — the two skills cross-link.
-->

## Trade-off analyses

Open technical or design choices are weighed using the `trade-off` skill. Analyses live in this repo and are promoted to `decision-log` entries once an option is committed.

**Universal rules (don't change per repo):**

- One analysis per file. If a choice is reopened (per the "Revisit if" trigger), write a new analysis — don't edit the old one. Link them via a `Supersedes / related` line at the top of the new file, and add `Superseded by [link]` to the top of the old analysis.
- Filename: `YYYY-MM-DD-short-slug.md` — e.g. `2026-05-10-job-queue-options.md`.
- Analyses live in `tradeoffs/` folders inside this repo (parallel to `decisions/`).
- **Cross-links with `decision-log`:**
	- On commit, add `*Analysis:** [link to trade-off doc]` to the resulting decision-log entry.
	- Add `*Decided in:** [link to decision-log entry]` back to the trade-off doc.
	- Not every decision needs a trade-off doc — small or obvious choices can go straight to `decision-log`.

**This repo's layout:**

<!-- Pick one, delete the others. -->

- **Flat:** all analyses in `tradeoffs/` at the repo root.
- **Co-located (monorepo):** area-specific in `apps/<area>/tradeoffs/`, `services/<name>/tradeoffs/`; cross-cutting in `tradeoffs/` at root.
- **Custom:** describe here.

**When to read existing trade-off docs:**

- Before starting a new analysis, grep the relevant `tradeoffs/` folder for overlapping choices. If a prior analysis covers the same ground, surface it — don't re-run the comparison from scratch.
- When asked "why didn't we pick X?" — check `tradeoffs/` first (rejected-option reasoning lives in the analysis), then `decisions/` (committed rationale).

**Search approach:**

- Keyword grep first (`grep -ri "<topic>" tradeoffs/`).
- Filename scan as fallback — `YYYY-MM-DD-slug.md` is easy to skim.
- If both an analysis and a decision exist for a topic, the decision wins on *what was chosen*; the analysis tells you *what else was considered and why each lost*.
- No central index. Reconsider if a folder exceeds ~50 entries.