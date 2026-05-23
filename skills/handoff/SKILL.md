---
name: handoff
description: Use when user says "/handoff," "save a handoff," "wrap up," "where did we leave off," "load the latest handoff," "catch me up." Save (default) captures shipped decisions, next move, blockers, and live context to `.claude/handoffs/` so a fresh agent picks up cold. Load reads the latest handoff and cross-checks against git state. Skip when mid-task, trivial session, or for retrospective summaries.
metadata:
  version: 1.3
  last-update: 2026-05-23
  author: Batuhan Korur
---

# Handoff
Save / load the state of a session so a fresh agent can pick up where the last one stopped. Distinct from `session-review`: that skill mines the session for durable workflow improvements (CLAUDE.md / skill edits); `handoff` captures *transient* state — the next move, the live mental model, what's blocked — so the next session doesn't re-discover it. Per-project, append-only, scannable.

## At a glance

| Mode | Trigger | What it does |
|---|---|---|
| Save (default) | `/handoff`, `/handoff save`, "wrap up," "let's call it," "save a handoff" | Confirms stopping point, scans four content buckets, writes `YYYY-MM-DD-<slug>.md` after quality gates |
| Load | `/handoff load`, "where did we leave off," "catch me up on last session" | Reads latest handoff, quotes key sections, cross-checks against git state, briefs new session |
| List | `/handoff list`, "show past handoffs" | `ls -t` the directory, shows top 10 with title previews. No writes. |

## Operating mode
You're handing the controls to a fresh agent who has read this repo's CLAUDE.md and can read git log but knows nothing about *this* thread. Write the smallest set of notes that lets them act correctly on first move.

**Reference, don't repeat.** If git log, the diff, CLAUDE.md, or a Notion doc already says something, link to it — don't restate it. Length is the failure mode; under 60 lines is the typical ceiling.

## When NOT to use
- **Mid-task.** Wait for a natural stopping point — a commit, a locked decision, a "let's call it." Saving mid-thought produces a useless handoff.
- **Trivial sessions.** A one-shot fix, a typo correction, a quick question — no state worth transferring. Say "nothing worth handing off" and stop.
- **As a session summary.** The format is forward-looking ("next move"), not retrospective ("here's everything we did"). If the user wants a recap, give a chat-level recap; don't write a handoff file.
- **Mixed-up modes.** Don't run save and `session-review` as one combined pass — they're distinct. Save the handoff first (project state); the user can invoke `session-review` separately for workflow improvements.

## Workflow

### Step 1 — Detect mode
- `/handoff` (no arg) or `/handoff save` → **save**
- `/handoff load` → **load**
- `/handoff list` → **list**
- Natural language: "save a handoff," "wrap up," "let's call it" → save. "Load the latest handoff," "where did we leave off," "catch me up" → load. "Show me past handoffs" → list.
- If genuinely ambiguous, ask one short clarifier — don't guess.

### Step 2a — Save mode

> **Every handoff must pass three tests before writing:**
> 1. **Non-duplication.** If git log / diff / CLAUDE.md / an ADR or Notion doc already captures it, reference by path or SHA — don't repeat the content.
> 2. **Cold-start.** Could a fresh agent execute the "Next move" using only this file plus the referenced artifacts? If the move is vague ("continue the work," "polish things"), sharpen it before writing.
> 3. **Length.** Typical handoff is 20–50 lines. Past 60 is a smell — either the session wasn't a clean stopping point or you're recapping instead of handing off.

1. **Confirm the session is at a stopping point.** Check git status: are there uncommitted changes the user intended to commit? Open tasks marked `in_progress` that should have been finished? If yes, surface them — ask whether to finish first or hand off as-is with the open state noted.
2. **Scan the session for the content buckets** (the template enumerates the sections — these notes are about *what counts where*):
   - *What landed* — durable outcomes, not activity. If git log captures it, just reference the SHA.
   - *Next move* — the specific next file / line / decision. Vague items fail the cold-start test.
   - *Open questions / blockers* — waiting on a user call or external state. Allowed to be "(none)."
   - *Live context* — facts discovered this session that aren't yet in CLAUDE.md / code / docs. Flag durable ones with `[→ session-review]` so the user folds them in.
   - *Suggested skills* — optional. Include only when the next move maps cleanly to a specific skill invocation (e.g., `/ui-review on Label once shipped`, `/trade-off if we need to pick between A and B`).
