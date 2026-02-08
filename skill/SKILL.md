---
name: obos
description: "Obsidian vault management. Use when user runs /obos commands to manage vault structure, daily notes, weekly reviews, save insights, or sync index files."
metadata:
  short-description: Obsidian vault management
---

# Obsidian Best Practices (obos)

Manage an Obsidian vault with AI-friendly structure.

## Commands

| Command | Description |
|---------|-------------|
| `/obos init` | Initialize vault structure + interactive onboarding |
| `/obos daily [date]` | Create/open daily note with carry-forward |
| `/obos save [type]` | Save conversation insight (fast default, `--deep` for guided) |
| `/obos weekly [range]` | Generate weekly review (`--reflect` for guided reflection) |
| `/obos sync` | Sync index files + health report (`--status` for read-only) |
| `/obos refine [note]` | Socratic note refinement (draft → refined) |
| `/obos ask "question"` | Query your knowledge base |
| `/obos link [note]` | Smart link suggestions |
| `/obos draft "topic"` | Writing assist from notes |

No argument → show grouped command list:
```
记录：daily, save
加工：refine, link
产出：ask, draft
维护：sync, weekly
设置：init
```

## Vault Path Discovery

All commands share this logic:
1. Current working directory — if it contains `CLAUDE.md` with vault-related content or has `.obsidian/`
2. Fallback: `/Users/hansonmei/OneDrive/obsidian-vault/`
3. If neither exists, ask user with AskUserQuestion

## Vault Structure

```
Vault/
├── CLAUDE.md          # AI context file
├── Index.md           # AI-readable index (auto-generated)
├── Daily/             # Daily notes + weekly reviews
├── Notes/             # Evergreen notes
├── Clippings/         # Web clippings
├── References/        # Source materials
├── Attachments/       # Images and files
├── Categories/        # MOC index pages
└── Templates/         # Note templates
```

## Knowledge Maturity Model

Two-level system tracked in frontmatter `status` field:
- `draft` — captured but not deeply processed
- `refined` — processed through guided reflection or `/obos refine`

## Evergreen Note Template

```markdown
---
status: {{draft|refined}}
source: {{attribution}}
created: {{YYYY-MM-DD}}
---
# {{title}}

## Core Idea
One sentence in your own words.

## My Understanding
Why it matters. What you agree/disagree with.

## Open Questions
What new questions does this raise?

## Related
- [[]]
```

## Command Routing

Parse the first argument after `/obos` and load the matching `commands/{command}.md` file. If no argument, show the grouped command list above and ask what the user wants to do.
