# Skills 中文版

> 本仓库是 Matt Pocock 工程技能集合的中文入口。英文原文保留在 [README.md](README.md)，中文说明用于帮助中文用户理解每个技能的用途、安装方式和使用边界。

## 项目简介

这些技能面向真实软件工程工作，而不是一次性“氛围编码”。它们把常见工程实践拆成小而可组合的 Agent Skills，帮助 AI 代理在需求澄清、问题诊断、测试驱动开发、架构改进、任务拆分和上下文交接中更稳地工作。

核心思路：

- 技能应该小、清晰、可组合。
- 用户保留对流程的控制权。
- 代理需要先对齐问题和术语，再开始实现。
- 反馈环路很重要：类型检查、测试、运行验证和浏览器检查都应尽早接入。

## 30 秒快速开始

```bash
npx skills@latest add mattpocock/skills
```

安装时选择你需要的技能和目标代理。建议先选择 `/setup-matt-pocock-skills`，它会帮助当前仓库建立后续技能需要的配置：

- 使用哪个 issue tracker：GitHub、Linear 或本地文件。
- `/triage` 使用哪些标签。
- 文档和 ADR 应保存在哪里。

## 工程技能

- `diagnose`：用复现、最小化、假设、插桩、修复和回归测试的循环诊断复杂 bug。
- `grill-with-docs`：在实现前追问计划、术语和边界，并更新 `CONTEXT.md` 与 ADR。
- `triage`：通过角色和状态机梳理 issue。
- `improve-codebase-architecture`：结合领域语言和 ADR，寻找代码库中可以加深模块、降低复杂度的机会。
- `setup-matt-pocock-skills`：初始化其他工程技能需要的仓库级配置。
- `tdd`：按红-绿-重构循环实现功能或修复 bug。
- `to-issues`：把计划、规格或 PRD 拆成可独立领取的 GitHub issues。
- `to-prd`：把当前上下文整理成 PRD 并提交为 GitHub issue。
- `zoom-out`：让代理从更高层次解释陌生代码或系统上下文。
- `prototype`：为状态逻辑或 UI 方案快速做一次性原型。

## 效率技能

- `caveman`：极简表达模式，用更少 token 保留技术准确性。
- `grill-me`：在非代码场景中对计划做深入追问。
- `handoff`：把当前会话整理成交接文档，方便其他代理继续。
- `write-a-skill`：按正确结构创建新的技能。

## 其他技能

- `git-guardrails-claude-code`：为 Claude Code 配置 hooks，阻止危险 git 命令。
- `migrate-to-shoehorn`：把测试中的 `as` 类型断言迁移到 `@total-typescript/shoehorn`。
- `scaffold-exercises`：创建课程练习目录结构。
- `setup-pre-commit`：配置 Husky、lint-staged、Prettier、类型检查和测试。

## 汉化原则

- 英文原文保留，便于与上游同步。
- 技能名称、命令、文件名、库名和引用原文不翻译。
- 中文说明优先解释“什么时候用”和“为什么用”。
- 深度翻译 `SKILL.md` 时应按目录分批提交，避免术语不一致。

## License

许可证与归属信息以英文原文为准。参见 [LICENSE](LICENSE) 和 [README.md](README.md)。
