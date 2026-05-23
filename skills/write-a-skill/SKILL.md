---
name: write-a-skill
description: Author a new agent skill that matches this library's house style — frontmatter+metadata, sibling-positioning, Operating mode, When NOT to use, Workflow, Output template, Anti-patterns. Use when user says "write a skill," "create a skill," "build a skill," "make me a skill that…," "turn this prompt/workflow into a skill," or "scaffold a skill." Do NOT use for a one-off prompt not meant to be reused (just write the prompt), for a project-specific CLAUDE.md rule (that's CLAUDE.md territory), or for a tiny copy-edit to an existing skill (just edit it — this skill is for authoring and restructuring).
metadata:
  version: 2.0
  last-update: 2026-05-23
  author: Batuhan Korur
---

# Write a Skill
Author skills that are indistinguishable in shape from the rest of this library. The deliverable is a folder at `~/.claude/skills/<name>/` (global) or `<project>/.claude/skills/<name>/` (project-scoped) containing at least a `SKILL.md`. Distinct from a one-off prompt (not reusable, no folder) and from a CLAUDE.md rule (always-on project memory, not a triggered capability). Distinct from the plugin `skill-creator:skill-creator` — that's a generic authoring tool; this skill specifically reproduces *this* library's house style, so prefer it when consistency with the existing skills matters. After a global skill ships, suggest `merlin-sync` so it gets backed up and added to the catalog.

## Operating mode
You write for *this* library, not a generic one. Every skill you produce should read like it was authored by the same hand as `trade-off`, `decision-log`, and `handoff` — same spine, same voice, same density. The cardinal failure mode is **generic-doc drift**: producing a "Quick start / Features / Advanced usage" skill that works but looks foreign next to the others. Before drafting anything, read `~/.claude/skills/trade-off/SKILL.md` and `~/.claude/skills/decision-log/SKILL.md` — they are the canonical templates. Imitate their structure directly.
**Scale the rigor to the skill.** A narrow single-task tool needs little more than a sharp description, a short workflow, and a couple of anti-patterns. A multi-mode workflow skill (like `handoff`) earns the full spine plus a Quality bar. Don't ceremony a small skill; don't under-build a load-bearing one.

## When NOT to use
- One-off prompt with no reuse → just write the prompt; don't scaffold a folder
- An always-on project convention → that belongs in the project's `CLAUDE.md`, not a triggered skill
- A tiny content tweak to an existing skill → just edit it (and bump `last-update`)
- The user wants the skill *executed*, not authored → invoke that skill, don't write a new one

## Workflow
1. **Gather only what you can't infer.** If the opening message already pins the purpose ("a skill that converts JPEGs to PNGs"), skip straight to the open questions. Use `AskUserQuestion` (one batch, ≤3 questions) for the rest — structured answers beat a wall of prose. The questions that actually matter:
   - **Shape** — narrow tool / multi-step workflow / reference knowledge / stylistic guidance? (drives which spine sections apply)
   - **Output** — does it produce a file artifact, or is it conversational? (drives whether it needs an Output template)
   - **Trigger boundary** — what should fire it, and crucially *what must NOT* (the false-positive cases)
   - **Sibling overlap** — does it overlap an existing skill in `~/.claude/skills/`? If so, the two must be positioned against each other (see below).
   Don't over-interrogate. Once you can draft a reasonable v1, draft it — reviewing a concrete draft is faster than answering more abstract questions.
2. **Read the templates.** Open `~/.claude/skills/trade-off/SKILL.md` and `~/.claude/skills/decision-log/SKILL.md`. Match their section order and voice.
3. **Draft at `~/.claude/skills/<name>/SKILL.md`** following the house style (next section). Pick the body shape that fits (procedural / reference-heavy / decision-tree). Write the description last and hardest — it's the load-bearing field.
4. **Run the Quality bar** against your draft before showing it. Fix failures first.
5. **Review with the user.** Show the draft, summarize what you produced in two lines, and ask one focused `AskUserQuestion`: finalize / needs changes / wrong direction. Iterate in place until approved.
6. **Confirm install + suggest backup.** The skill is live once the folder is in its skills directory. If it's a *global* skill (`~/.claude/skills/`), suggest running `merlin-sync` to back it up and add it to the README catalog. For a project-scoped skill, skip `merlin-sync` (it only handles global config) — commit it with the project instead.

## The house style
This is the spine. Read it as "match what's visible in the library," not a rigid checklist — add sections when the skill earns them.

**Frontmatter** — `name` (kebab-case, matches the folder exactly, no version numbers), `description` (see next section), and a `metadata:` block (`version`, `last-update` as `YYYY-MM-DD`, `author: Batuhan Korur`). Bump `version` and `last-update` on every substantive edit.

**The spine (in order):**

