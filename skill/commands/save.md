# /obos save [type] [--deep]

Save conversation insights to the vault. Fast by default; `--deep` triggers Socratic guidance.

## Usage

```
/obos save [type] [--deep]
```

**Two independent dimensions**:

- **Type** (where to save): `evergreen`, `daily`, `clip`, `meeting`
- **Maturity** (processing depth): `draft` (default), `refined` (via `--deep`)

## Step 1: Identify Vault Path

Use Vault Path Discovery from SKILL.md.

## Step 2: Extract Insight

Analyze the current conversation to identify:
- Key insight or conclusion
- Supporting context
- Related topics for `[[wikilinks]]`

## Step 3: Determine Type

If user specified a type, use it. Otherwise auto-detect:

| Type | Signal | Path |
|------|--------|------|
| `evergreen` | Standalone concept, reusable idea, principle | `Notes/{title}.md` |
| `daily` | Task update, fleeting thought, log entry | Append to `Daily/{YYYY-MM-DD}.md` |
| `clip` | External content, quote, reference material | `Clippings/{title}.md` |
| `meeting` | Meeting notes, discussion summary | `Daily/{YYYY-MM-DD}-{meeting-title}.md` |

## Step 4: Generate Content

### Evergreen Notes

Use Evergreen Note Template from SKILL.md. Set frontmatter `status:` per Knowledge Maturity Model from SKILL.md.

Path: `Notes/{title}.md`

### Daily Notes

Append to `Daily/{YYYY-MM-DD}.md` (create if missing):

```markdown
## {HH:MM} - {brief title}

{content}
```

No frontmatter needed for appended entries.

### Clippings

Path: `Clippings/{title}.md`

```markdown
---
status: draft
source: {url or "AI conversation"}
created: {YYYY-MM-DD}
---
# {title}

## Content

{clipped content}

## Notes

{user annotations if any}
```

### Meeting Notes

Path: `Daily/{YYYY-MM-DD}-{meeting-title}.md`

```markdown
---
status: draft
source: meeting
created: {YYYY-MM-DD}
---
# {meeting title}

## Attendees

-

## Key Points

{discussion points}

## Action Items

- [ ]

## Related

- [[]]
```

## Step 5: Choose Path (Default vs --deep)

### Default Path (no flags)

**Short content optimization**: If the extracted insight is brief (< 5 lines), skip confirmation and write directly (zero-confirm save). This merges the original `quick` command behavior.

For longer content:
1. Show preview (type, path, first 200 chars)
2. Ask user to confirm
3. Write file with frontmatter `status: draft`

### --deep Path (Socratic Guidance)

When `--deep` is specified:

1. Show preview of extracted insight
2. Guide the user through two prompts (conversational, not AskUserQuestion):
   - **Restate**: "Can you restate the core idea in your own words?"
   - **Relate**: "How does this connect to what you already know?"
3. Incorporate user's responses into the note content
4. Write file with frontmatter `status: refined`

The `--deep` path produces richer notes by engaging the user's own thinking. The maturity is recorded as `refined` in frontmatter to reflect this deeper processing.

## Step 6: Write File

Use the Write tool (or append for daily type) to save the file.

## Step 7: Post-Save

After writing:

1. Confirm: "Saved to: {path} (status: {draft|refined})"
2. Scan vault for potentially related existing notes (by title keywords, tags, or links)
3. If related notes found, suggest them:
   ```
   Possibly related:
   - [[Related Note A]]
   - [[Related Note B]]
   ```
4. Tip: "Run `/obos sync` to update Index.md"