3. **Populate artifacts.** Recent commit SHAs; 3–5 high-signal file paths (not exhaustive — that's `git diff --name-only` territory); links to Notion docs or ADRs.
4. **Propose a slug.** Short kebab-case noun phrase, 3–5 words (`input-component-shipped`, `spacing-token-refactor`). Show the user the proposed filename `YYYY-MM-DD-<slug>.md` and let them override before continuing.
5. **Apply each test from the callout above:** (1) non-duplication, (2) cold-start, (3) length. Tighten or trim. If cold-start fails on the Next move, sharpen it before writing.
6. **Write the file** using the format in [`output-template.md`](output-template.md). Create `<project>/.claude/handoffs/` if missing. Filename = `YYYY-MM-DD-<slug>.md` using the actual date. On collision, append `-2`, `-3`. After writing, report the path back to the user.

### Step 2b — Load mode

1. **Find the handoffs directory.** Look for `<project-root>/.claude/handoffs/`. If missing or empty, say so and stop — there's nothing to load.
2. **Pick the latest file.** Sort by filename (ISO date prefix sorts correctly). If the user specified a slug or date, match that instead.
3. **Read it. Don't paraphrase — quote any non-empty section back verbatim** (What landed / Next move / Open questions / Live context). Use a blockquote or fenced block so the handoff's `#` headings don't re-render as chat headings. *Suggested skills* feeds the brief in Step 5, not the verbatim quote block — keep load output scannable.
4. **Cross-check against current state.** Run `git log --oneline -10` and `git status`. If Live context contains any `[→ session-review]` flags, also read CLAUDE.md to check whether they've been folded in. Flag drift:
   - Is the "Next move" already done? (commit SHA in log matches it)
   - Are the referenced files still in the layout the handoff assumed?
   - Has CLAUDE.md absorbed any `[→ session-review]` flags? (If yes, those Live context items are resolved, not pending.)
   Report drift in one line per item — don't pretend stale items are still actionable.
5. **Brief and pause.** Summarize the live state in 2–3 sentences ("Last session shipped X; next move is Y; one open question on Z"). Ask the user: continue the prior thread, or redirect?

### Step 2c — List mode

- `ls -t` the handoffs directory, show filename + first non-empty heading line ("What landed" preview). Cap at 10 entries unless asked for more. No file modifications.

## Anti-patterns
- **Diff recap.** Listing every file touched. The git log does this. The handoff captures intent, not mechanics.
- **Status-report tone.** "We accomplished X, Y, and Z. The team is making great progress." This is a working document for one person, not a stakeholder update.
- **Vague next move.** "Continue Input work," "polish the design system," "iterate on Y." A future agent can't act on these. Pin it to a file, a decision, or a specific question.
- **Recapping CLAUDE.md.** If the project conventions are already documented, don't restate them. Reference by path.
- **Saving mid-task.** If the next move is "finish the function I'm halfway through," you're not at a stopping point. Either finish it or commit the WIP with a note about where you stopped.
- **Inflating Live context.** Every load-bearing fact discovered this session is a candidate — but most belong in CLAUDE.md or code comments, not a transient handoff. If a fact is durable, flag it `[→ session-review]` so the user folds it in; don't carry it forward in handoff files indefinitely.
- **Loading without cross-checking.** A handoff that says "Next move: finish X" when X was merged three commits ago will mislead the new agent. Always cross-check against git state on load.
- **One handoff per session, no matter what.** If you genuinely accomplished nothing transferable, say so and skip the file. An empty `.claude/handoffs/` is a valid state.
