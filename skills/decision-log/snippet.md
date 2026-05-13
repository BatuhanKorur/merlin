<!--
Per-repo CLAUDE.md snippet for the `decision-log` skill.
Paste into the project's CLAUDE.md, then adapt the "This repo's layout" block.
-->

## Decision records

Non-trivial decisions are logged using the `decision-log` skill. Records live in this repo.

**Universal rules (don't change per repo):**

- One decision per file. Never append; if a decision changes, write a new file and mark the old one `Superseded by [link]`.
- Filename: `YYYY-MM-DD-short-slug.md` — e.g. `2026-05-10-onboarding-research-direction.md`.
- Records live in `decisions/` folders inside this repo.

**This repo's layout:**

<!-- Pick one, delete the others. -->

- **Flat:** all decisions in `decisions/` at the repo root.
- **Co-located (monorepo):** area-specific in `apps/<area>/decisions/`, `services/<name>/decisions/`; cross-cutting in `decisions/` at root.
- **Custom:** describe here.

**When to read existing decisions:**

- Before answering architecture, design, or "why is X this way?" questions, grep the relevant `decisions/` folder for prior choices and surface them in the answer.
- Before writing a new decision, grep for overlapping topics. Link related ones in the new decision's `Supersedes / related` field; if this contradicts an old decision, also add `Superseded by [link]` to the top of that old file.

**Search approach:**

- Keyword grep first (`grep -ri "<topic>" decisions/`).
- Filename scan as fallback — `YYYY-MM-DD-slug.md` is easy to skim.
- No central index. Reconsider if a folder exceeds ~50 entries.