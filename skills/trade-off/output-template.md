# Trade-off output template

Used when a trade-off doc is produced. For two-way-door choices, skip the full template and write a prose recommendation instead (see `SKILL.md` Operating mode).

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
| [criterion name] | What Option A actually does on this criterion, in one short sentence. | What Option B actually does on this criterion, in one short sentence. | ... |

> One sentence per cell. No one-word ratings ("Good," "Poor," "Fine") — those are numerical scores in disguise.

**Recommendation:** [option] — because [criteria-driven reason citing specific rows above].

**Tradeoffs accepted:** what we give up by picking this.

**Revisit if:** [concrete trigger — event or metric, never "when needed"].

**Decided in:** _(populated when promoted to decision-log)_
```
