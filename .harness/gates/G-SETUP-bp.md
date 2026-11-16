---
id: G-SETUP-bp
task:
kind: external
status: open
created: 2026-11-16
urgency: normal
recommended: A
decided_by: human
review_minutes: 3
default_if_no_answer: 不开；strict 模式继续在本机挡住合并
blocks: []
answer:
approve_options: [A]
then:
then_policy:
then_rules: []
pr:
issue:
---

# G-SETUP-bp 在 GitHub 上给 nnddoon/harness-verify-022 的 main 开分支保护吗？

**为什么需要你：** 改 GitHub 仓库设置是对外操作，harness 不替你执行；只有你能批准并运行。

**预计耗时：** 3 分钟

**注意：** 仓库规则集（rulesets）可能仍在保护这个分支，开之前先在 Settings → Rules 看一眼。

## 怎么检查
```bash
gh api --hostname github.com -X PUT repos/nnddoon/harness-verify-022/branches/main/protection -H "Accept: application/vnd.github+json" -F required_status_checks=null -F enforce_admins=true -F "required_pull_request_reviews[required_approving_review_count]=0" -F restrictions=null -F allow_force_pushes=false -F allow_deletions=false
```
1. 确认仓库（github.com 上的 nnddoon/harness-verify-022）和分支（main）是对的。
2. 选 A：在你自己的终端运行上面的这条命令（需要仓库管理员权限）。
3. 验证：`gh api --hostname github.com repos/nnddoon/harness-verify-022/branches/main/protection` 能读到设置（不再是 404）。

## 机器已预检
| 项目 | 结果 | 通过 |
|---|---|---|
| 分支保护（只读查询） | main 未开保护（HTTP 404 Branch not protected） | ✅ |
| 写调用 | 0 次（harness init 只读） | ✅ |

## 选项
- **A（推荐）**：由你执行上面的这条命令开启 — 后果：main 必须走 PR（不强制别人审批，一个人也能合并自己的 PR）、禁止强推和删除、管理员也受约束
- **B**：先不开 — 后果：只靠 strict 模式在本机挡住合并，GitHub 上仍可直接推 main

**回复格式：** `G-SETUP-bp: A` 或 `G-SETUP-bp: B，<备注>`
