# /obos sync

Scan vault, update index files, and output a health report.

## Usage

```
/obos sync            # full sync: update Index.md + CLAUDE.md + health report
/obos sync --status   # read-only dashboard only, no file modifications
```

## Vault Path Discovery

Use Vault Path Discovery from SKILL.md to determine the vault root path.

## Mode Detection

`--status` flag → **Status Mode** (read-only, skip to Step 4).
No flag → **Default Mode** (full sync).

---

## Step 1: Scan Vault

Scan directories defined in SKILL.md Vault Structure (`Notes/`, `Daily/`, `Clippings/`, `References/`, `Categories/`).

For each markdown file, extract:
- Title (filename or first H1)
- First meaningful line (skip frontmatter/heading, truncate 60 chars)
- Frontmatter `status` field (draft/refined)
- Wikilinks (`[[...]]` references) — both outgoing links and targets
- Modified date

**Build link graph**: Construct an in-memory map of `note → [outgoing links]` and `note → [incoming links]`. This graph powers orphan detection (Step 4) and broken link detection (Step 4).

**Performance guard**: Vault >500 files → scan only last 90 days for Recent Notes. Categories and statistics always cover full vault.

## Step 2: Update Index.md

Write `Index.md` at vault root:

```markdown
# Index
Last synced: {YYYY-MM-DD HH:MM}

## Recent Notes
| Note | Summary | Status | Updated |
|------|---------|--------|---------|
| [[note]] | First line... | draft | 2026-01-27 |
(top 50 by modified date)

## Categories
- [[Category/Topic]] - {count} notes

## Statistics
- Evergreen notes: {count} (draft: {n}, refined: {n})
- Daily notes: {count}
- Clippings: {count}
```

- Sort Recent Notes by modified date descending, limit **50**.
- Status column: frontmatter `status` value, or `-` if absent.
- Categories: each MOC page with count of notes linking to it.

## Step 3: Update CLAUDE.md

**Boundary protection**: ONLY modify the `## Current Context` section. All other sections MUST NOT be touched.

1. Read existing CLAUDE.md.
2. Locate `## Current Context` (from heading to next `## ` or EOF).
3. Replace (or append if absent) with:

```markdown
## Current Context
Last synced: {date}

### Recent Activity
- {recent note 1}
- {recent note 2}
(up to 5 most recently modified notes)

### Active Topics
- {topic with most recent notes}
(up to 3 topics from Categories with most recent activity)
```

4. Write back, preserving all other sections exactly.

## Step 4: Health Report

Output in both default and `--status` modes.

### Orphan Notes

Notes with **no incoming links** from the link graph (exclude Index.md, CLAUDE.md, templates, daily notes). List up to 10:
```
Orphan notes (no incoming links): {count}
- Notes/example.md
- Notes/another.md
```

If orphan count > 0, suggest: `运行 /obos link --all 来为孤岛笔记建立连接`

### Broken Links

Wikilinks pointing to **non-existent files** from the link graph. List up to 10:
```
Broken links: {count}
- [[missing-note]] referenced in Notes/source.md
- [[old-note]] referenced in Notes/other.md
```

If broken count > 0, suggest: `检查上述断链，可能是笔记被重命名或删除`

### Maturity Distribution

```
Maturity: {n} draft, {n} refined, {n} untagged
```

### Summary Dashboard

```
Vault Health Dashboard
──────────────────────
Total notes: {count}
  Evergreen: {n} | Daily: {n} | Clippings: {n}
Orphan notes: {n}
Broken links: {n}
Maturity: {n} draft, {n} refined, {n} untagged
Last synced: {timestamp}
```

## Output

**Default mode**: Index.md updated + CLAUDE.md Current Context refreshed + health report.

**`--status` mode**: Read-only scan + health report only.
