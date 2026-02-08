# obos — Obsidian Best Practices

AI-powered Obsidian vault management skill for [Claude Code](https://docs.anthropic.com/en/docs/claude-code).

Manage daily notes, refine knowledge, discover connections, and write from your vault — all through `/obos` commands.

## Quick Start

### Install

```bash
# Clone to your projects directory
git clone https://github.com/HamsteRider-m/obsidian-best-pract.git

# Deploy skill files to Claude Code
cp -r skill/SKILL.md ~/.claude/skills/obos/SKILL.md
cp -r skill/commands/ ~/.claude/skills/obos/commands/
```

### First Run

```
/obos init
```

This initializes your vault structure and walks you through onboarding.

## Commands

| Command | Description |
|---------|-------------|
| `/obos init` | Initialize vault structure + interactive onboarding |
| `/obos daily [date]` | Create/open daily note with carry-forward |
| `/obos save [type]` | Save conversation insight (`--deep` for guided) |
| `/obos weekly [range]` | Generate weekly review (`--reflect` for reflection) |
| `/obos sync` | Sync index + health report (`--status` for read-only) |
| `/obos refine [note]` | Socratic note refinement (draft → refined) |
| `/obos ask "question"` | Query your knowledge base |
| `/obos link [note]` | Smart link suggestions (`--all` for vault-wide) |
| `/obos draft "topic"` | Writing assist from notes (`--assist` for AI prose) |

Commands are grouped by purpose:

```
记录：daily, save
加工：refine, link
产出：ask, draft
维护：sync, weekly
设置：init
```

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

| Status | Meaning | Set by |
|--------|---------|--------|
| `draft` | Captured but not deeply processed | `/obos save`, quick capture |
| `refined` | Processed through guided reflection | `/obos save --deep`, `/obos refine` |

## Design Principles

1. **Fast by default, depth optional** — every command takes the quickest path; deep features are opt-in (`--deep`, `--reflect`, `--assist`)
2. **AI asks questions, not gives answers** — Socratic guidance as optional enhancement, never forced
3. **Simplicity first** — user-facing simplicity, complexity stays behind the scenes
4. **Capture ≠ Learn** — the system provides processing paths but never forces users through them

## Typical Workflows

**Morning routine**:
```
/obos sync          # update index, check vault health
/obos daily         # create today's note, carry forward yesterday's tasks
```

**After a learning session**:
```
/obos save          # quick capture (draft)
/obos save --deep   # guided capture with reflection (refined)
```

**Knowledge processing**:
```
/obos refine [[My Note]]   # Socratic refinement of a draft note
/obos link [[My Note]]     # discover connections to other notes
/obos link --all            # find and connect orphan notes
```

**Writing from your vault**:
```
/obos ask "What do I know about X?"    # query your knowledge base
/obos draft "Topic"                     # generate outline from notes
/obos draft "Topic" --assist            # AI-assisted prose generation
```

**Weekly review**:
```
/obos weekly             # auto-generate review with stats + trends
/obos weekly --reflect   # guided reflection with Socratic questions
```

## Project Structure

```
obsidian-best-pract/
├── skill/
│   ├── SKILL.md              # Router + shared conventions (~90 lines)
│   └── commands/             # Self-contained command implementations
│       ├── init.md
│       ├── daily.md
│       ├── save.md
│       ├── weekly.md
│       ├── sync.md
│       ├── refine.md
│       ├── ask.md
│       ├── link.md
│       └── draft.md
├── tests/
│   ├── run.sh                # Test runner
│   └── test_*.sh             # Per-command test suites
└── docs/design/              # Design documents
```

## Testing

```bash
bash tests/run.sh          # run all tests
bash tests/run.sh link     # run a specific command's tests
```

Tests validate command file structure, required sections, template consistency, and design doc compliance. Current status: **88 passed, 0 failed, 0 skipped**.

## License

MIT
