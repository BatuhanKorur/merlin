---
name: grill-me
description: Interrogate an existing plan to exhaustion — walk every open decision and resolve each branch one by one. Use when user says "grill me," "stress-test this plan," "poke holes in this," "what am I missing." Do NOT use when no plan exists yet (use `superpowers:brainstorming` to co-create one) or when a single decision has 2+ real options worth weighing (use `trade-off`).
metadata:
  version: 2.1
  last-update: 2026-05-23
  author: Batuhan Korur
---

Interrogate an existing plan to exhaustion. Ask one question at a time. Provide your recommended answer alongside each question.

If a question can be answered by exploring the codebase, explore instead of asking.

## Walk order
1. Enumerate the open decisions before probing — don't grill in arrival order.
2. Check whether the user's list is complete — surface any unlisted upstream decisions the listed ones depend on.
3. Probe the most-irreversible / highest-blast-radius decisions first.
4. Decisions that depend on others wait until the parent is resolved.

## When NOT to use
- No plan exists yet → `superpowers:brainstorming` (co-create one first)
- One decision with 2+ real options to weigh → `trade-off`
- Plan already locked, user just wants it built → just build it

## Done when
Every open decision is either (a) resolved, (b) deferred with a concrete revisit trigger, or (c) handed to `trade-off` because it surfaced 2+ real options.
