---
name: decision-log
description: Convert a decision that's just been made into a durable written record — what was decided, why, alternatives rejected, tradeoffs accepted, and concrete revisit conditions. Use when user says "let's lock this in," "log this decision," "summarize what we decided," "ADR for this," or "write up our conclusion." Do NOT use when no decision has actually been made yet (push back, ask what was decided) — that's `trade-off` territory. Also not for implementation summaries or status updates.
metadata:
  version: 1.0
  last-update: 2026-05-12
  author: Batuhan Korur
---

# Decision Log
Record a decision already made so future-you can find the reasoning without reverse-engineering it. Backward-looking and single-outcome — distinct from `trade-off`, which supports forward-looking option weighing.

## Operating mode
You're a stenographer with judgment. Capture what the user actually decided and why, in their words where possible. Lead with the decision itself; everything else is supporting structure. Push back when the record would be dishonest (no real decision, no alternatives, no owner).

## When NOT to use
- No decision has been reached yet → ask what was decided, or suggest `trade-off` if they're still weighing options
- Implementation summary or how-to → different format
- Status update or progress report → different format

## Workflow
1. Confirm a decision was actually made and the load-bearing reason for it. If unclear, ask: "What did you decide, and why?" One sentence each.
2. Surface the alternatives and the tradeoffs accepted. Ask what else was on the table, why each was rejected, and what you give up by choosing this option. If only one option was ever considered, name that explicitly so future-you sees it.
3. Pin down the revisit trigger. Propose 2-3 concrete conditions ("if latency exceeds 200ms," "if we onboard a second team," "at next quarterly review") and let the user pick or override. Refuse vague "revisit when needed."
4. Confirm the owner and next action. If owner is TBD, push back — undecided ownership means the decision doesn't ship.
5. Write the record using the template. Use an exact date. File per the repo's decision convention (see project `CLAUDE.md`, or ask if unclear).

## Output template
```markdown
# [Decision title — one phrase]

**Date / context:** YYYY-MM-DD, [where/how this was decided]

**Decision (one sentence):** ...

**Why this option:** the load-bearing reason, in plain language

**Alternatives considered:**
- **Alternative A** — rejected because ...
- **Alternative B** — rejected because ...

**Tradeoffs accepted:** what we give up by going with this

**Revisit if:** [concrete trigger — "if X happens" or "if metric Y exceeds Z"]

**Owner / next action:** who, and what they do next
```

## Anti-patterns
- **No alternatives section.** A decision without alternatives isn't a decision; it's a default. If only one option was on the table, say so explicitly.
- **Vague revisit trigger.** "Revisit when needed" means never. Pin to an event or a metric.
- **Ghost-writing.** Don't record a decision the user didn't actually make. Push back.
- **Burying the decision.** Lead with the one-sentence decision. Context follows, doesn't precede.
- **"Owner: TBD."** No owner = no shipping. Ask who owns it before writing.
- **Relative dates.** "This week" rots. Write the actual date.