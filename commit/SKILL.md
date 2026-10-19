---
name: commit
description: |
  按 Conventional Commits 规范生成中文 git 提交信息并执行提交。适用于：
  - 用户说「提交一下」「写个 commit」「生成提交信息」「git commit」等
  - 提交前需要先分析 git status / git diff，再生成规范的提交信息
  - 需要把改动归类为 feat / fix / docs / refactor 等类型，或用中文书写提交说明
---

# Git Commit（中文提交信息）

## 工作流程

1. **先看改动，再写信息**：
   - `git status` 查看工作区 / 暂存区状态
   - `git diff`（未暂存改动）+ `git diff --cached`（已暂存改动）分析具体内容
   - 改动文件多时，先用 `git diff --stat` 概览，再挑关键文件的 diff 细看
2. **判断改动类型**，按下面的格式生成提交信息
3. **执行提交**：`git commit`。有未暂存改动时，先询问用户是否 `git add`，不要擅自全量 add

## 提交信息格式（Conventional Commits）

```
<type>(<scope>): <subject>

<body>

<footer>
```

## type 对照表

| type | 含义 | 中文示例 |
|------|------|----------|
| feat | 新功能 | `feat: 新增用户登录接口` |
| fix | 修复 bug | `fix: 修复时间戳解析错误` |
| docs | 文档 | `docs: 更新部署说明` |
| style | 格式调整，不影响逻辑 | `style: 统一缩进为 2 空格` |
| refactor | 重构，不新增功能也不修 bug | `refactor: 抽取公共请求拦截器` |
| perf | 性能优化 | `perf: 用缓存减少重复查询` |
| test | 测试相关 | `test: 补充登录单元测试` |
| build | 构建系统或依赖变更 | `build: 升级 vite 到 5.2` |
| ci | CI 配置变更 | `ci: 添加 GitHub Actions 部署流水线` |
| chore | 杂项（配置、工具等） | `chore: 更新 .gitignore` |
| revert | 回滚提交 | `revert: 回滚「新增用户登录接口」` |

- **scope**：可选的模块名，如 `fix(login): ...`。跨模块改动可省略
- **破坏性变更**：type 后加 `!`，并在 footer 写 `BREAKING CHANGE: 说明`

## 中文书写规则

1. subject 用简洁的中文短语，**不以句号结尾**，尽量控制在 50 字以内
2. 用「新增 / 修复 / 重构 / 删除 / 升级」这类简洁动词开头，避免「添加了」「做了一个」等口语化表述
3. body 说明**为什么改**，而不是复述 diff 里显而易见的「改了什么」
4. 破坏性变更必须写 `BREAKING CHANGE:` footer，说明影响范围
5. 关联 issue 时在 footer 写 `Closes #123`

## 示例

- `feat: 新增用户注册功能`
- `fix(login): 修复验证码过期后仍可提交的问题`
- `refactor: 抽取通用的请求错误处理逻辑`
- `feat!: 用户接口鉴权改为 JWT`（footer 注明 BREAKING CHANGE）

## 执行提交

单行信息：

```bash
git commit -m "feat: 新增用户注册功能"
```

多行信息（subject + body）：

```bash
git commit -m "fix(login): 修复验证码过期仍可提交" -m "验证码过期后 token 未失效，存在重放风险；现在提交前强制校验验证码状态。"
```

## 注意事项

- 用户明确给出提交信息时，以用户为准，只做规范层面的格式化
- 改动混合多种类型时，以最主要改动定 type，其余在 body 里说明
- 不确定类型归属时，结合 diff 判断语义（如删了死代码属于 refactor 而非 fix）
