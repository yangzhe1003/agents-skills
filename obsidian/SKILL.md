---
name: obsidian
description: "Obsidian 知识库与可视化总入口（原 10 个 obsidian 技能已合并为本技能）：写/改笔记与 Obsidian Markdown（wikilink、embed、callout、properties、标签）、.base 视图与公式、.canvas 白板与思维导图、obsidian CLI 读写库/搜索/插件调试、网页正文提取（defuddle）、Knap 模板批量生成笔记、Mermaid 图、Excalidraw 图、工具链安装排障。用户提到 Obsidian、vault、知识库、笔记、白板、画图、流程图、思维导图、网页转 Markdown 时加载；不用于非 Obsidian 的普通 Markdown、写作与代码任务。"
---

# Obsidian（合并版总技能）

`~/.agents/skills` 里原先 10 个 obsidian 相关技能已全部合并进本技能：`obsidian` / `obsidian-markdown` / `obsidian-bases` / `json-canvas` / `obsidian-cli` / `defuddle` / `knap` / `mermaid-visualizer` / `excalidraw-diagram` / `setup`。本文件是唯一入口，长资料在 `references/`——**每次只读需要的那一个文件，不要整篇加载**。

技能根目录 `~/.agents/skills/obsidian/`，下文相对路径都相对它。

## 1. 开工前两件事

1. **确认 vault 路径**：会话里已知库目录就直接用；不确定先跑 `obsidian vaults`（需 CLI 可用）或问用户。写文件前先 `ls` 目标目录。
2. **确认工具链**——只有该任务真的要 shell 出去时才检查：

| 检查 | 用途 | 缺了会怎样 |
| --- | --- | --- |
| `command -v obsidian && obsidian version` | 读写 vault、搜索、日常笔记、插件调试 | CLI 类任务全部不可用；需 Obsidian 桌面端在运行且已在 app 内注册 CLI |
| `command -v defuddle` | 网页 → 干净 Markdown | 网页转笔记不可用 |
| `command -v knap` | 模板批量渲染 | 模板批量生成不可用 |

缺任何一个：读 `references/setup.md`，**先取得用户明确同意再安装**（发现缺失不等于获得安装许可；`npx` 会下载包，同样要问）。纯生成任务（写 Markdown、画 canvas / Mermaid / Excalidraw）不依赖这三个 CLI，直接做。

## 2. 能力路由

| 用户意图 / 信号 | 读哪个文件 |
| --- | --- |
| 写或改笔记、wikilink、embed、callout、properties/frontmatter、标签、LaTeX、脚注 | `references/markdown.md`；下一节速查已覆盖常见写法，够用就不必读 |
| `.base` 文件、表格/卡片/列表/地图视图、筛选、公式、summary | `references/bases.md`（函数全表在其附录） |
| `.canvas` 白板、思维导图、流程图、把文章/大纲变成画布 | `references/canvas.md`，模板在 `assets/*.canvas` |
| 读写 vault、搜索笔记、任务与属性、daily note、插件与主题调试、截图、DOM/console | `references/cli.md` |
| 网页 → 干净 Markdown（省 token） | `references/defuddle.md`；URL 本身以 `.md` 结尾时直接用 web_fetch |
| JSON/CSV + 模板批量生成笔记 | `references/knap.md` |
| 文本 → Mermaid 流程图/架构图/思维导图 | `references/mermaid.md`（语法避坑在其附录） |
| 文本 → Excalidraw 图（Obsidian `.md` / 标准 `.excalidraw` / 动画三种模式） | `references/excalidraw.md` |
| CLI 缺失、装坏、要注册或排障 | `references/setup.md` |

## 3. Obsidian Markdown 速查

```markdown
[[Note]]  [[Note|显示文本]]  [[Note#标题]]  [[Note#^block-id]]  [[#本笔记的标题]]
块引用 ID：在段落末尾写 ^block-id；引用块或列表把 ID 单独放一行

![[Note]]  ![[Note#标题]]  ![[image.png]]  ![[image.png|300]]  ![[doc.pdf#page=3]]

> [!note] 基本 callout；> [!warning] 自定义标题；> [!faq]- 默认折叠（+ 号展开）
常用类型：note tip warning info example quote bug danger success failure question abstract todo

---
title: My Note
tags: [project, active]
aliases: [Alternative Name]
cssclasses: [custom-class]
---

#tag  #nested/tag（可含字母、数字、下划线、连字符与 /，数字不能开头）
%% 注释，阅读视图不显示 %%   ==高亮==   $行内公式$   $$块级公式$$
脚注写法 [^1] 与 ^[行内脚注]；图用三个反引号加 mermaid 的代码块；Mermaid 节点连笔记加 class NodeName internal-link;
```

选链接方式：库内笔记用 `[[wikilink]]`（重命名会自动跟随），外部 URL 用 `[text](url)`。更全的 callout 类型与别名、embed 类型、properties 类型见 `references/markdown.md` 的附录。

