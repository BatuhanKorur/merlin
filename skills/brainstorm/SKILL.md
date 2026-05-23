---
name: brainstorm
description: Use when user asks to brainstorm, says "help me brainstorm," "brainstorm on this," "what are my options," "explore approaches," "I'm between A and B" with a suspiciously narrow set, or jumps to `trade-off` with only two lazy options. Skip when options are already clear and varied (go to `trade-off`), the problem isn't framed yet, or for trivial/obvious choices.
metadata:
  version: 1.4
  last-update: 2026-05-23
  author: Batuhan Korur
---

# Brainstorm
Upstream skill that widens the option set before `trade-off` weighs anything. Slot: `brainstorm` → `trade-off` → `decision-log`.

## At a glance
| Step | Action |
|------|--------|
| 1 | State the goal — what do these options serve? |
| 2 | Diverge: generate ≥5 candidates, one per required slot |
| 3 | Prune dominated candidates |
| 4 | Hand 2–4 survivors to `trade-off` |

**Required slots:** obvious · inverse · cheap · over-engineered · do-nothing (+ extras)

## Operating mode
You're a divergent-thinking forcing function — not a critic, not a picker. **Quantity before quality; no critique until the prune step.** Refuse to converge while the field is too narrow. The cardinal failure mode is fake-divergence: 5 candidates all sitting on the same axis. Force breadth by structure (the required slots), not vibes.

**Scale the rigor to the situation:** if the user genuinely has only 2 viable options after honest effort, name that and hand straight to `trade-off`. Don't manufacture filler to hit the count.

## When NOT to use
- Options are already clear and varied; user just wants them weighed → `trade-off`
- Problem isn't sharply stated yet → pin down what you're actually solving first
- Decision already made → `decision-log`
- Trivial / obvious choice → just answer
- Pure ideation with no upcoming decision — fine, but don't pretend this skill applies

## Workflow
1. **State the goal.** What do these options serve? Refuse to brainstorm in the air — without knowing what the options are *for*, divergence is theater. Technical prompts often hand you a symptom in place of a goal — reconstruct it explicitly (`eliminate X / preserve Y / under constraint Z`).

2. **Diverge — generate ≥5 candidates; all five required slots below are mandatory, extras as warranted.** One short sentence each.
	- **The obvious one** — what the user likely already had in mind.
	- **The inverse** — the opposite move, or doing less of what's currently happening.
	- **The cheap one** — lowest cost / fastest / dumbest version that still addresses the goal.
	- **The over-engineered one** — the maximalist build-the-platform version. Usually gets pruned, and that's the point: its job is to clarify what the right scope *isn't*, not to win.
	- **The do-nothing / status quo** — always include. If it's "not viable," say so explicitly — don't omit it.
	- Plus any extras the user surfaces or you legitimately spot.

3. **Prune dominated options.**
	- **Dominance test:** name the axes you're comparing on (cost, speed, scope, reversibility, etc.), then drop any option that's *dominated* — i.e., another candidate is at least as good on every axis. Name what dominates it.
	- Also drop options that fail a hard requirement (out before any scoring).
	- Pruning by gut feel ("doesn't feel right") is not allowed — save real comparison for `trade-off`.

4. **Surface 2–4 survivors.** Hand them off to `trade-off` with one-sentence pitches. If only one option survives pruning, stop — that's not a brainstorm result, it's a decision. Suggest `decision-log` instead.

5. **Decide whether to save a file.** Default: **no** — surface survivors in chat and let them land in the trade-off doc. Save a brainstorm file *only* when the candidate set was non-obvious and worth a paper trail ("we considered X and Y, dropped them for these reasons"), or the user explicitly asks. When a file is produced, see [`output-template.md`](output-template.md) and follow the repo's brainstorm convention (project `CLAUDE.md`, or ask if unclear).

## Anti-patterns
- **Fewer than 5 candidates.** Lazy. Apply the required slots and the missing one usually appears.
- **All variants on one axis.** "Bigger / smaller / medium" isn't divergence — it's one dimension dressed up. The inverse and the do-nothing exist precisely to break this.
- **Critiquing during generation.** Kills weird-but-useful candidates. Diverge first, prune second — never interleave.
- **Strawman candidates.** Adding a deliberately bad option to make a pre-pick look good. Same failure as in `trade-off` — don't.
- **Skipping do-nothing.** Status quo is always a candidate, even if "not viable." Say so explicitly; the silent skip is the bias.
- **Pruning by gut.** "Doesn't feel right" is not dominance. If you can't name what dominates it, keep it.
- **Brainstorm-as-decision.** Picking the winner inside brainstorm. Brainstorm produces *options*; `trade-off` weighs them; `decision-log` records the commit.
- **Brainstorm-as-theater.** Forcing 5 candidates when 2 are real and 3 are filler. Name the narrow field, skip to `trade-off`.
