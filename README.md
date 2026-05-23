# Merlin

Personal global Claude config — a shared `global-claude.md` and a set of opinionated skills used across repos. The skills are deliberately **thinking partners**, not code-generation helpers: they shape *how* Claude collaborates with me, rather than automate output. They sit on a single axis — the decision lifecycle — and cross-link with each other.

`brainstorm` → `trade-off` → `decision-log`

## Global config

- **`global-claude.md`** — operating philosophy. Establishes Claude as a senior collaborator that pushes back, surfaces tradeoffs, and reports honestly, instead of agreeing and shipping.

## Skills

### [`brainstorm`](skills/brainstorm/SKILL.md)
The **workshop**. Forces divergent thinking before any option is weighed — at least five candidates including the obvious, the inverse, the cheap, the over-engineered, and the do-nothing, then prunes by dominance.
- **When:** Option set feels suspiciously narrow ("I'm between A and B"); jumping straight to a 2-option `trade-off`; "I'm not sure what to consider."
- **Result:** ≥5 candidates with one-line descriptions, dominated options pruned, a shortlist ready for `trade-off`.

### [`trade-off`](skills/trade-off/SKILL.md)
The **scales**. Produces an ADR-lite for an open choice: explicit options, criteria locked before scoring, prose scoring, an auditable recommendation, and a concrete revisit trigger.
- **When:** Two or more legitimate options on a non-trivial decision; "X vs Y," "should we use A or B," "tradeoffs of X."
- **Result:** ADR-lite — options, locked criteria, prose scoring, recommendation with rationale, revisit trigger.

### [`decision-log`](skills/decision-log/SKILL.md)
The **court reporter**. Records a decision already made — what was decided, why, alternatives rejected, tradeoffs accepted, and the condition that would reopen it. Pairs with `trade-off`: analysis upstream, record downstream.
- **When:** A decision has just been concluded; "let's lock this in," "log this decision," "ADR for this."
- **Result:** Durable decision record with revisit conditions; pairs with the upstream `trade-off` analysis if one exists.

### [`handoff`](skills/handoff/SKILL.md)
The **relay baton**. Saves the durable state of a session — what landed, the next concrete move, open blockers, live mental model — so a fresh agent can pick up cold. Distinct from `session-review`: captures *transient* project state, not workflow lessons.
- **When:** Natural stopping point in a long session ("let's call it," "wrap up"); start of a new session that wants to inherit the last one ("catch me up," "where did we leave off").
- **Result:** A scannable `<project>/.claude/handoffs/YYYY-MM-DD-<slug>.md` file (under ~60 lines), or a cold-start briefing when loading.

### [`session-review`](skills/session-review/SKILL.md)
The **debrief**. Mines the just-finished session for durable workflow improvements — repeated friction, conventions discovered, premises worth pinning — and proposes concrete edits to CLAUDE.md or skill files. Distinct from `handoff`: captures *workflow lessons*, not project state.
- **When:** End of a session that surfaced friction or new patterns; "session review," "what did we learn," "what should we update."
- **Result:** A list of proposed CLAUDE.md / skill edits with rationale, to accept or reject.

### [`grill-me`](skills/grill-me/SKILL.md)
The **interrogator**. Interviews relentlessly about a plan or design one question at a time, walking each branch of the decision tree and offering a recommended answer per question until shared understanding is reached.
- **When:** Before committing to a non-trivial plan; "grill me on this," "stress-test this design," "interview me about the plan."
- **Result:** A resolved decision tree — open branches named, recommended answers proposed, ambiguity surfaced before implementation starts.

### [`merlin-sync`](skills/merlin-sync/SKILL.md)
The **archivist**. Backs up `~/.claude/CLAUDE.md` and `~/.claude/skills/` to this repo, keeps this README's skill catalog in sync with what's on disk, then commits and pushes — so the global config is versioned in GitHub rather than living on a single laptop.
- **When:** After adding, editing, or removing a global skill, or after editing `global-claude.md`; "sync merlin," "back up my claude config."
- **Result:** New commit `Updated documents YYYY-MM-DD HH:MM:SS` pushed to `origin/main`, with `global-claude.md`, `skills/`, and this README's skill list reconciled.

### [`setup-decision-docs`](skills/setup-decision-docs/SKILL.md)
The **outfitter**. Wires the decision-lifecycle convention into a project's `CLAUDE.md` — scans the repo's layout (flat vs. monorepo), adapts one consolidated template, and safely and idempotently merges a `## Decision-lifecycle records` section so the agent knows where `brainstorm`/`trade-off`/`decision-log` files live and reads them before answering.
- **When:** Starting to keep decision records in a repo; "set up decision docs here," "wire up the trade-off/decision-log convention in this project."
- **Result:** A `## Decision-lifecycle records` section merged into the project (not global) `CLAUDE.md`, with the folder layout filled in and the read-before-answering rules in place.

### [`write-a-skill`](skills/write-a-skill/SKILL.md)
The **blueprint**. Drafts new skills that match this library's house style — reads `trade-off` and `decision-log` as templates, then reproduces their spine (Operating mode, When NOT to use, Workflow, Anti-patterns), a trigger-bearing description, and a Quality bar of trigger/cold-read tests before any file ships.
- **When:** Adding a new global or per-repo skill; "write a skill for X," "help me build a new skill," "scaffold a skill."
- **Result:** New skill directory with a conforming, house-style `SKILL.md` (and optional reference files or scripts), ready to drop into `~/.claude/skills/` or a project's `.claude/skills/`.

## Per-repo integration

The decision-lifecycle skills file their records inside each project. Run `setup-decision-docs` in a repo to wire the convention into that project's `CLAUDE.md` — it scans the layout, adapts a single template, and merges a `## Decision-lifecycle records` section pointing at the repo's `brainstorms/`, `tradeoffs/`, and `decisions/` folders.
