---
name: trade-off
description: Use when user says "X vs Y," "which approach," "help me decide between A and B," "should we use X or Y," "tradeoffs of X," "compare these options," or has 2+ real candidates needing structured weighing. Skip when a decision is already made (use `decision-log`), for trivial choices, or when one option is obviously correct.
metadata:
  version: 1.4
  last-update: 2026-05-23
  author: Batuhan Korur
---

# Trade-off
Forward-looking option weigher. Produces an ADR-lite that supports a choice with ≥2 real options, locked criteria, and an auditable recommendation. Slot: `brainstorm` → `trade-off` → `decision-log`. Promote to `decision-log` after the user commits — not in the analysis itself.

## At a glance
| Step | Action |
|------|--------|
| 1 | Name candidates (always probe for do-nothing) |
| 2 | Set criteria — disqualifying first, preferences second |
| 3 | Score each option per criterion in prose, not numbers |
| 4 | Recommend, citing rows |
| 5 | Pin tradeoffs accepted + concrete revisit trigger |
| 6 | Write the doc; offer promotion to `decision-log` when committed |

## Operating mode
You're an analyst with a stake in honesty, not a courtier. Push back on rigged comparisons — soft criteria, strawman options, or criteria that suspiciously favor a pre-pick. Pick a recommendation; staying neutral is dodging. Make every step auditable so the user can disagree with the criteria, not the conclusion.

## When NOT to use
- Decision already made → `decision-log` (backward-looking record)
- Trivial choices (naming, file order, formatting) → just answer
- One obviously correct option → say so plainly, don't manufacture a comparison
- More than ~5 options on the table → criteria are missing; narrow first (or hand back to `brainstorm`). 3 is typical: the user's two candidates plus the do-nothing probe.

## Workflow

> **Before step 1: is this a two-way door?** If reversing the choice is cheap, drop the full workflow and write a short prose recommendation instead. The steps below are for choices that are expensive to undo.
>
> **Prose-mode minimum:** name the options (including status quo), where each wins, your recommendation, and a concrete revisit trigger.

1. **Name the candidates briefly.** No analysis yet.
	- At least two real options.
	- **Always include status quo as a candidate** — probe for it when the user is silent about current state, and surface it as a first-class option when they name the current setup as context. Silent status-quo bias is the most common analysis failure.
	- If only one option survives scrutiny, stop — it's not a trade-off, it's a decision. Suggest `decision-log`.

2. **Set the criteria — disqualifying first, preferences second.**
	- **Disqualifying criteria** are hard requirements ("must be HIPAA-compliant," "must run on existing infra"); any option failing them is out before scoring. If the user named a disqualified option, keep it visible in the Options list and explain the disqualification — silently dropping it looks evasive.
	- **Preferences** are the properties you're optimizing across the survivors. Default to equal weights unless the user specifies.
	- **Bias tell:** if a criterion is phrased by pointing at an option ("lightweight, like Option B"), restate it abstractly or drop it — criteria are properties of the problem, not votes in disguise.
	- Refuse soft criteria (see Anti-patterns).

3. **Score each option against each criterion in plain prose.**
	- One short sentence per cell — what this option actually does on this criterion.
	- **No numerical scores.** Force prose; let the reader judge. (See Anti-patterns.)
	- **"Unknown" is allowed — it's a finding, not a gap to paper over.**

4. **Recommend, citing rows.** Name the option and quote the criteria that drove it. If the rationale leans on something not in the criteria table, that criterion was missing — go back, add it, rescore, then recommend. The loop is expected, not a failure.

5. **Pin tradeoffs accepted and the revisit trigger.** What does picking this cost? What concrete event ("if QPS exceeds X," "if a second team adopts this") should reopen the choice? Refuse "revisit when needed."

6. **Write the doc.**
	- See [`output-template.md`](output-template.md). File per the repo's trade-off convention (project `CLAUDE.md`, or ask if unclear).
	- If the doc carries unresolved questions or `Unknown` findings that need user input before commit, point at `open-questions` — it walks them through one-by-one and writes the decisions back into the doc.
	- Don't offer promotion in the initial trade-off response — the user hasn't committed yet. When they later commit to an option, offer to promote: run `decision-log` for the entry, then add `**Decided in:** [link]` here and `**Analysis:** [link to this doc]` on the decision-log side.

## Anti-patterns
- **Performing analysis instead of doing it.** Watch for: criteria written after the recommendation; Option B that's a strawman; rationale citing things outside the criteria table. All three mean you decided first and dressed it up after.
- **Soft criteria.** "Cleaner," "feels right," "more elegant" — replace with the testable thing those phrases stand in for, or drop them.
- **Numerical scores.** "4 vs 3" rarely survives a follow-up question; the precision is fake.
- **Vague revisit trigger.** "Revisit when needed" means never. Pin to an event or a metric.
