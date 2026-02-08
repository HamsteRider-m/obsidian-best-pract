# /obos link

Smart link suggestions: discover connections between notes and reduce orphans.

## Usage

```
/obos link [note]       # suggest links for a specific note
/obos link --all        # scan orphan notes vault-wide (max 10)
```

## Parameters

| Param | Description |
|-------|-------------|
| `[note]` | Filename or `[[wikilink]]` to analyze |
| `--all` | Scan orphan notes across vault, process up to 10 |

## Vault Path Discovery

Use **Vault Path Discovery from SKILL.md** to determine vault root.

## Single Note Mode (default)

### Step 1: Locate Target Note

- If `[note]` provided, search `Notes/`, `Daily/`, `Clippings/`, `References/` for matching file
- If omitted, infer from conversation context
- If not found, list 5 recent notes and let user pick via AskUserQuestion

### Step 2: Analyze Note Content

Read the target note and extract:
- Core topics and key concepts
- Existing `[[wikilinks]]` (to avoid duplicate suggestions)
- Frontmatter metadata (status, source, tags)

### Step 3: Search for Related Notes

1. Read `Index.md` to get the full note inventory
2. Extract keywords from the target note
3. Use Glob + Grep to find notes sharing:
   - Similar topics or concepts (content keyword match)
   - Overlapping `[[wikilinks]]` (shared references)
   - Same category (MOC membership)
4. Exclude notes already linked from the target

### Step 4: Rank and Present Suggestions

Rank candidates by relevance. Present up to 5 suggestions:

```
建议链接：

1. [[Note Title A]]
   理由：both discuss {shared concept}, and A provides {complementary angle}

2. [[Note Title B]]
   理由：shares reference to [[Common Source]], related through {topic}

3. [[Note Title C]]
   理由：addresses your open question about {topic from target note}
```

Each suggestion MUST include a reason explaining the connection.

### Step 5: User Confirmation

Use AskUserQuestion to let user approve/reject each suggestion:
- Options: "全部添加", "逐条选择", "跳过"
- If "逐条选择": present each link one by one for yes/no

### Step 6: Apply Links

For each approved link:
1. Add `[[wikilink]]` to the target note's `## Related` section (or end of file if no Related section)
2. Optionally add a backlink in the linked note pointing back to the target

## All Mode (`--all`)

### Step 1: Find Orphan Notes

Scan vault for notes with **no incoming links**:
- Read `Index.md` and all note files to build a link graph
- Identify notes that no other note links to
- Exclude: `Index.md`, `CLAUDE.md`, templates, daily notes

### Step 2: Limit Scope

- Cap at **10 orphan notes** to avoid token explosion
- Prioritize by: most recently modified first

### Step 3: Process Each Orphan

For each orphan note, run the single-note analysis (Steps 2-4 above) in batch:
- Present a summary table of all orphans and their top suggestion

```
孤岛笔记链接建议：

| 笔记 | 建议链接 | 理由 |
|------|---------|------|
| [[Orphan A]] | [[Target X]] | {reason} |
| [[Orphan B]] | [[Target Y]] | {reason} |
...
```

### Step 4: Batch Confirmation

Use AskUserQuestion:
- "全部应用" — apply all suggested links
- "逐条选择" — review each one
- "跳过" — cancel

Apply approved links per Single Note Mode Step 6.

## Success Message

**Single note mode**:
- Analyzed: `{note path}`
- Links added: {count}
- Tip: Run `/obos sync` to update your index

**All mode**:
- Orphan notes found: {count}
- Notes processed: {count}
- Links added: {count}
- Tip: Run `/obos sync` to update your index
