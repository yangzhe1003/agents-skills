# 来源与合并说明

本技能统一了本地需求收敛、产品减法与开源产品发现方法。只有一个通用入口 product-design；没有引入 CloudBase ui-design 的视觉规则。

## 开源方法来源

- 项目：[phuryn/pm-skills](https://github.com/phuryn/pm-skills)，维护者 Paweł Huryn。
- 具体技能：[Opportunity Solution Tree](https://github.com/phuryn/pm-skills/blob/c68487d721e419ec87af1ae6412a842978eab785/pm-product-discovery/skills/opportunity-solution-tree/SKILL.md)。
- 核对版本：c68487d721e419ec87af1ae6412a842978eab785。
- 许可：MIT，原许可与版权声明保留在 [upstream-LICENSE.txt](upstream-LICENSE.txt)。
- 方法基础：上游技能采用 Teresa Torres 的机会解决方案树，将预期结果、用户机会、候选方案和验证相连。本技能重新组织并用中文适配，不宣称为上游原版。

## 选择依据

2026-10-12 通过 GitHub API 核对并阅读相关说明与技能正文。Stars 是仓库关注度信号，不能证明单个技能的质量，更不代表行业公认排名。

| 候选仓库 | 当时 Stars | 本次适配判断 |
| --- | --- | --- |
| phuryn/pm-skills | 26,905 | 专注产品工作，选取其独立产品发现技能作为方法来源 |
| anthropics/knowledge-work-plugins | 29,168 | 官方综合知识工作插件；产品头脑风暴内容较偏发散探索 |
| alirezarezvani/claude-skills | 28,033 | 跨领域技能集合，产品与 UX 只是其中一部分 |
| deanpeters/Product-Manager-Skills | 7,263 | 专注产品管理，但整套策略工作流较重 |

也阅读了 LobeHub 的产品设计技能作比较，未将它或其依赖纳入本技能。没有发现足以支持“公认第一”的证据；本次选择依据是产品领域关注度、任务匹配与可裁剪性。

## 合并与取舍

- 本地 requirement-scope：保留明确要求、必要支撑与可选扩展的区分，防止自创验收来扩展范围，保持完整验证与达标结束。
- 本地 product-simplify：保留核心任务、保留有效设计、删除/合并/压缩/下沉、新增需要举证，以及认知成本不能只看元素数量。
- 上游 Opportunity Solution Tree：保留单一主要结果、问题先于方案、证据和假设分开、比较方案并验证关键假设。
- 适配用户偏好：取消上游默认的机会数、方案数、实验数、每周更新及完整树输出要求；仅在任务确需探索时展开方法。
- 交付边界：点评、设计与实施按用户当前请求选择，不自动安装整套插件、生成 PRD、安排持续研究或新增业务功能。

本地旧技能已备份到技能发现目录之外，后续通用规则统一维护在本技能中。CloudBase 的 ui-design 原文件不参与合并，也不修改。