| Section | Purpose | Universal? |
|---|---|---|
| `# Title` + framing ¶ | One paragraph positioning the skill *against its siblings* — "Pairs with X," "Distinct from Y," "slots before Z." This is how the library avoids skill collisions as it grows. | **Yes** |
| `## Operating mode` | The persona/stance the skill should adopt + a bold "**Scale the rigor to…**" line. | **Yes** |
| `## When NOT to use` | Bulleted negative cases, each redirecting (→ sibling skill, or "just answer"). | **Yes** |
| `## Quality bar` | Explicit pass/fail tests the output must clear. | Only for load-bearing skills (cf. `handoff`) |
| `## Workflow` | Numbered, opinionated steps with embedded *why* and the failure each step prevents. Bold lead-in per step. | **Yes** for procedural skills |
| `## Output template` | A concrete fenced markdown block. | Only when the skill produces a document |
| `## Anti-patterns` | Named failure modes, **bolded**, each with the tell + the fix. | **Yes** |

**Body shape** — pick one: *procedural* (Workflow + steps, most common), *reference-heavy* (Quick reference table + detailed sections), or *decision-tree* (route between sub-tasks by condition, cf. `handoff`'s save/load/list modes).

**Voice** — imperative, not descriptive ("Use X" not "you can use X"). Specific, not general (concrete values, not "an appropriate value"). Bullets, tables, and fenced blocks over paragraphs. No marketing tone, no hedging.

## Writing the description
The description is the **only** thing the agent sees when deciding whether to load the skill — it's surfaced in the system prompt next to every other skill. This is the single highest-leverage field; a vague one means the skill never fires. The house formula:

1. **What it does** — one phrase, em-dash framed. (`Produce a structured ADR-lite for an open technical or design choice — …`)
2. **`Use when`** — the *actual quoted phrases* a user would say (`"which approach," "X vs Y," "should we use X or Y"`).
3. **`Do NOT use`** — the most likely false positives, each redirecting to the right sibling (`Do NOT use when a decision has already been made (use `decision-log`)…`).

**Match length to ambiguity.** An unambiguous domain (`frontend-design`) needs two sentences; a skill that sits next to confusable siblings (`trade-off` vs `decision-log` vs `brainstorm`) needs the full formula so the agent can tell them apart. Max ~1024 chars, third person.

Worked example — read the `description` line in `trade-off/SKILL.md`. It does all three parts and disambiguates from three sibling skills in one paragraph.

## Quality bar
Run every draft through these before showing the user:
- **Trigger test.** Write 5 messages that *should* fire the skill and 5 that *shouldn't*. Does the description cleanly separate them? If two cross the line, sharpen the `Use when` / `Do NOT use` lines.
- **Cold-read test.** If a fresh agent loaded only this SKILL.md, could it execute the workflow step by step without guessing? Vague steps fail this.
- **No-conflict test.** Description and body must agree (don't say "always produces a file" up top and "respond inline when short" below).
- **Brevity test.** Can any section lose 30% without losing information? If yes, cut. Library skills run ~70–110 lines.
- **House-style test.** Side-by-side with `trade-off`, does it look like the same author wrote it? If not, it drifted.

## When to add scripts
Bundle a script (in `scripts/`, referenced by relative path) when the operation is **deterministic** (validation, formatting, a fixed transform), when the same code would otherwise be regenerated every run, or when errors need explicit handling. Scripts save tokens and beat generated code on reliability. Don't add a script for anything that needs judgment — that's the skill's job.

## When to split files
Keep SKILL.md scannable. Split content into a sibling file (referenced one level deep) when:
- A single reference section would push the file past ~150 lines, or is dense lookup material the agent only sometimes needs (cf. the old skill-creator's `format_guide.md`).
- The skill produces files in a repo and needs a per-repo CLAUDE.md integration block → ship it as `snippet.md` (cf. `trade-off/snippet.md`, `decision-log/snippet.md`).

Targets: aim lean (~70–110 lines like the rest of the library); ~500 lines is the hard ceiling, never the goal.

## Anti-patterns
- **Generic-doc drift.** A "Quick start / Features / Advanced usage" skill. It works but looks foreign. Match the spine — read `trade-off` first.
- **Weak description.** No quoted triggers, no `Do NOT use`, or a vague "helps with X." The agent can't distinguish it from neighbors, so it never fires (or fires wrong). This is the #1 cause of a dead skill.
- **No sibling positioning.** A framing paragraph that describes the skill in isolation. As the library grows, un-positioned skills collide. Always say what it pairs with and what it's distinct from.
- **Over-interrogating in gather.** More than ~3 structured questions before drafting is almost always too many. Draft a v1 and iterate against the concrete thing.
- **Prose instead of procedure.** A skill body is instructions for an agent, not a blog post. Numbered steps, bullets, tables.
- **Hosted-environment idioms.** `ask_user_input_v0`, `present_files`, `/mnt/user-data/outputs/`, `/home/claude/` — these are from Anthropic's hosted skills and **do not exist in Claude Code**. Use `AskUserQuestion`, real `~/.claude/skills/` paths, and relative references.
- **Inventing tools or paths.** Don't reference a binary, script, or file that isn't real and available. If the skill needs a dependency, state it explicitly.
- **Monolithic SKILL.md.** Past ~150 lines of dense reference, split it out and link one level deep.
- **Shipping without the Quality bar.** Skills are reused many times; an unreviewed trigger boundary fires on the wrong tasks for months. Run the tests before review.
