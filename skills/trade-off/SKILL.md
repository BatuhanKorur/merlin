---
name: trade-off
description: Produce a structured ADR-lite for an open technical or design choice — explicit options, locked criteria, prose scoring, recommendation, and revisit trigger. Use when user says "which approach," "X vs Y," "help me decide between A and B," "should we use X or Y," "tradeoffs of X," or "compare these options." Forces auditable rationale instead of vibes-based picks. Do NOT use when a decision has already been made (use `decision-log`), for trivial choices (variable naming, file order), or when one option is obviously correct.
metadata:
  version: 1.0
  last-update: 2026-05-12
  author: Batuhan Korur
---

# Trade-off
Forward-looking option weigher. Produces an ADR-lite that supports a choice with ≥2 real options, locked criteria, and an auditable recommendation. Pairs with `decision-log` (backward-looking record) — promote the analysis to a `decision-log` entry once an option is committed.

## Operating mode
You're an analyst with a stake in honesty, not a courtier. Push back on rigged comparisons — soft criteria, strawman options, or criteria that suspiciously favor a pre-pick. Pick a recommendation; staying neutral is dodging. Make every step auditable so the user can disagree with the criteria, not the conclusion. 
**Scale the rigor to the reversibility:** for two-way-door choices, drop the scoring table and write a prose recommendation; save the full template for choices that are expensive to reverse.

## When NOT to use
- Decision already made → `decision-log` (backward-looking record)
- Trivial choices (naming, file order, formatting) → just answer
- One obviously correct option → say so plainly, don't manufacture a comparison
- More than ~5 options on the table → criteria are missing; narrow first

## Workflow
1. **Name the candidates briefly.** List the options the user has in mind — no analysis yet. At least two real ones. Always probe for the do-nothing / status-quo option even if the user didn't name it; silent status-quo bias is the most common analysis failure. If only one option survives scrutiny, stop and say so — at that point it's not a trade-off, it's a decision. Suggest `decision-log` if the user wants it on the record.
2. **Set the criteria — disqualifying first, preferences second.** Disqualifying criteria are hard requirements ("must be HIPAA-compliant," "must run on existing infra"); any option failing them is out before scoring. Preferences are the properties you're optimizing across the survivors. **Bias tell:** if a criterion is phrased by pointing at an option ("lightweight, like Option B"), restate it abstractly or drop it — criteria are properties of the problem, not votes in disguise. Refuse soft criteria. Default to equal weights unless the user specifies.
3. **Score each option against each criterion in plain prose.** One short sentence per cell — what this option actually does on this criterion. No 1-5 numbers; the precision is fake. "Unknown" is allowed — it's a finding, not a gap to paper over.
4. **Recommend, citing rows.** Name the option and quote the criteria that drove it. If the rationale leans on something not in the criteria table, that criterion was missing — go back, add it, rescore, then recommend. The loop is expected, not a failure.
5. **Pin tradeoffs accepted and the revisit trigger.** What does picking this cost? What concrete event ("if QPS exceeds X," "if a second team adopts this") should reopen the choice? Refuse "revisit when needed."
6. **Write the doc using the template.** File per the repo's trade-off convention (see project `CLAUDE.md`, or ask if unclear). For light versions on two-way-door choices, drop the scoring table — prose recommendation is enough. When the user commits to an option, offer to promote: run `decision-log` for the entry, then add `*Decided in:** [link]` here and `*Analysis:** [link to this doc]` on the decision-log side.

## Output template
```markdown
# Trade-off Analysis: [one-phrase title of the choice]

**Date / context:** YYYY-MM-DD, [where this choice is being weighed]

**Problem (one sentence):** what we're choosing for, and the constraints that bound the answer.

**Options:**
- **Option A — [name]:** short description
- **Option B — [name]:** short description
- **(Status quo / do nothing):** short description, or "not viable because ..."

**Disqualifying criteria (hard requirements):**
- ... — any option failing this is out before scoring.

**Criteria (locked before scoring):**
| Criterion | Weight | Why it matters |
|---|---|---|
| ... | equal / X | ... |

**Scoring:**
| Criterion | Option A | Option B | ... |
|---|---|---|---|
| ... | one-sentence prose | one-sentence prose | ... |

**Recommendation:** [option] — because [criteria-driven reason citing specific rows above].

**Tradeoffs accepted:** what we give up by picking this.

**Revisit if:** [concrete trigger — event or metric, never "when needed"].

**Decided in:** _(populated when promoted to decision-log)_
```

## Anti-patterns
- **Performing analysis instead of doing it.** Watch for: criteria written after the recommendation; Option B that's a strawman; rationale citing things outside the criteria table. All three mean you decided first and dressed it up after.
- **Soft criteria.** "Cleaner," "feels right," "more elegant" — replace with the testable thing those phrases stand in for, or drop them.
- **Heavyweight analysis on a two-way door.** If reversing the choice is cheap, the full template is overkill. A four-line prose comparison is the right output.
- **More than ~5 options.** You're missing criteria. Cluster or eliminate before scoring.
- **Numerical scores.** "4 vs 3" rarely survives a follow-up question. Force prose; let the reader judge.
- **Vague revisit trigger.** "Revisit when needed" means never. Pin to an event or a metric.