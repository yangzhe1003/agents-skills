# 现成长任务循环方案

以下是公开源文件和官方文档的调研结果，核查日期：2026-09-20。此 skill 为独立编写的执行协议，没有复制第三方实现或安装它们。

## Ralph Wiggum：宿主内 Stop hook

- 项目：https://github.com/anthropics/claude-code/tree/main/plugins/ralph-wiggum
- 说明：https://raw.githubusercontent.com/anthropics/claude-code/main/plugins/ralph-wiggum/README.md
- 实现：https://raw.githubusercontent.com/anthropics/claude-code/main/plugins/ralph-wiggum/hooks/stop-hook.sh

它用 Claude Code 的 Stop hook 阻止当前会话结束，再把同一任务提示交给 agent。状态保存在 `.claude/ralph-loop.local.md`，以最大迭代次数和完成标记决定退出。

可借鉴持久化状态、最大轮数及取消机制。但 hook 的输入、输出和 transcript 格式依赖宿主，不能直接认定适用于 ZCode。完成标记也不是测试证据。该机制不负责 agent 进程崩溃或机器重启后的自动拉起。

许可证：本次未核实到插件独立 LICENSE；GitHub API 对仓库的 license 字段返回 null，不能据此假定 MIT 或认定没有其他许可条款。复制代码前另行确认。

## snarktank/ralph：外部命令行循环

- 项目：https://github.com/snarktank/ralph
- 脚本：https://raw.githubusercontent.com/snarktank/ralph/main/ralph.sh
- 任务模板：https://github.com/snarktank/ralph/blob/main/prd.json.example
- 许可证：https://raw.githubusercontent.com/snarktank/ralph/main/LICENSE

外部 Bash 脚本每轮启动新的 Amp 或 Claude agent，默认最多 10 轮。通过 `prd.json`、`progress.txt` 和 Git 传递状态，用输出中的完成标记判断退出。

优点是每轮有新上下文，状态保存在磁盘。限制是需要相应 CLI，现有脚本采用跳过权限确认的运行参数，完成判断仍依赖 agent 输出；脚本本身不提供进程崩溃后的守护拉起。

适合借鉴任务清单和检查点，不直接复制权限绕过参数。本 skill 也不会把每轮自动 Git 提交作为默认行为。许可证已核实为 MIT。

## obra/superpowers：工程执行技能集

- 项目：https://github.com/obra/superpowers
- 启动 hook：https://raw.githubusercontent.com/obra/superpowers/main/hooks/session-start
- 许可证：https://raw.githubusercontent.com/obra/superpowers/main/LICENSE

提供需求澄清、计划、测试、子代理开发、审查和收尾技能，启动 hook 注入使用说明。适合改进长任务执行质量，但不是已核实的跨进程自动重启器。

可借鉴任务拆分、验证和审查；不必为了一个循环执行 skill 安装整套流程。许可证已核实为 MIT。

## Anthropic：长任务 harness 的状态设计

- 官方文章：https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents

文章使用初始化阶段、功能清单、进度文件和 Git 记录，在多次 agent 会话间交接状态。每次先读取进度，再处理一个未完成功能并验证，最后保存交接信息。

这是设计方法，不是可直接安装的后台运行器。本 skill 主要采用其可移植思想：可恢复任务清单、每轮可验证增量、磁盘检查点，以及先核实实际工作区再恢复。没有把文章中的提交惯例扩展为用户未授权的自动提交。

## 选择建议

- 想让当前 agent 少停在“下一步计划”，并在中断后方便续做：使用 `long-task-loop`。
- 想在同一会话尝试结束时强制继续：需要宿主支持的 Stop hook，先核实其真实协议。
- 想每轮新开上下文、退出后再次拉起：需要外部 CLI 循环或宿主工作流/调度器，并另行验证失败、取消和预算处理。

技能负责执行方式，检查点负责状态传递，运行器负责再次启动。这三者不能互相冒充。
