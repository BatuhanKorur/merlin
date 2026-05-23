---
name: brainstorm
description: Force divergent thinking before any option is weighed — generate ≥5 candidates including the obvious, the inverse, the cheap, the over-engineered, and the do-nothing, then prune dominated ones. Use when user says "what are my options," "help me brainstorm," "explore approaches," "I'm between A and B" (and the set is suspiciously narrow), "I'm not sure what to consider," or jumps straight to `trade-off` with only two lazy options. Do NOT use when options are already clear and varied (go straight to `trade-off`), when the problem isn't framed yet (pin down what you're solving first), or for trivial / obvious tasks.
metadata:
  version: 1.0
  last-update: 2026-05-13
  author: Batuhan Korur
---

# Brainstorm
Upstream skill that widens the option set before `trade-off` weighs anything. Quantity first, prune second. Lighter than other skills: file output is optional, default no — most brainstorms land their survivors directly into a trade-off doc and leave no separate trail. Slot: `brainstorm` → `trade-off` → `decision-log`.

## Operating mode
You're a divergent-thinking forcing function, not a critic and not a picker. Refuse to converge while the field is too narrow. Quantity before quality. No critique during generation — that comes in the prune step. The cardinal failure mode here is fake-divergence: producing 5 candidates that all sit on the same axis. Force breadth by structure (see required slots below), not vibes.
**Scale the rigor to the situation:** if the user genuinely only has 2 viable options after honest effort, name that and hand straight to `trade-off`. Don't manufacture filler to hit the count.

## When NOT to use
- Options are already clear and varied; user just wants them weighed → `trade-off`
- Problem isn't sharply stated yet → pin down what you're actually solving first
- Decision already made → `decision-log`
- Trivial / obvious choice → just answer
- Pure ideation with no upcoming decision — fine, but don't pretend this skill applies

## Workflow
1. **State the goal.** What do these options serve? Refuse to brainstorm in the air — without knowing what the options are *for*, divergence is theater.
2. **Diverge — generate ≥5 candidates with the required slots.** No critique yet. One short sentence each. The required slots:
	- **The obvious one** — what the user likely already had in mind.
	- **The inverse** — the opposite move, or doing less of what's currently happening.
	- **The cheap one** — lowest cost / fastest / dumbest version that still addresses the goal.
	- **The over-engineered one** — the maximalist build-the-platform version. Often clarifies what the right scope *isn't*.
	- **The do-nothing / status quo** — always include. If it's "not viable," say so explicitly — don't omit it.
	- Plus any extras the user surfaces or you legitimately spot.
3. **Prune dominated options.** An option is *dominated* if another candidate is at least as good on every meaningful axis. Drop it and name why. Also drop options that fail a hard requirement (out before any scoring). Pruning by gut feel ("doesn't feel right") is not allowed — save real comparison for `trade-off`.
4. **Surface 2–4 survivors.** Hand them off to `trade-off` with one-sentence pitches. If only one option survives pruning, stop — that's not a brainstorm result, it's a decision. Suggest `decision-log` instead.
5. **Decide whether to save a file.** Default: **no**, surface survivors in chat and let them land in the trade-off doc. Save a brainstorm file *only* when: the candidate set was non-obvious and worth a paper trail ("we considered X and Y, dropped them for these reasons"), or the user explicitly asks. When a file is produced, file per the repo's brainstorm convention (see project `CLAUDE.md`, or ask if unclear).

## Output template (only when a file is produced)
```markdown
# Brainstorm: [one-phrase title]

**Date / context:** YYYY-MM-DD, [where this came up]

**Goal (what these options serve):** ...

**All candidates generated:**
- **Obvious — [name]:** one-sentence description
- **Inverse — [name]:** ...
- **Cheap — [name]:** ...
- **Over-engineered — [name]:** ...
- **Do-nothing / status quo:** ... (or "not viable because ...")
- **[Extra] — [name]:** ...

**Pruned (and why):**
- **[Option]** — dropped because [dominated by X on every axis / fails hard requirement / not viable because ...]

**Survivors handed to trade-off:**
- **[Option]** — short pitch
- **[Option]** — short pitch

**Frame:** _(link or N/A)_
**Trade-off:** _(populated when promoted)_
```

For the default in-chat mode, deliver the same content as a tight list — no file.

## Anti-patterns
- **Fewer than 5 candidates.** Lazy. Apply the required slots and the missing one usually appears.
- **All variants on one axis.** "Bigger / smaller / medium" isn't divergence — it's one dimension dressed up. The inverse and the do-nothing exist precisely to break this.
- **Critiquing during generation.** Kills weird-but-useful candidates. Diverge first, prune second — never interleave.
- **Strawman candidates.** Adding a deliberately bad option to make a pre-pick look good. Same failure as in `trade-off` — don't.
- **Skipping do-nothing.** Status quo is always a candidate, even if "not viable." Say so explicitly; the silent skip is the bias.
- **Pruning by gut.** "Doesn't feel right" is not dominance. If you can't name what dominates it, keep it.
- **Brainstorm-as-decision.** Picking the winner inside brainstorm. Brainstorm produces *options*; `trade-off` weighs them; `decision-log` records the commit.
- **Brainstorm-as-theater.** Forcing 5 candidates when 2 are real and 3 are filler. Name the narrow field, skip to `trade-off`.
