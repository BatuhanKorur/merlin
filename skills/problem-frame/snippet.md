<!--
Per-repo CLAUDE.md snippet for the `problem-frame` skill.
Paste into the project's CLAUDE.md, then adapt the "This repo's layout" block.
Use alongside the `brainstorm`, `trade-off`, and `decision-log` snippets — these four skills cross-link.
-->

## Problem frames

Fuzzy or solution-shaped problems are sharpened using the `problem-frame` skill before any options are weighed. Frames live in this repo and are linked from the brainstorm / trade-off / decision-log entries they led to.

**Universal rules (don't change per repo):**

- One frame per file. If a frame is reopened (problem turned out to be different, or scope shifted materially), write a new frame — don't edit the old one. Link via `Supersedes / related` at the top of the new file, and add `Superseded by [link]` to the top of the old frame.
- Filename: `YYYY-MM-DD-short-slug.md` — e.g. `2026-05-10-notification-pain.md`.
- Frames live in `frames/` folders inside this repo (parallel to `tradeoffs/` and `decisions/`).
- **Cross-links with downstream skills:**
	- When a frame hands off to `brainstorm`, `trade-off`, or `decision-log`, link the resulting doc in the frame's `Related` block.
	- On the downstream side, add `*Frame:** [link to problem-frame doc]` near the top so future readers can trace back to the problem.
	- Not every piece of work needs a frame — sharp, small, or obvious problems can skip straight to brainstorm / trade-off / decision-log.

**This repo's layout:**

<!-- Pick one, delete the others. -->

- **Flat:** all frames in `frames/` at the repo root.
- **Co-located (monorepo):** area-specific in `apps/<area>/frames/`, `services/<name>/frames/`; cross-cutting in `frames/` at root.
- **Custom:** describe here.

**When to read existing frames:**

- Before starting a new frame, grep the relevant `frames/` folder for overlapping problems. If a prior frame covers the same ground, surface it — don't re-frame from scratch.
- When asked "why are we working on X?" or "what's the actual problem with Y?" — check `frames/` first.
- When a trade-off or decision feels off, check whether the underlying frame is still accurate — stale frames produce off-target choices downstream.

**Search approach:**

- Keyword grep first (`grep -ri "<topic>" frames/`).
- Filename scan as fallback — `YYYY-MM-DD-slug.md` is easy to skim.
- If a frame, a trade-off, and a decision all exist for a topic: the frame says *what problem*, the trade-off says *what else was considered*, the decision says *what was chosen*. Read them in that order.
- No central index. Reconsider if a folder exceeds ~50 entries.
