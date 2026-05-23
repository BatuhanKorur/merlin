# Handoff save template

Used by Step 6 of Save mode in `SKILL.md`. Filename: `<project>/.claude/handoffs/YYYY-MM-DD-<slug>.md`.

```markdown
# Handoff — YYYY-MM-DD — <slug>

## What landed
- <decision or shipped thing, one line>
- <2–5 bullets total>

## Next move
<One or two concrete actions. File / line / decision specific.
Bad: "continue Input work." Good: "Add Label component at design/src/ui/label/
mirroring Button — Reka Primitive, --text-xs / ink-2 / font-medium per spec.">

## Open questions / blockers
- <item waiting on a decision or research>
- (or "(none)")

## Live context
<Load-bearing facts not yet captured in CLAUDE.md / code / docs.
Mark items that should be folded in via `session-review` with `[→ session-review]`.>

## Suggested skills for next session
<Optional. Only when the next move maps cleanly — e.g.
"/ui-review on Label once shipped" or "/trade-off if we need to pick between A and B.">

## Artifacts
- **Commits:** <SHA list, or "none">
- **Key files:** <3–5 high-signal paths, not exhaustive>
- **Docs / ADRs:** <links to Notion or local decision files>
```
