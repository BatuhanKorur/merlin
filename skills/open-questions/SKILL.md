---
name: open-questions
description: Resolve every item in a plan's "Open Questions" section interactively — for each question write the context, lay out 2–4 concrete options with tradeoffs and a clear recommendation, decide it via AskUserQuestion, loop until all are resolved, then write the decisions back into the plan. Use when the user says "/open-questions", "resolve the open questions", "go through the open questions one by one", or points at an implementation/refactor plan with an Open Questions / Open Issues / TBD / Decisions-needed section. Do NOT use for general Q&A, for brainstorming options before a plan exists (use /brainstorm), or for one isolated decision with no plan around it (use /trade-off).
metadata:
  version: 1.1
  last-update: 2026-05-23
  author: Batuhan Korur
---

# Open Questions

## Operating mode
You're resolving the open questions in a plan, one at a time, until none remain. For each: give the user enough context to decide, propose concrete options with their tradeoffs, recommend one with reasoning, and let them pick via **AskUserQuestion**. Then record the decision back into the plan. You drive; the user only picks.

**Common upstream sources:** `trade-off` docs with unresolved findings or `Unknown` cells, `refactor` plans (which produce an explicit *Open questions* section), and any implementation plan that lists TBDs / Decisions-needed.

## Workflow
1. **Locate the questions.** In priority order: (a) the plan/doc currently in context, (b) a path the user passed (`/open-questions docs/plans/foo.md`), (c) if neither is clear or several plans qualify, ask which one. The section may be titled *Open Questions*, *Open Issues*, *TBD*, *Decisions needed*, etc. Note whether it lives in a **file** (write-back applies) or only **inline in chat** (chat-summary fallback).
2. **Parse into discrete questions.** Split bundled items — if one bullet hides two independent decisions, treat them as two. Number them and tell the user how many you found before starting.
3. **Resolve each, in order** (see *Per-question loop*).
4. **Write back** the decisions (see *Write-back*).
5. **Close out.** Confirm what was decided, what was written where, and list anything left unresolved.

## Per-question loop
For each question, **one at a time** (the user asked for one-by-one — don't fire them all at once):

1. **Re-check dependencies first.** If an earlier decision already answers or constrains this one, say so and either skip it or narrow the options accordingly.
2. **Frame it in chat** (1–3 sentences): what the question is, why it matters / what depends on it, and which option you'd pick and *why*. This is where your recommendation reasoning lives.
3. **Call AskUserQuestion** with:
   - a `header` ≤ 12 chars,
   - 2–4 concrete `options`, each with a `description` stating its tradeoff/implication (not just a restatement of the label),
   - the **recommended option first**, with `(Recommended)` appended to its label.
   - If more than 4 options are viable, present the 4 strongest — the user can still type their own via "Other".
4. **Record the answer**, including any free-text "Other" response or notes the user adds. Acknowledge it in one line, then move to the next.

Sub-questions that live under the same parent item but whose answers don't constrain each other may share a single AskUserQuestion call (max 4) — but never bundle questions whose answers depend on each other.

## Write-back
When the questions came from a **file**, edit that file surgically:
- For each resolved item, record the decision inline as: `**Decision:** <chosen option> — <one-line rationale>` directly under the question.
- Move fully-resolved items into a `## Decisions` section (or rename the section if all are resolved); leave any genuinely-unresolved ones under the original heading.
- Touch nothing else — no reflow, no rewording of the surrounding plan.

When the questions were only **inline in chat** (no file), skip the edit and instead post a tight decision list in chat: each question → chosen option → one-line rationale.

After writing, state the file path and a one-line summary of what changed.

## Hard rules / anti-patterns
- **Don't skip a question** because it's hard — surface the tension and still offer options. If the user defers, mark it explicitly as still-open rather than guessing.
- **Don't pick for the user.** You recommend; AskUserQuestion decides. (You may still note when an option is clearly dominated.)
- **Don't invent options** to pad to four — 2 real options beats 4 with filler.
- **Don't fire every question in one batch** — honor one-by-one unless the user asks to batch.
- **Don't reformat or "improve" the rest of the plan** during write-back — only touch the questions you resolved.
- **Don't lose the user's wording** — capture "Other" answers and side-notes verbatim in the write-back.
