# /obos daily

Create or open today's daily note.

## Usage

```
/obos daily
```

## Behavior

### Step 1: Identify Vault Path

Check these locations in order:
1. Current working directory (if has CLAUDE.md)
2. `/Users/hansonmei/OneDrive/obsidian-vault/`
3. Ask user

### Step 2: Determine Today's Date

Format: `YYYY-MM-DD` (e.g., 2026-01-27)

### Step 3: Check if Daily Note Exists

Path: `Daily/{YYYY-MM-DD}.md`

### Step 4: Create or Read

#### If file doesn't exist, create from template:

```markdown
# {YYYY-MM-DD}

## Plan

-

## Log

-

## Thoughts

```

#### If file exists, read and display summary

### Step 5: Output

Show:
- Path: `Daily/{date}.md`
- Status: Created / Already exists
- Content preview (first 500 chars if exists)

## Success Message

- Daily note ready: `Daily/{date}.md`
- Tip: Use `/obos save daily` to append insights
