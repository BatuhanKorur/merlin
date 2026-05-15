---
name: session-review
description: Mine the current session for durable workflow improvements — propose concrete edits to local/global CLAUDE.md or skills based on friction, repeated patterns, and conventions discovered during work. Use when user says "session review," "what did we learn," "review this session," "what should we update," or is about to exit and asks what can be improved. Do NOT use mid-session (wait until work is done), after trivial/one-shot tasks, or when no friction or pattern worth capturing occurred.
metadata:
  version: 1.0
  last-update: 2026-05-13
  author: Batuhan Korur
---

# Session Review
End-of-session retrospective that turns session learnings into concrete edits to CLAUDE.md files and skills. Unlike the other skills in the chain (`problem-frame` → `brainstorm` → `trade-off` → `decision-log`), this one operates on the *workflow itself*, not on a technical decision. It reads existing config before proposing changes, presents diffs for approval, and writes nothing without confirmation.

## Operating mode
You're a workflow auditor reviewing a completed session. Look for things that **would have changed behavior if they'd been written down before this session started** — that's the bar. If a finding wouldn't have saved time, prevented a misunderstanding, or avoided a wrong turn, it doesn't clear the bar. Err on the side of proposing too little. CLAUDE.md bloat is a real cost — every line added is a line future sessions must parse.

## When NOT to use
- Mid-session — wait until the work is done; premature review misses the full picture
- Trivial or one-shot tasks — "fix this typo" sessions yield nothing worth adding
- Sessions with no friction, repeated patterns, or discovered conventions — say "nothing worth adding" and stop
- User wants a status update or implementation summary — different format
- The learnings are project-specific knowledge that belongs in code comments or docs, not CLAUDE.md

## Quality bar
Every proposed addition must pass **all three** of these tests:
1. **Retroactive test:** Would this have changed behavior earlier in *this* session? If not — skip.
2. **Recurrence test:** Is this likely to come up again in future sessions? One-off oddities don't earn a permanent line.
3. **Obviousness test:** Would a future session reading this think "obviously"? If yes — it's a truism, skip.

## Local vs global discriminator
- **Could this be wrong in another project?** → local (project CLAUDE.md). Project architecture, conventions, naming, tooling quirks, repo-specific patterns.
- **Is this about how I work regardless of project?** → global (`~/.claude/CLAUDE.md`). Communication preferences, meta-workflow patterns, skill behavior tuning, cross-project conventions.
- When in doubt, default to local. Promoting to global later is cheap; demoting is not.

## Workflow
1. **Scan the session for signals.** Review what happened — not a summary, but a targeted scan for:
   - **Friction:** repeated clarifications, corrections, wrong turns, misunderstandings
   - **Conventions discovered:** coding patterns, naming, architecture decisions, tool usage that emerged and should be documented
   - **Skill gaps:** situations where a new skill would have helped, or an existing skill's instructions were insufficient
   - **Missing context:** things you had to ask about or discover that should have been in CLAUDE.md from the start
2. **Read existing config before proposing.** Read the current local CLAUDE.md (if it exists) and `~/.claude/CLAUDE.md`. Check for overlap or contradiction with what you're about to propose. Don't duplicate what's already there. Don't contradict without calling it out.
3. **Draft proposals in three buckets.** Each proposal is a concrete diff — the actual text to add, modify, or remove — not a description of what could be done.
   - **Local CLAUDE.md** — project-specific conventions, patterns, constraints
   - **Global CLAUDE.md** — cross-project workflow rules, preferences, meta-patterns
   - **Skills** — new skill creation or edits to existing skill SKILL.md files
4. **Apply the quality bar.** Run each proposal through the three tests. Drop anything that doesn't pass all three. If nothing survives, say so — an empty review is a valid outcome.
5. **Present for approval.** Show each surviving proposal as a concrete diff with a one-sentence rationale. Group by bucket. The user picks what to apply — nothing is written without explicit confirmation.
6. **Apply approved changes.** Write only what was approved. For CLAUDE.md edits, append to the relevant section or create a new section — don't reorganize existing content unless asked.

## Output format
```
## Session Review — [date]

### Findings
- [one-line finding with category tag: friction / convention / skill-gap / missing-context]
- ...

### Proposals

**Local CLAUDE.md** (`[path]`)
> [concrete text to add/modify, or "no proposals"]
Rationale: [one sentence]

**Global CLAUDE.md** (`~/.claude/CLAUDE.md`)
> [concrete text to add/modify, or "no proposals"]
Rationale: [one sentence]

**Skills**
> [skill name — what to create/edit, or "no proposals"]
Rationale: [one sentence]

### Skipped (didn't pass quality bar)
- [finding] — failed [which test] because [why]
```

Show the "Skipped" section only if you pruned something — it builds trust that the bar is real.

## Anti-patterns
- **Session summary disguised as review.** Recapping what happened isn't the job — extracting *reusable* workflow improvements is. If the output reads like a status report, it's wrong.
- **Truism injection.** "Always test your code" or "read the docs first" — if it's generic advice, it doesn't belong in CLAUDE.md. The bar is specificity: *this project's* tests need `--no-cache`, or *this codebase* uses a non-standard ORM pattern.
- **Proposing too much.** More than 3-4 proposals from a single session is a smell. Either the bar is too low or the existing CLAUDE.md is severely deficient (in which case, flag that separately).
- **Writing without approval.** Every edit requires explicit user confirmation. Present, don't apply.
- **Ignoring existing content.** Proposing something already in CLAUDE.md, or contradicting it without flagging the conflict. Always read before proposing.
- **Global by default.** Most session learnings are project-local. Apply the discriminator honestly — don't promote to global because it "feels universal."
- **Reviewing trivial sessions.** A session where you fixed a typo, answered a question, or ran a one-liner doesn't need a review. Say "nothing worth adding" and stop.
