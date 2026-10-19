---
name: story
description: "写小说（story）总入口，原 8 个 story 技能已合并为本技能：新建小说项目与目录骨架、人物档案与关系/家族树、世界观（地点/体系/势力/器物）、情节弧线与时间线/伏笔/铺垫与悬念、章节与场景写作、修订与连续性审校、字数/注册表/链接/导入导出等 story CLI 维护，以及按作者文笔风格档案写作与审校。用户说写小说、开新书、小说项目、人物设定、世界观、情节大纲、写这一章、改稿、一致性检查、story CLI 时加载；不用于通用 Markdown、代码或非小说的写作任务。"
---

# Story（写小说 · 合并版总技能）

`~/.agents/skills` 里原先 8 个 story / 写小说相关技能已全部合并进本技能：`story-init` / `character-management` / `worldbuilding` / `plot-structure` / `chapter-writing` / `revision-continuity` / `story-maintenance` / `my-wiriting-style`。本文件是唯一入口，长资料在 `references/`——**每次只读需要的那一个文件，不要整篇加载**。

技能根目录 `~/.agents/skills/story/`，下文相对路径都相对它。

## 1. 开工前三件事

1. **定位小说项目根**：找 `story.md`。找到 → 后续所有路径都相对它，这是已有项目；找不到 → 用户多半要新建，走 `references/project-layout.md`。
2. **确定用哪条 CLI**（只有真要跑确定性检查时才需要，按顺序取第一个可用的）：

| 顺序 | 命令 | 何时可用 |
| --- | --- | --- |
| 1 | `story <command>` | 全局装了 story bin |
| 2 | `bun run story -- <command>` | 在 story-skills 仓库里工作 |
| 3 | `node ~/.agents/skills/story/scripts/story.js <command>` | 始终可用——本技能自带打包版 CLI |

三条都跑不了才手工维护，并按第 3 节的约定核对注册表与双向链接。

3. **写/改任何正文前先读 `references/style-profile.md`**（作者的文笔风格档案，规则与易错点清单都在里面）。

## 2. 能力路由

| 用户意图 / 信号 | 读哪个文件 |
| --- | --- |
| 开新书、新建小说项目、搭目录骨架、"start a new story" | `references/project-layout.md` |
| 建/改人物、角色关系、家族树、人物弧、人物时间线、人物档案 | `references/characters.md`；模板 `references/character-template.md`，关系类型与反向关系 `references/relationship-types.md` |
| 地点、魔法/政治/科技/宗教/经济体系、势力、器物、"build the world" | `references/worldbuilding.md` + 对应的 `references/{location,system,faction,artifact}-template.md`；各类型提问清单 `references/world-element-types.md` |
| 情节弧线、节拍、故事结构、时间线、伏笔、铺垫与兑现、悬念、节奏 | `references/plot.md`；结构模型 `references/structure-models.md`；模板 `references/{arc,promise,question}-template.md` |
| 写某一章/场景、继续故事、章节大纲、草稿转正文 | `references/chapters.md`；散文准则 `references/writing-guidelines.md`；模板 `references/{chapter,scene}-template.md` |
| 改稿、润色、连续性检查、找矛盾、审计人物状态或时间线、投稿前通读 | `references/revision.md` |
| 校验、重建注册表、查链接、数字数、导入已有手稿、导出 manuscript、`story` 命令 | `references/maintenance.md` |
| 按"我的风格"写、检查"像不像我的风格"、改文笔档案 | `references/style.md`，档案本体 `references/style-profile.md` |
| 正文有 AI 腔、要去 AI 味（不是对齐本人风格） | 外部技能 `humanizer-zh`（若可用）；文风基线仍以 `references/style-profile.md` 为准 |
| 前端/后端/脚本、非小说的普通 Markdown | **不用本技能** |

## 3. 项目硬约定（所有任务都遵守）

以下约定来自原 `story-init`，跨全部领域生效：

- **kebab-case 文件名**：所有实体文件（`sera-voss.md`、`ashen-citadel.md`）。
- **每个文件都有 YAML frontmatter** 承载结构化元数据。
- **schema 版本**：`story.md` 的 frontmatter 含 `schema-version: 2`。
- **`_index.md` 是权威注册表**：每个领域一份，改实体就要同步改它。
- **`story.md` 是顶层圣经**：所有任务先读它拿 genre / themes / POV / tense。
- **双向链接**：引用另一个实体时，两边文件都要更新。
- **实体 ID** = 去扩展名的 kebab-case 文件名（如 `sera-voss`）。
- **死亡追踪**：角色在正文中死亡时置 `status: deceased` + `died-in: chapter-{NN}`，`story continuity` 据此标记死后登场。
- **`mentions` ≠ `characters`**：在场景中出场的写进 `characters`；只是被提及、回忆、录音或闪回的写进 `mentions`。
- **场景 ID** 用 `chapter-{NN}-scene-{NN}`，文件放 `scenes/`。
- **连续性状态**在 `continuity/state.md`，未解问题与铺垫分别在 `continuity/questions/`、`continuity/promises/`。
- **markdown 优先**：直接在目标 `.md` 里创作与修改。**不要**建项目内的构建/生成/批量写入脚本（如 `build-*.js`）来产出故事文件。
- **CLI 保持外部**：唯一该跑的 JS 是 story CLI（`story` / `bun run story --` / 本技能自带的 `scripts/story.js`）。不要把它复制进用户的小说项目；万不得已留下的临时脚本收工前删掉。

