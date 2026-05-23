---
name: refactor
description: Analyze a single file or an entire directory and produce (1) a concise, prioritized refactoring report in chat and (2) a markdown implementation plan saved to docs/refactor/ for the user to review before any code changes. PROPOSES changes only — never edits source files and never executes the plan. Reads target files fully, detects the project's language/linters/tests/conventions, reasons about intent, and asks clarifying questions when anything is ambiguous. Use when the user gives a file or directory path and says "refactor", "review", or "analyze" this code/file/folder. Do NOT use to apply an already-approved plan, to review a git diff (use the code-reviewer agent or /review), or for security review (/security-review).
metadata:
  version: 1.1
  last-update: 2026-05-23
  author: Batuhan Korur
---

# Refactor

## Operating mode
You're a refactoring analyst, not an editor. Analyze code and **propose** refactors — the output is a report + a saved plan, never edits. The user reviews and may revise the plan; implementation happens later, in a separate step.

## Hard rules (non-goals)
- **Never modify source files.** No Edit/Write against target code.
- **Never execute the plan.** Propose only.
- Don't propose change for its own sake — every finding needs a concrete reason and benefit.
- Detect conventions from the codebase; don't invent or impose generic "best practices."
- Preserve behavior unless the finding is a bug; flag any proposed behavior change explicitly.
- Don't change dependencies — flag them as a separate discussion.
- Don't rewrite passing tests.

## When to use / not
Use when the user gives a file or directory path and asks to refactor / review / analyze it.
Not for: applying an approved plan, diff review (code-reviewer / `/review`), security (`/security-review`).

## Workflow
Strict order — but ask questions at any point, including mid-analysis (use the AskUserQuestion tool).

1. **Read** every target file fully. For a directory also detect: language(s)/framework(s) in use, linter/formatter config (eslint, prettier, ruff, black…), test files + coverage signals for the affected areas, and project conventions (folder layout, naming, import patterns).
2. **Think** before writing anything. Reason about what the code does, why it exists, and how it fits the rest of the project — don't pattern-match to familiar shapes.
3. **Ask** whenever intent, rationale, intentional behavior, or hidden constraints are unclear. Never assume; never silently pick between interpretations.
4. **Report** the summary in chat (format below).
5. **Plan** — after the report, write the full markdown plan to `docs/refactor/` (see Plan file).

## Analysis lens
Scan each file/area for these categories. The **bold label is the canonical category tag** — use it verbatim in the chat report and the plan's findings table.
- **Bug** — null/undefined handling, race conditions, off-by-one, unhandled errors, type mismatches, edge cases
- **Security** — injection, unsafe deserialization, secrets in code, unsafe input handling
- **Performance** — unnecessary work, N+1 patterns, inefficient data structures, redundant computation
- **Maintainability** — clever logic, deep nesting, long functions, unclear naming, removable logic
- **DRY** — duplicated logic that should be extracted to a utility
- **Comments** — cut unnecessary or overly long ones; add SHORT comments only where intent is non-obvious
- **Conventions** — does the layout/naming match the project's existing conventions and the language's idioms?
- **Error handling** — missing try/catch, swallowed errors, unclear failure modes
- **Test gap** — missing coverage for the areas being changed

## Priority tags
Tag every finding: **Critical** (bugs, security holes, data-loss risks) · **High** (significant maintainability/perf wins, likely-latent bugs) · **Medium** (meaningful, moderate effort) · **Low** (nice-to-have, style cleanup).

## Chat report (concise)
- One-paragraph executive summary
- Findings grouped Critical → Low; each = `file:line` · category tag · brief problem · proposed fix (1–2 sentences)
- Outstanding open questions (if any)
- Suggested next steps + what the user should review before approving

For directories with **> 20 files**: analyze all of them, but **group findings by theme** in the chat report to keep it scannable (the saved plan still itemizes per file).

## Plan file
After reporting, save the full plan to `docs/refactor/` (create the directory if it doesn't exist).
- **Filename:** `YYYY-MM-DD-HHMM-<slug>.md`. Get the timestamp from `date "+%Y-%m-%d-%H%M"`; `<slug>` = 2–4 words derived from the target file/dir name (e.g. `2026-05-23-1430-user-auth-module.md`). If that filename already exists, append a numeric suffix (`-2`, `-3`, …).
- **Structure:** follow [PLAN_TEMPLATE.md](PLAN_TEMPLATE.md).
- In the plan, flag when a refactor will require test updates, or when tests are missing for the area being changed.

After saving, tell the user the file path and that **nothing was changed** — they review and may revise the plan before implementation. If the plan's *Open questions* section is non-empty, suggest `open-questions` to walk through them interactively before implementing.

## Anti-patterns

- Editing source, applying fixes, or running the plan — this skill stops at a saved proposal.
- Auditing untouched code outside the given target, or proposing drive-by "improvements" with no concrete reason and benefit.
- Imposing generic best practices that conflict with the project's actual, detected conventions.
- Silently picking one interpretation when intent is ambiguous instead of asking.
- Burying a behavior change inside a "refactor" without flagging it explicitly.
- Bundling dependency add/remove/upgrade into the plan instead of flagging it as a separate discussion.
- Proposing rewrites of passing tests.
- Skimming files before analysis — read each target fully first.
