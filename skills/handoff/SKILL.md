---
name: handoff
description: Save the durable state of the current session to a handoff file so a fresh agent can pick up cold, or load the latest handoff to brief a newly-started session. Save mode (default) captures shipped decisions, the next concrete move, open blockers, and live context — no diff recaps, no status-report fluff. Load mode reads the most recent handoff in the project, cross-checks it against git state, and briefs the new session. Use when user says "/handoff," "save a handoff," "wrap up," "where did we leave off," "load the latest handoff," "catch me up on last session." Do NOT use mid-task (wait for a natural stopping point), for trivial sessions with no state worth transferring, or as a session summary — the format is forward-looking, not retrospective.
metadata:
  version: 1.0
  last-update: 2026-05-15
  author: Batuhan Korur
---

# Handoff
Save / load the state of a session so a fresh agent can pick up where the last one stopped. Distinct from `session-review`: that skill mines the session for durable workflow improvements (CLAUDE.md / skill edits); `handoff` captures *transient* state — the next move, the live mental model, what's blocked — so the next session doesn't re-discover it. Per-project, append-only, scannable.

## Operating mode
You're handing the controls to a fresh agent who has read this repo's CLAUDE.md and can read git log but knows nothing about *this* thread. Write the smallest set of notes that lets them act correctly on first move. If git log, the diff, CLAUDE.md, or a Notion doc already says something — reference it, don't repeat it. Length is the failure mode; under 60 lines is the typical ceiling.

## When NOT to use
- **Mid-task.** Wait for a natural stopping point — a commit, a locked decision, a "let's call it." Saving mid-thought produces a useless handoff.
- **Trivial sessions.** A one-shot fix, a typo correction, a quick question — no state worth transferring. Say "nothing worth handing off" and stop.
- **As a session summary.** The format is forward-looking ("next move"), not retrospective ("here's everything we did"). If the user wants a recap, give a chat-level recap; don't write a handoff file.
- **Mixed-up modes.** Don't run save and `session-review` as one combined pass — they're distinct. Save the handoff first (project state); the user can invoke `session-review` separately for workflow improvements.

## Quality bar
Every handoff must pass **all three** tests:
1. **Non-duplication test:** if git log / diff / CLAUDE.md / an ADR or Notion doc already captures it, reference by path or SHA — don't repeat the content.
2. **Cold-start test:** could a fresh agent execute the "Next move" using only this file plus the referenced artifacts? If the move is vague ("continue the work," "polish things"), sharpen it before writing.
3. **Length test:** typical handoff is 20–50 lines. Past 60 is a smell — either the session wasn't a clean stopping point or you're recapping instead of handing off.

## Workflow

### Step 1 — Detect mode
- `/handoff` (no arg) or `/handoff save` → **save**
- `/handoff load` → **load**
- `/handoff list` → **list**
- Natural language: "save a handoff," "wrap up," "let's call it" → save. "Load the latest handoff," "where did we leave off," "catch me up" → load. "Show me past handoffs" → list.
- If genuinely ambiguous, ask one short clarifier — don't guess.

### Step 2a — Save mode

1. **Confirm the session is at a stopping point.** Check git status: are there uncommitted changes the user intended to commit? Open tasks marked `in_progress` that should have been finished? If yes, surface them — ask whether to finish first or hand off as-is with the open state noted.
2. **Scan the session for the four content buckets** (mapped to template sections below):
   - *What landed* — decisions made, things shipped, locks pinned. 2–5 bullets, each one line.
   - *Next move* — the specific next file / line / decision. One or two items, concrete.
   - *Open questions / blockers* — what's waiting on a user call or external state. Allowed to be "(none)."
   - *Live context* — load-bearing facts discovered this session that aren't yet in CLAUDE.md / code / docs. Often a precursor to a `session-review` fold-in — flag those explicitly so the user knows to invoke it.
