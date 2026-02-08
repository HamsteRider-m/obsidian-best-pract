# /obos save

Save conversation insights to the vault.

## Usage

```
/obos save [type]
```

Types:
- `evergreen` - Create/update an Evergreen Note in `Notes/`
- `daily` - Append to today's Daily Note
- `clip` - Save as a Clipping

If type is omitted, AI auto-detects based on content.

## Behavior

### Step 1: Identify Vault Path

Check these locations in order:
1. Current working directory (if has CLAUDE.md)
2. `/Users/hansonmei/OneDrive/obsidian-vault/`
3. Ask user

### Step 2: Extract Insight from Conversation

Analyze the current conversation to identify:
- Key insight or conclusion
- Supporting context
- Related topics/links

### Step 3: Determine Type (if not specified)

Auto-detect rules:
- **evergreen**: Standalone concept, reusable idea, principle
- **daily**: Task update, fleeting thought, log entry
- **clip**: External content, quote, reference material

### Step 4: Generate Content

#### For Evergreen Notes

Path: `Notes/{title}.md`

```markdown
# {Title}

{One-paragraph summary}

## Details

{Expanded content}

## Source

- Conversation: {date}
- Context: {brief context}

## Related

- [[related note 1]]
- [[related note 2]]
```

#### For Daily Notes

Path: `Daily/{YYYY-MM-DD}.md`

Append to existing or create new:

```markdown
## {HH:MM} - {brief title}

{content}
```

#### For Clippings

Path: `Clippings/{title}.md`

```markdown
# {Title}

Source: {url or "AI conversation"}
Date: {YYYY-MM-DD}

## Content

{clipped content}

## Notes

{user's annotations}
```

### Step 5: Confirm with User

Before writing, show:
- Type: {type}
- Path: {file path}
- Preview: {first 200 chars}

Ask: "Save this? (y/n/edit)"

### Step 6: Write File

Use Write tool to create/append the file.

## Success Message

- Saved to: {path}
- Type: {type}
- Tip: Run `/obos sync` to update Index.md
