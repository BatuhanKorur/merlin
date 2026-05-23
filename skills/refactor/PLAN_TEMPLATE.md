# Plan template

Copy this structure into the new `docs/refactor/YYYY-MM-DD-HHMM-<slug>.md` file and fill every
placeholder. Delete any section that genuinely doesn't apply (say why in one line). Replace all
`<...>` placeholders and remove these guidance comments before saving.

This document is a **proposal**. No source files have been changed. The user reviews and may revise
it before implementation, which happens in a separate step.

---

# Refactor plan — <target file or directory>

- **Date:** <YYYY-MM-DD HH:MM>
- **Target(s):** <list every analyzed file path>
- **Language / framework:** <detected>
- **Linter / formatter:** <detected config, or "none found">
- **Status:** Proposed — awaiting review. No changes applied.

## Executive summary
<One short paragraph: the shape of the code, the headline findings, and the overall
recommendation. State explicitly if the code is broadly healthy and only minor work is suggested.>

## Findings

| # | Priority | Category | File:line | Summary |
|---|----------|----------|-----------|---------|
| 1 | Critical | Bug | `path:line` | <one line> |
| 2 | High | Maintainability | `path:line` | <one line> |
| … | | | | |

<Priorities: Critical > High > Medium > Low. Categories: Bug, Security, Performance,
Maintainability, DRY, Comments, Conventions, Error handling, Test gap.>

## Finding details

### 1. <title> — `Critical` · <category> · `path:line`
- **Current state:** <brief code excerpt or description of what's there now>
- **Proposed change:** <what to do>
- **Rationale:** <concrete reason and benefit — why this is worth doing>
- **Risk / behavior change:** <does this change observable behavior? note it explicitly, or "none — refactor only">
- **Test impact:** <tests to add or update; or "none">

### 2. <title> — `High` · <category> · `path:line`
- **Current state:** …
- **Proposed change:** …
- **Rationale:** …
- **Risk / behavior change:** …
- **Test impact:** …

<Repeat one section per finding, in priority order.>

## Suggested ordering
<Recommended sequence for applying the changes, noting dependencies (e.g. "do #3 before #5
because #5 builds on the extracted helper"). Call out changes that are safe to do independently.>

## Rollback notes
<For each significant change, how to revert it cleanly — e.g. "single commit, revert the commit"
or "behind no flag; restore the original function body from git history".>

## Open questions
<Anything the user must answer before execution: ambiguous intent, hidden constraints, behavior
that may be intentional, dependency changes that need a separate decision. Omit if none.>

## Dependency changes (separate discussion)
<Any proposed add/remove/upgrade of dependencies, flagged here and NOT bundled into the refactor.
Omit if none.>