## 4. 常用工作流

**读写 vault（先确认 Obsidian 正在运行）**

```bash
obsidian read file="My Note"
obsidian create name="New Note" content="# Hello" template="Template" silent
obsidian append file="My Note" content="New line"
obsidian search query="关键词" limit=10
obsidian daily:append content="- [ ] 新任务"
obsidian property:set name="status" value="done" file="My Note"
obsidian vault="My Vault" search query="test"   # 指定库；默认最近聚焦的库
```

参数写成 `name=value`（值含空格要加引号），开关是裸 flag（如 `silent overwrite`）；`file=` 按 wikilink 名称解析，`path=` 是库内精确路径；多行内容用 `\n`、`\t`。

**网页 → 笔记**：`defuddle parse <url> --md --json | knap render template.md --data - -o note.md`，再把结果落到 vault。
**插件/主题调试循环**：`plugin:reload` → `dev:errors` → `dev:screenshot` / `dev:dom` → `dev:console level=error`。
**选哪种图**：流程与结构关系选 Mermaid；要手绘风格、要拖进 excalidraw.com 或要生成动画选 Excalidraw；要在库里长期拖拽编辑的白板选 `.canvas`。

## 5. 硬约束与常见坑

- **不要凭印象手写 Obsidian 专有语法**（callout、properties、base 公式、canvas / excalidraw JSON），不确定就查对应 `references/` 文件。
- `.base`：含 `: { } [ ] , & * # ? | - < > = ! % @` 和反引号的字符串必须加引号；公式里有双引号就用单引号包整条（`'if(done, "Yes", "No")'`）；用 `formula.X` 前必须在 `formulas` 里定义 `X`。
- `.canvas`：每个 node/edge 的 `id` 必须是唯一的 16 位 hex；edge 的 `fromNode`/`toNode` 必须指向真实节点；group 节点放数组最前（先渲染=在最底层）；写完 parse 一遍 JSON 校验。
- **Mermaid**：节点文本里不要出现「数字 + 点 + 空格」（`[1. Perception]` 会报 Unsupported markdown: list）；subgraph 要写成 `id["显示名"]` 且连线引用 `id`；文本中的引号改用 `『』`、括号改用 `「」`。
- **Excalidraw**：三种输出模式由触发词决定；默认 Obsidian 模式输出 `.md`，frontmatter 必须是 `excalidraw-plugin: parsed` 加 `tags: [excalidraw]`，JSON 包在 `%%` 之间，模板结构不要改动；保存位置未知时先问用户。
- **defuddle**：始终带 `--md`；`.md` 结尾的 URL 直接 web_fetch。
- **knap**：`knap validate` 只查语法与过滤器名，不查变量是否存在；模板源与数据源各只能选一个，stdin 只能给其中一边。
- **CLI 判定**：`command -v obsidian` 失败不等于没装——agent shell 的 PATH 常比用户终端窄，先探测 `/usr/local/bin/obsidian`、`~/.local/bin/obsidian-cli`、`/Applications/Obsidian.app/Contents/MacOS/obsidian-cli`，命中就用绝对路径。永远不要装 npm 上那个无关的 `obsidian-cli` 包。
- 改笔记或画布前先读现有文件再动手，避免覆盖用户内容。

## 6. 不适用

- 非 Obsidian 的普通 Markdown 编辑、写作、代码任务：走对应技能或原生工具。
- 只是通用网页抓取（不喂给 vault / 模板）：按需用 web_fetch 即可。
- 只问 Obsidian 功能或概念、不需要产出文件：直接回答。

## 7. 验收

- 产出的文件要读回确认：Markdown 语法与 frontmatter 正确；`.canvas` 能 parse 且 ID 唯一、引用有效；`.base` 是合法 YAML 且引用到的公式都已定义。
- 跑过 CLI 才能声称 CLI 可用；有成功输出才算成功，不要用「应该可以」结案。
- 本技能自检：`ls ~/.agents/skills | grep -c obsidian` 输出应为 1；SKILL.md 首行是 `---`，`name: obsidian`，description ≤ 500 字符。

## 8. 来源与许可

- 由 zcode 官方插件 `obsidian@0.1.2` 的 9 个子技能加本地总入口合并而成；上游是 kepano/obsidian-skills（markdown、bases、canvas、cli、defuddle、knap）与 axtonliu/axton-obsidian-visual-skills（mermaid、excalidraw、canvas 布局算法与模板），均为 MIT，见同目录 `LICENSE`。
- 上游插件缓存（比对或还原用）：`~/.zcode/cli/plugins/cache/zcode-plugins-official/obsidian/0.1.2/skills`。
- 合并前的 10 个技能目录已备份到 `~/.agents/skills-backup/obsidian-merge-*`（目录与 tar.gz 各一份）。
