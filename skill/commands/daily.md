# /obos daily [date]

Create or open a daily note with carry-forward and cognitive prompts.

## Usage

```
/obos daily            # today
/obos daily yesterday  # yesterday's note
/obos daily 2026-01-15 # specific date
```

## Behavior

### Step 1: Vault Path Discovery

Determine vault path using Vault Path Discovery from SKILL.md.

### Step 2: Parse Date Parameter

- No argument: today (`YYYY-MM-DD`)
- `yesterday`: resolve to yesterday's date
- `YYYY-MM-DD`: use as-is (validate format)

### Step 3: Check if Daily Note Exists

Path: `Daily/{date}.md`

- If exists: read and go to Step 5
- If not exists: go to Step 4

### Step 4: Create New Note

#### 4a. Carry Forward

Scan yesterday's daily note (`Daily/{yesterday}.md`) for unchecked items (`- [ ]`).
If found, migrate them into today's Plan section as carry-forward items.

Example: if yesterday has `- [ ] Review PR`, today's Plan gets:
```
- [ ] Review PR  (carried from {yesterday})
```

If yesterday's note does not exist or has no `- [ ]` items, skip silently.

#### 4b. Apply Template

```markdown
# {{date}}

## Plan
> 今天最重要的一件事是什么？
{{carry-forward items here, if any}}
-

## Log
-

## Thoughts
> 今天学到了什么？改变了什么看法？

## Meetings
```

Write to `Daily/{date}.md`.

### Step 5: Output

Show:
- **Path**: `Daily/{date}.md`
- **Status**: Created (with N carry-forward items) / Already exists
- Content preview (first 500 chars if existing note)

## Notes

- Carry-forward only triggers on note creation, not when opening existing notes
- The blockquote prompts are cognitive nudges; they stay in the file but don't require answers
- If the date parameter is invalid, inform the user and default to today
