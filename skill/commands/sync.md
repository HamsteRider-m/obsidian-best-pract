# /obos sync

Sync AI index files (Index.md and CLAUDE.md).

## Usage

```
/obos sync
```

## Behavior

### Step 1: Identify Vault Path

Check these locations in order:
1. Current working directory (if has CLAUDE.md)
2. `/Users/hansonmei/OneDrive/obsidian-vault/`
3. Ask user

### Step 2: Scan Vault

Collect information from:
- `Notes/` - Evergreen notes
- `Daily/` - Daily notes and weekly reviews
- `Clippings/` - Web clippings
- `References/` - Reference materials
- `Categories/` - MOC pages

For each file, extract:
- Title (from filename or H1)
- First paragraph (summary)
- Tags and links
- Modified date

### Step 3: Update Index.md

Generate updated `Index.md`:

```markdown
# Index

AI-readable index of vault contents.
Last synced: {YYYY-MM-DD HH:MM}

## Recent Notes

| Note | Summary | Updated |
|------|---------|---------|
| [[note1]] | First line... | 2026-01-27 |
| [[note2]] | First line... | 2026-01-26 |
(top 20 by modified date)

## Categories

- [[Category/Topic1]] - {count} notes
- [[Category/Topic2]] - {count} notes

## Statistics

- Evergreen notes: {count}
- Daily notes: {count}
- Clippings: {count}
- References: {count}
```

### Step 4: Update CLAUDE.md Context

Append/update the "Current Context" section in CLAUDE.md:

```markdown
## Current Context

Last synced: {date}

### Recent Activity
- {recent note 1}
- {recent note 2}

### Active Topics
- {topic with most recent notes}
```

## Success Message

- Index.md updated: {note count} notes indexed
- CLAUDE.md context refreshed
- Tip: AI can now reference your recent notes
