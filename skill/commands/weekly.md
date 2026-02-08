# /obos weekly

Generate weekly review from daily notes.

## Usage

```
/obos weekly
```

## Behavior

### Step 1: Identify Vault Path

Check these locations in order:
1. Current working directory (if has CLAUDE.md)
2. `/Users/hansonmei/OneDrive/obsidian-vault/`
3. Ask user

### Step 2: Determine Week Range

Calculate current week (Monday to Sunday).
Format dates as `YYYY-MM-DD`.

### Step 3: Gather Daily Notes

Read all daily notes in range:
- `Daily/{date}.md` for each day in the week

### Step 4: Analyze Content

Extract from each daily note:
- Completed tasks
- Key thoughts
- Recurring themes
- Unfinished items

### Step 5: Generate Weekly Review

Path: `Daily/{YYYY}-W{WW}.md` (e.g., `2026-W05.md`)

```markdown
# Week {WW} Review ({start-date} ~ {end-date})

## Highlights

- {key accomplishment 1}
- {key accomplishment 2}

## Insights

{Notable thoughts worth preserving}

## Patterns

{Recurring themes or behaviors noticed}

## Carry Forward

- [ ] {unfinished item 1}
- [ ] {unfinished item 2}

## Daily Summary

| Day | Key Activity |
|-----|--------------|
| Mon | ... |
| Tue | ... |
| ... | ... |
```

### Step 6: Suggest Evergreen Notes

If any insight is worth preserving long-term:
- Suggest: "Consider saving as Evergreen: {title}"

## Success Message

- Weekly review created: `Daily/{year}-W{week}.md`
- Days covered: {count}/7
- Tip: Review and edit, then run `/obos sync`
