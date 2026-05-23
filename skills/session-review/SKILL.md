---
name: session-review
description: Use when user says "session review," "what did we learn," "review this session," "what should we update," "what can we improve," or is wrapping up and asks what's worth keeping. Skip mid-session, after trivial/one-shot tasks, or when no friction or pattern worth capturing occurred.
metadata:
  version: 2.2
  last-update: 2026-05-23
  author: Batuhan Korur
  disable-model-invocation: true
---

# Session Review
End-of-session retrospective that turns session learnings into concrete edits. Unlike the decision-making skills (`brainstorm` → `trade-off` → `decision-log`), this one operates on the *workflow itself*. Fans out to five destinations:

```
session-review → { local CLAUDE.md, global CLAUDE.md, memory, settings.json, skills }
```

## At a glance
| Step | Action |
|------|--------|
| 1 | Scan the session for signals (corrections first, then friction, conventions, gaps) |
| 2 | Read existing config across all destinations before proposing |
| 3 | Draft proposals in five buckets, one concrete diff each |
| 4 | Apply the quality bar — drop anything that fails the three tests |
| 5 | Present diffs grouped by bucket; await explicit approval |
| 6 | Apply only what was approved |

## Operating mode
You're a workflow auditor reviewing a completed session. **Look for things that would have changed behavior if they'd been written down before this session started — that's the bar.** If a finding wouldn't have saved time, prevented a misunderstanding, or avoided a wrong turn, it doesn't clear the bar. Err on the side of proposing too little. Configuration bloat is a real cost — every line added is a line future sessions must parse.

## When NOT to use
- Mid-session — wait until the work is done; premature review misses the full picture
- Trivial or one-shot tasks — "fix this typo" sessions yield nothing worth adding
- Sessions with no friction, repeated patterns, or discovered conventions — say "nothing worth adding" and stop
- User wants a status update or implementation summary — different format
- The learnings are project-specific knowledge that belongs in code comments or docs

## Quality bar
Every proposed addition must pass **all three** tests:
1. **Retroactive test:** Would this have changed behavior earlier in *this* session? If not — skip.
2. **Recurrence test:** Is this likely to come up again in future sessions? One-off oddities don't earn a permanent line.
3. **Obviousness test:** Would a future session reading this think "obviously"? If yes — it's a truism, skip.

## Destination discriminator

| Type of finding | Destination |
|---|---|
| Project-specific knowledge (architecture, tooling, naming, conventions) | Local `CLAUDE.md` |
| Cross-project workflow rule or communication preference | Global `~/.claude/CLAUDE.md` |
| User identity/role facts, validated preferences with rationale, current project state | Memory entry (pick type: user / feedback / project / reference) |
| Recurring automation, hook, permission, env var | `settings.json` (project or global) |
| Reusable process technique or domain pattern | Skill (new or edit existing) |

**Default bias:** prefer local CLAUDE.md and memory (cheap to demote/remove). Be conservative with global CLAUDE.md and settings.json — broader blast radius, harder to undo.

**Common routing mistake:** putting a recurring automation in CLAUDE.md (where Claude has to remember it) instead of `settings.json` (where the harness enforces it). Or putting a user preference in global CLAUDE.md instead of memory. The discriminator exists to prevent this — see Anti-patterns.

**Same finding, multiple buckets:** sometimes a single finding produces both a rule (CLAUDE.md) and its rationale/recurrence context (memory). That's not duplication if the buckets serve different purposes — policy in one, context in the other. Justify the split inline.

## Workflow

1. **Scan the session for signals.** Targeted scan, not summary. In priority order:
	- **Corrections (highest signal):** things the user said weren't what they wanted, pushed back on, asked you to redo, or "no, do it this way." Negative feedback is the strongest evidence of a misalignment worth fixing.
	- **Friction:** repeated clarifications, wrong turns, misunderstandings that weren't outright corrections.
	- **Conventions discovered:** coding patterns, naming, architecture decisions, tool usage that emerged and should be documented.
	- **Skill gaps:** situations where a new skill would have helped, or an existing skill's instructions were insufficient.
	- **Missing context:** things you had to ask about or discover that should have been documented from the start.

2. **Read existing config across destinations before proposing.**
	- Local `CLAUDE.md` (if present)
	- Global `~/.claude/CLAUDE.md`
	- Memory (`MEMORY.md` index, then relevant entries)
	- `settings.json` (project `.claude/settings.json` and global `~/.claude/settings.json`)
	- Any skill being proposed for edit
	- Don't duplicate what's already there. Don't contradict without flagging the conflict explicitly.
	- **If you can't read a destination**, say so and present proposals for that bucket as **provisional** — flag what needs to be verified before applying.

3. **Draft proposals in five buckets.** Each proposal is a **concrete diff** — the actual text / JSON / frontmatter to add, modify, or remove. Not a description of what could be done.

4. **Apply the quality bar.** Run each proposal through the three tests. Drop anything that fails. An empty review is a valid outcome — say "nothing worth adding" and stop.

5. **Present for approval.** Show each surviving proposal as a concrete diff with a one-sentence rationale, grouped by bucket. Include a "Skipped" section if you pruned things — it builds trust that the bar is real. **Nothing is written without explicit confirmation.**

6. **Apply approved changes only.**
	- **CLAUDE.md:** append to relevant section or create new; don't reorganize unless asked.
	- **Memory:** write the entry file with proper frontmatter (name / description / type) + update `MEMORY.md` index with a one-line pointer.
	- **settings.json:** validate JSON before writing; never strip existing keys.
	- **Skills:** apply approved edits using the project's skill-authoring patterns. For new skills, write `SKILL.md` and any sibling files.

## Output template
See [`output-template.md`](output-template.md).

## Anti-patterns
- **Session summary disguised as review.** Recapping what happened isn't the job — extracting *reusable* workflow improvements is. If the output reads like a status report, it's wrong.
- **Wrong destination.** Routing a recurring automation to CLAUDE.md instead of `settings.json`, or a user preference to global CLAUDE.md instead of memory. Use the discriminator honestly.
- **Truism injection.** "Always test your code" or "read the docs first" — generic advice doesn't belong anywhere. The bar is specificity: *this project's* tests need `--no-cache`, or *this codebase* uses a non-standard ORM pattern.
- **Proposing too much.** More than 3-4 proposals across all buckets from a single session is a smell. Either the bar is too low, or the existing config is severely deficient (flag that separately).
- **Writing without approval.** Every edit requires explicit user confirmation. Present, don't apply.
- **Ignoring existing content.** Proposing something already in config, or contradicting it without flagging the conflict. Always read before proposing.
- **Global by default.** Most session learnings are project-local or memory-shaped. Apply the discriminator honestly — don't promote to global because it "feels universal."
- **Reviewing trivial sessions.** Fixing a typo or running a one-liner doesn't need a review. Say "nothing worth adding" and stop.
