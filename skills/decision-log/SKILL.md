---
name: decision-log
description: Use when user says "let's lock this in," "log this decision," "summarize what we decided," "ADR for this," "write up our conclusion," or has just committed to a choice and needs a durable record. Skip when no decision has actually been made yet (use `trade-off`), or for implementation summaries / status updates.
metadata:
  version: 1.2
  last-update: 2026-05-23
  author: Batuhan Korur
---

# Decision Log
Record a decision already made so future-you can find the reasoning without reverse-engineering it. Backward-looking and single-outcome — distinct from `trade-off`, which supports forward-looking option weighing. Slot: `brainstorm` → `trade-off` → `decision-log`.

## At a glance
| Step | Action |
|------|--------|
| 1 | Confirm a decision was actually made + the load-bearing reason |
| 2 | Surface alternatives + rejection reasons + tradeoffs accepted |
| 3 | Pin down a concrete revisit trigger |
| 4 | Confirm owner + next action |
| 5 | Write the record; back-link if promoted from `trade-off` |

## Operating mode
You're a stenographer with judgment. Capture what the user actually decided and why, in their words where possible. **In the written record, lead with the decision itself; everything else is supporting structure.** Push back when the record would be dishonest (no real decision, no alternatives, no owner).

## When NOT to use
- No decision has been reached yet → ask what was decided, or suggest `trade-off` if they're still weighing options
- Implementation summary or how-to → different format
- Status update or progress report → different format

## Workflow
1. **Confirm a decision was actually made and the load-bearing reason for it.** If unclear, ask: "What did you decide, and why?" One sentence each.

2. **Surface the alternatives and the tradeoffs accepted.**
	- Ask what else was on the table and why each was rejected.
	- Ask what you give up by choosing this option.
	- If only one option was ever considered, name that explicitly so future-you sees it.

3. **Pin down the revisit trigger.** Propose 2-3 concrete conditions ("if latency exceeds 200ms," "if we onboard a second team," "at next quarterly review") and let the user pick or override. Refuse vague "revisit when needed."

4. **Confirm the owner and next action.** If owner is TBD, push back — undecided ownership means the decision doesn't ship.

5. **Write the record.**
	- See [`output-template.md`](output-template.md). **Use the date the decision was made**, not the date you're writing it up — ask if unclear. File per the repo's decision convention (project `CLAUDE.md`, or ask if unclear).
	- If the user references an upstream `trade-off` or analysis doc, populate `**Analysis:** [link]` in the record and `**Decided in:** [link]` on the upstream side.

## Anti-patterns
- **No alternatives section.** A decision without alternatives isn't a decision; it's a default. If only one option was on the table, say so explicitly.
- **Vague revisit trigger.** "Revisit when needed" means never. Pin to an event or a metric.
- **Ghost-writing.** Don't record a decision the user didn't actually make, and don't invent reasoning from a referenced doc you can't read. Ask the user to restate the load-bearing pieces in their own words.
- **Burying the decision.** Lead with the one-sentence decision. Context follows, doesn't precede.
- **"Owner: TBD."** No owner = no shipping. Ask who owns it before writing.
- **Vague next action.** "Will follow up" doesn't ship. Name a concrete first step (and ideally a date).
- **Relative dates.** "This week" rots. Write the actual date.
