# Session-review output template

Used when presenting session-review findings for approval. Group by destination bucket. The "Skipped" section is optional — include only when you pruned things, to show the quality bar is real.

```markdown
## Session Review — YYYY-MM-DD

### Findings
- [correction] User pushed back on X because Y
- [friction] Wrong turn on Z because A wasn't documented
- [convention] Discovered repo uses N for M
- [skill-gap] Existing skill K didn't cover case L
- [missing-context] Had to ask about P; should have been in CLAUDE.md

### Proposals

**Local CLAUDE.md** (`./CLAUDE.md`)
> ```
> [concrete diff — exact text to add/modify/remove]
> ```
> Rationale: [one sentence]

**Global CLAUDE.md** (`~/.claude/CLAUDE.md`)
> ```
> [concrete diff, or "no proposals"]
> ```
> Rationale: [one sentence]

**Memory** (new entry: `[filename.md]`)
> ```yaml
> ---
> name: [slug]
> description: [one line]
> metadata:
>   type: [user | feedback | project | reference]
> ---
> [body]
> ```
> Plus `MEMORY.md` index line:
> `- [Title](filename.md) — one-line hook`
> Rationale: [one sentence]

**settings.json** (`./.claude/settings.json` or `~/.claude/settings.json`)
> ```json
> [concrete JSON snippet to add/modify]
> ```
> Rationale: [one sentence]

**Skills**
> [skill name] — what to create/edit
> ```
> [concrete diff, or new file content]
> ```
> Rationale: [one sentence]

### Skipped (didn't pass quality bar)
- [finding] — failed [retroactive | recurrence | obviousness] test because [why]
```
