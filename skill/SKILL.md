---
name: obos
description: "Obsidian vault management. Use when user runs /obos commands to manage vault structure, save insights, tidy files, or sync index."
metadata:
  short-description: Obsidian vault management
---

# Obsidian Best Practices (obos)

有主见的 Obsidian vault 管理系统。核心循环：收集 → 整理 → 连接 → 回顾。

## Commands

| Command | Description |
|---------|-------------|
| `/obos save ["内容"]` | 快速收集想法到 Inbox（核心命令） |
| `/obos tidy` | 整理 Inbox + 散落文件到正确目录 |
| `/obos sync` | 更新索引 + 健康报告 + 链接建议 |
| `/obos review` | Vault 状态回顾 + 下一步建议 |
| `/obos init` | 初始化 vault 结构 |
| `/obos vault` | 管理多个 vault 注册 |
| `/obos refine [note]` | 深度加工笔记（进阶） |
| `/obos ask "question"` | 查询知识库（进阶） |
| `/obos draft "topic"` | 基于笔记起草文章（进阶） |

No argument → show grouped command list:
```
核心：save, tidy, sync, review
设置：init, vault
进阶：refine, ask, draft
```

## Multi-Vault 配置

配置文件：`~/.proma/agent-workspaces/obsidian/obos-config.json`

```json
{
  "vaults": {
    "personal": { "path": "D:/obsidian/personal", "default": true },
    "work": { "path": "C:/Users/.../work-vault" }
  },
  "lastUsedVault": "personal"
}
```

## Vault Path Discovery

所有命令共享此逻辑（按优先级）：

1. 命令参数 `--to <alias>` 指定的 vault
2. obos-config.json 中的 default vault
3. 当前工作目录（如果包含 `.obsidian/` 或 vault CLAUDE.md）
4. 如果以上都不存在，用 AskUserQuestion 引导用户注册 vault

## Vault Structure

```
Vault/
├── CLAUDE.md          # AI context file
├── Index.md           # AI-readable index (auto-generated)
├── Inbox/             # 收集入口（save 写入此处）
├── Notes/             # Evergreen notes
├── Clippings/         # Web clippings
├── References/        # Source materials
├── Attachments/       # Images and files
├── Categories/        # MOC index pages
└── Templates/         # Note templates
```

## Knowledge Maturity Model

Frontmatter `status` 字段：
- `inbox` — 刚收集，未整理
- `draft` — 已分类，未深度加工
- `refined` — 经过 `/obos refine` 深度加工

## Evergreen Note Template

```markdown
---
status: {{inbox|draft|refined}}
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