3. **Reference, don't repeat.** Recent commit SHAs, key file paths (3–5 max, high-signal only), links to Notion docs or ADRs. Do not list every modified file — that's `git diff --name-only` territory.
4. **Propose a slug.** Short kebab-case noun phrase, 3–5 words (`input-component-shipped`, `spacing-token-refactor`). Show the user the proposed filename `YYYY-MM-DD-<slug>.md` and let them override.
5. **Apply the quality bar.** Run all three tests. Tighten or trim. If the cold-start test fails on the Next move, sharpen it before writing.
6. **Write the file.** Create `<project>/.claude/handoffs/` if missing. Filename = `YYYY-MM-DD-<slug>.md` using the actual date. On collision, append `-2`, `-3`. Confirm the path back to the user.

### Step 2b — Load mode

1. **Find the handoffs directory.** Look for `<project-root>/.claude/handoffs/`. If missing or empty, say so and stop — there's nothing to load.
2. **Pick the latest file.** Sort by filename (ISO date prefix sorts correctly). If the user specified a slug or date, match that instead.
3. **Read it. Don't paraphrase — quote the key sections back** ("What landed," "Next move," "Open questions"). The user wants to see exactly what their past self wrote.
4. **Cross-check against current state.** Run `git log --oneline -10` and `git status`. Flag drift:
   - Is the "Next move" already done? (commit SHA in log matches it)
   - Are the referenced files still in the layout the handoff assumed?
   - Has CLAUDE.md changed in a way that contradicts the "Live context" section?
   Report drift in one line per item — don't pretend stale items are still actionable.
5. **Brief and pause.** Summarize the live state in 2–3 sentences ("Last session shipped X; next move is Y; one open question on Z"). Ask the user: continue the prior thread, or redirect?

### Step 2c — List mode

- `ls -t` the handoffs directory, show filename + first non-empty heading line ("What landed" preview). Cap at 10 entries unless asked for more. No file modifications.

## Save template
```markdown
# Handoff — YYYY-MM-DD — <slug>

## What landed
- <decision or shipped thing, one line>
- <2–5 bullets total>

## Next move
<One or two concrete actions. File / line / decision specific.
Bad: "continue Input work." Good: "Add Label component at design/src/ui/label/
mirroring Button — Reka Primitive, --text-xs / ink-2 / font-medium per spec.">

## Open questions / blockers
- <item waiting on a decision or research>
- (or "(none)")

## Live context
<Load-bearing facts not yet captured in CLAUDE.md / code / docs.
Mark items that should be folded in via `session-review` with `[→ session-review]`.>

## Suggested skills for next session
<Optional. Only when the next move maps cleanly — e.g.
"/ui-review on Label once shipped" or "/trade-off if we need to pick between A and B.">

## Artifacts
- **Commits:** <SHA list, or "none">
- **Key files:** <3–5 high-signal paths, not exhaustive>
- **Docs / ADRs:** <links to Notion or local decision files>
```

## Anti-patterns
- **Diff recap.** Listing every file touched. The git log does this. The handoff captures intent, not mechanics.
- **Status-report tone.** "We accomplished X, Y, and Z. The team is making great progress." This is a working document for one person, not a stakeholder update.
- **Vague next move.** "Continue Input work," "polish the design system," "iterate on Y." A future agent can't act on these. Pin it to a file, a decision, or a specific question.
- **Recapping CLAUDE.md.** If the project conventions are already documented, don't restate them. Reference by path.
- **Saving mid-task.** If the next move is "finish the function I'm halfway through," you're not at a stopping point. Either finish it or commit the WIP with a note about where you stopped.
- **Inflating Live context.** Every load-bearing fact discovered this session is a candidate — but most belong in CLAUDE.md or code comments, not a transient handoff. If a fact is durable, flag it `[→ session-review]` so the user folds it in; don't carry it forward in handoff files indefinitely.
- **Loading without cross-checking.** A handoff that says "Next move: finish X" when X was merged three commits ago will mislead the new agent. Always cross-check against git state on load.
- **One handoff per session, no matter what.** If you genuinely accomplished nothing transferable, say so and skip the file. An empty `.claude/handoffs/` is a valid state.