## 4. 常用工作流速查

- **新建项目**：`story init "{Title}" --genre ... --pov ... --tense ...` → 再按 `references/project-layout.md` 校对骨架与注册表 → 收尾 `story validate .`
- **新增实体**（人物/地点/体系/势力/器物/弧线）：`story add <kind> "{Name}"` 或照模板手写 → 更新对应 `_index.md` → 双向链接 → `story reindex . && story links . && story validate .`
- **写一章**：outline-first——读上下文（`story.md`、`chapters/_index.md`、`plot/_index.md`、`plot/timeline.md`、`scenes/_index.md`、`continuity/*`、上一章）→ 出节拍大纲并**等用户确认** → 按风格档案写正文 → 回写章节/时间线/弧线/场景/连续性/伏笔 → 跑 `wordcount --write`、`reindex`、`links`、`validate`、`next`
- **修订/审校**：先 `story continuity .` 拿确定性结论，再做 CLI 判断不了的人工检查（知识、状态、时间、世界规则）
- **收尾自检**：`story doctor .`，用户问"现在什么状态"用 `story report .`

## 5. 文笔风格（写或改任何正文前必做）

`references/style-profile.md` 是唯一准绳；作者的 6 条规则（细则见档案）：

1. **内心不直说**——用语气、肢体动作、面部表情替代心理描写。
2. **场景切换先写环境**，再让角色进入。
3. **角色语气绑定性格**——去掉人名仍能辨认说话者。
4. **读数与数学用阿拉伯数字**，数字与单位之间空一格。
5. **规避 AI 易错点**——写作时规避，审校时逐项扫描。
6. **视角纪律**——不越 POV 边界。

审校默认**只出偏离报告、不擅自改写**，等作者决定。流程细节见 `references/style.md`。

## 6. 硬约束与常见坑

- **不要凭印象编目录结构或 frontmatter 字段**：先读 `references/project-layout.md` 与对应模板。
- **写完不注册等于没写**：任何新增/改名/删除后都要 `reindex` + `links` + `validate`。
- **正文只进 `.md`**：不要用脚本拼章节；临时脚本放项目外并删除。
- **`story` 不在 PATH 是常态**：直接用 `node ~/.agents/skills/story/scripts/story.js`，绝对路径最稳。
- **CLI 报错是维护线索，不是噪音**：修断链、缺文件、过期注册表、错字数；但**不要为了过校验而改动创作正文**；校验提示若反映用户的有意选择，报告即可。
- **改文件前先读**现有内容，避免覆盖作者手写内容。
- **闪回/回忆里的死者**写进 `mentions`，否则 `story continuity` 会误报。

## 7. 不适用

- 非小说的通用 Markdown 编辑、代码任务、文档写作：走对应技能或原生工具。
- 只问写作概念或要口头建议、不需要落地文件：直接回答。
- 网页抓取、题材资料检索：用 `web_search` / `web_fetch`，本技能只负责落到小说项目里。

## 8. 验收

- **声称项目健康必须跑过 CLI 并贴出输出**：`story validate .`（或 node 绝对路径版）。有成功输出才算成功，不要用"应该没问题"结案。
- 字数：`story wordcount . --write`；连续性：`story continuity .`；链接：`story links .`。
- 正文交付：对照风格档案第五节检查清单逐项过，并说明按哪几条规则执行。
- **本技能自检**：
  - `ls ~/.agents/skills | grep -E '^(story-init|chapter-writing|character-management|plot-structure|revision-continuity|story-maintenance|worldbuilding|my-wiriting-style)$'` 应无输出；
  - `~/.agents/skills/story/SKILL.md` 首行是 `---`，`name: story`，description ≤ 500 字符；
  - `node ~/.agents/skills/story/scripts/story.js --help` 能打印命令列表。

## 9. 来源与许可

- 上游：danjdewhurst/story-skills v0.3.1（MIT），仓库检出在 `/Users/lingyun/mywork/story-skills`；7 个上游技能的正文按原文保留在 `references/`，字段名与目录结构未改写。
- 本地技能 `my-wiriting-style`（作者文笔风格档案）一并并入：`references/style.md` + `references/style-profile.md`。
- 合并前的 8 个技能目录已备份到 `~/.agents/skills-backup/story-merge-*`（目录与 tar.gz 各一份）。仓库本身未改动，仍可对照上游。
