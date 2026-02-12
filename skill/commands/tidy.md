# /obos tidy

整理 Inbox 和散落文件，AI 分类后批量移动到正确目录。熵减的核心命令。

## Usage

```
/obos tidy                  # 整理默认 vault
/obos tidy --to work        # 整理指定 vault
/obos tidy --dry-run        # 只预览不执行
```

## Step 1: 确定目标 Vault

使用 SKILL.md 中的 Vault Path Discovery 逻辑。

## Step 2: 扫描待整理文件

扫描以下位置的 .md 文件：

1. `Inbox/` 目录下所有文件
2. Vault 根目录下散落的 .md 文件（排除 CLAUDE.md、Index.md、README.md）

排除项（不参与整理）：
- 已在标准目录中的文件（Notes/、Clippings/、References/、Categories/、Templates/）
- Attachments/ 下的文件
- `.obsidian/` 下的文件
- frontmatter 中 `status` 不是 `inbox` 且已在标准目录中的文件

如果没有待整理文件，输出提示并结束：
```
Inbox 为空，没有需要整理的文件。
运行 /obos save 收集新想法。
```

## Step 3: AI 分类

逐个读取文件内容，分析后判断目标目录：

| 目标目录 | 判断信号 |
|----------|----------|
| `Notes/` | 个人观点、独立概念、原创想法、方法论总结 |
| `Clippings/` | 外部内容摘录、网页剪藏、他人观点引用 |
| `References/` | 书摘、论文笔记、课程笔记、系统性参考资料 |
| `Categories/` | 主题索引、多篇笔记的汇总页 |
| `（保留 Inbox）` | 内容太短或无法判断，标记为"待定" |

分类依据优先级：
1. frontmatter 中的 `keywords` 或 `source` 字段
2. 文件内容语义分析
3. 文件名模式（如含日期、含 "clip-" 前缀等）

## Step 4: 生成整理方案

输出方案表：

```
整理方案（共 N 个文件）：

| # | 文件 | 当前位置 | → 目标 | 理由 |
|---|------|----------|--------|------|
| 1 | AI工具对比.md | Inbox/ | Clippings/ | 外部信息汇总 |
| 2 | 函数式编程思考.md | Inbox/ | Notes/ | 个人观点 |
| 3 | 散落笔记.md | vault根目录 | Notes/ | 独立概念 |
| 4 | 碎片想法.md | Inbox/ | （保留） | 内容过短，建议补充 |
```

**`--dry-run` 模式**：输出方案表后结束，不执行任何操作。

## Step 5: 用户确认

用 AskUserQuestion 询问：
- "全部执行" — 按方案批量移动
- "逐条确认" — 逐个文件询问是否移动
- "取消" — 不做任何操作

## Step 6: 执行移动

对每个确认的文件：

1. 移动文件到目标目录
2. 更新 frontmatter：
   - `status`: `inbox` → `draft`
   - 添加 `moved_from: {原路径}`
   - 添加 `tidied: {YYYY-MM-DD}`
3. 扫描 vault 中所有 .md 文件，更新 `[[wikilink]]` 引用（如果文件名未变则无需更新）

## Step 7: 输出结果 + 自动触发 sync

```
✅ 整理完成

已移动：
  Inbox/AI工具对比.md → Clippings/AI工具对比.md
  Inbox/函数式编程思考.md → Notes/函数式编程思考.md
  散落笔记.md → Notes/散落笔记.md

保留在 Inbox：
  碎片想法.md（建议补充后再整理）

正在更新索引...
```

整理完成后自动执行 sync 逻辑（更新 Index.md + 健康报告），无需用户手动运行。
