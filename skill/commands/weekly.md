# /obos weekly

Generate weekly review with quantitative stats from daily notes.

## Usage

```
/obos weekly              # current week
/obos weekly last         # last week
/obos weekly 2026-W05     # specific week
/obos weekly --reflect    # guided reflection mode
/obos weekly --monthly    # monthly review (Phase 3)
```

## Parameters

| Param | Description |
|-------|-------------|
| _(none)_ | Current week (Mon~Sun) |
| `last` | Previous week range |
| `YYYY-WNN` | Specific ISO week |
| `--reflect` | Socratic reflection guidance |
| `--monthly` | Monthly aggregation (Phase 3, not yet implemented) |

## Step 1: Vault Path Discovery

Use shared **Vault Path Discovery** logic from SKILL.md:
1. Current working directory (has `.obsidian/` or vault CLAUDE.md)
2. Fallback: `/Users/hansonmei/OneDrive/obsidian-vault/`
3. If neither exists, ask user with AskUserQuestion

## Step 2: Determine Week Range

- No argument → current week (Monday to Sunday)
- `last` → previous week
- `YYYY-WNN` → parse ISO week to date range
- Format all dates as `YYYY-MM-DD`

## Step 3: Gather Daily Notes

Read all daily notes in the determined range:
- Path pattern: `Daily/{YYYY-MM-DD}.md` for each day in range
- Track which days have notes and which are missing

## Step 4: Extract & Analyze

From each daily note extract:
- Completed tasks (`- [x]`)
- Incomplete tasks (`- [ ]`)
- Key thoughts and insights
- Recurring themes across days

Compute quantitative stats:
- Daily note count (how many of 7 days have notes)
- Tasks completed count
- Tasks carried forward (incomplete) count

## Step 5: Generate Report (Default Mode)

Auto-generate the weekly review at `Daily/{YYYY}-W{WW}.md`.

Use this template:

```markdown
# Week {WW} Review ({start-date} ~ {end-date})

## Highlights
- {key accomplishment}

## Insights
{Notable thoughts worth preserving}

## Patterns
{Recurring themes or behaviors noticed}

## Stats
- Daily notes: {count}/7
- Tasks completed: {count}
- Tasks carried forward: {count}

## Carry Forward
- [ ] {unfinished item}

## Daily Summary
| Day | Key Activity |
|-----|--------------|
| Mon | ... |
| Tue | ... |
| Wed | ... |
| Thu | ... |
| Fri | ... |
| Sat | ... |
| Sun | ... |
```

## Step 6: Reflection Mode (`--reflect`)

When `--reflect` is provided, switch to Socratic guidance:

1. **Show data overview**: Present the week's stats and key activities summary
2. **Ask 3 guiding questions** via conversation turns (not AskUserQuestion):
   - "What was your biggest win this week?"
   - "What surprised you or challenged your assumptions?"
   - "What would you do differently next week?"
3. **Wait for user responses** in each conversation turn
4. **Organize final report** incorporating user's reflections into the template above

Reflection guidance is conversational — use natural follow-up turns, not structured tool prompts.

## Step 7: Suggest Evergreen Notes

If any insight is worth preserving long-term:
- Suggest: "Consider saving as Evergreen: {title}"

## Success Message

- Weekly review created: `Daily/{year}-W{week}.md`
- Days covered: {count}/7
- Stats: {completed} tasks done, {carried} carried forward
- Tip: Review and edit, then run `/obos sync`
