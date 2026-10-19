---
name: codegraph
description: HIGHEST-PRIORITY for 代码搜索与项目分析 — 优先用 codegraph（本地 SQLite 知识图谱 CLI/MCP），先于 grep/Glob/Read/Explore/Task。适用于查找符号/函数/类/组件、了解项目结构、追踪调用链、"谁调用了 X"、改动影响范围、受影响测试。自动触发于：搜索代码、查找代码、找函数/符号/组件、分析项目、分析代码、理解代码库、阅读项目、探索项目、调用链、影响范围、哪个测试受影响等场景。codegraph 不可用（未安装/未初始化）时先安装/初始化，仍不可用或确实无法处理（字面量字符串搜索、单个已知文件）才退回 grep/Explore/Read。
---

# codegraph

阅读、分析项目、查找代码时，**优先用 codegraph**，不要先用 Task/Explore 或大面积 grep/Glob/Read 爬仓库。

**强制优先级（代码搜索与项目分析场景）：**

1. 首选 codegraph：`query` → `callers` / `callees` / `impact` / `affected` / `files`
2. codegraph 未安装 → 先安装；未初始化 → `codegraph init`；仍不可用，才允许退回 grep/Explore/Read
3. 能跳过 codegraph 的情况仅限：字面量字符串搜索（非符号名）、单个已知文件读写
4. 若本次无法使用 codegraph，向用户说明原因再降级

codegraph 在本地用 tree-sitter 建 SQLite 知识图谱（符号、调用边、依赖），给出「在哪定义、谁调用谁、改动波及面」，比盲搜更快更准。数据不出本机。

## 何时必须优先 codegraph

| 任务 | 优先命令 |
| --- | --- |
| 了解项目结构 / 有哪些文件 | `codegraph files` + `codegraph status` |
| 找函数/类/组件/符号 | `codegraph query "<name>"` |
| 谁调用了 X | `codegraph callers "<symbol>"` |
| X 内部调用了什么 | `codegraph callees "<symbol>"` |
| 改 X 的影响范围 | `codegraph impact "<symbol>"` |
| 改动影响哪些测试 | `codegraph affected <files...>` |

单文件且路径已知的读写、以及「搜一段字面量字符串」→ 直接 Read / Grep，不必强行走 codegraph。

## 工作流

### 1. 会话内先做一次就绪检查

在项目根目录执行：

```sh
which codegraph
codegraph status
```

- 未安装 → 安装后继续（见下方 Install）
- 未初始化 / 无 `.codegraph/` → `codegraph init`
- 索引过期 → `codegraph sync`；锁死 → `codegraph unlock` 后重试
- 需要全量重建 → `codegraph index -f`

### 2. 查找与分析顺序

1. `codegraph query "<partial>"` — 用户给的名字常不完整或记错，先解析到真实符号
2. 再用 `callers` / `callees` / `impact`（必须用 query 得到的真实符号名）
3. query 无结果 → 再 `Grep` 字面量，找到外围符号后重新 `query`
4. 需要读实现时，再 `Read` **query/关系命令返回的具体文件与行号**，不要先漫读目录

### 3. MCP（若已配置）

若 Cursor 已启用 `codegraph` MCP（`codegraph serve --mcp`），优先用其工具完成同样任务；未配置时用 CLI 即可，效果等价。

可选安装到 Cursor（会改 `~/.cursor/mcp.json`，仅在用户同意时执行）：

```sh
codegraph install -t cursor -l global -y
```

## Install（仅 `which codegraph` 为空时）

macOS / Linux（shell 安装器，自带 node）：

```sh
curl -fsSL https://raw.githubusercontent.com/colbymchenry/codegraph/main/install.sh | sh
```

Windows（PowerShell）：

```powershell
irm https://raw.githubusercontent.com/colbymchenry/codegraph/main/install.ps1 | iex
```

npm（任意系统，若用户偏好 npm）：

```sh
npm i -g @colbymchenry/codegraph
```

二进制通常在 `~/.local/bin/codegraph`（shell 安装器），确认 `~/.local/bin` 在 PATH 上。验证：`codegraph --version`。装好后告知用户安装完成（纯本地、无遥测）。

## 已知局限

- JSX 使用（`<Foo/>`）可能不记为 call edge；`callers` 返回空时**先别认定工具漏了**，用 `grep -rn "<符号>" src` 交叉验证：若 grep 找到的是 JSX 或 re-export 行，说明"无调用者"属实；若 grep 找到真实调用点而图谱漏了，向用户说明该局限并改用 grep
- 只索引符号，不替代任意字符串搜索
- 不要提交 `.codegraph/`
- 索引锁死 → `codegraph unlock` 后重试；需全量重建 → `codegraph index -f`

## 反模式

- ❌ 分析项目时先开 Explore/Task 全库爬文件
- ❌ 已知要找符号却先 `rg` 全库
- ❌ 对单个已知文件也先跑一遍 codegraph（直接 Read）
- ❌ 用户给的名字未 `query` 就直接 `callers`/`impact`

## Quick reference

```sh
codegraph status
codegraph init [path]
codegraph sync
codegraph files
codegraph query "<sym>"
codegraph callers "<sym>"
codegraph callees "<sym>"
codegraph impact "<sym>"
codegraph affected <files...>
codegraph unlock [path]
```
