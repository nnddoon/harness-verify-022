---
id: T-002
title: README 末尾加一行 nightly loop 重测标记
status: ready            # proposed | ready | claimed | in_progress | waiting_human | blocked | review | done
priority: P2
risk: low
size: S
source: human
spec:
test_owner: any             # 纯文档一行追加，无需新测试；验收用 shell 断言（对齐时说明）
branch: task/T-002-readme-nightly-line
worktree: .claude/worktrees/T-002
session: auto
depends_on: []
context_files: []
allowed_paths: [README.md]
locked_paths: [package.json, package-lock.json, pyproject.toml, src/**, tests/**]
unlock: []
gates: []
auto_ok: yes
---

# T-002 README 末尾加一行 nightly loop 重测标记

## 1. 背景与目标
harness 0.2.2 Mac 重测第 4 项：需要一个极小的任务，让 `scripts/harness-loop.sh` 在 bash 3.2 下跑完整个夜间循环。做完后 README.md 最后一行是 `Nightly loop retest (harness 0.2.2).`。

## 2. 范围
**做：**
- 在 README.md 末尾追加一行 `Nightly loop retest (harness 0.2.2).`（文件以换行结尾）。

**不做（明确排除）：**
- 不改 README 前 3 行、不调整格式。
- 不动 src/、tests/、依赖清单、任何配置和 `.harness/verify.sh`。
- 不新增测试。

## 3. 需求对齐与影响分析
**对齐记录**
| 问题 | 结论 | 来源（用户原话 / 决策编号 / 推断） |
|---|---|---|
| 追加的文字 | 恰为 `Nightly loop retest (harness 0.2.2).`，单独一行，放在文件最后 | 用户原话 |
| 验收方式 | 该行存在 + `.harness/verify.sh` 通过 | 用户原话（经控制塔会话转达） |
| auto_ok | yes | 用户原话（经控制塔会话转达） |
| test_owner | any：一行文档追加，不写新测试，用 shell 断言验收 | 推断 |

**影响分析**（impact-analyst 子代理产出）
| 项目 | 结果 | 证据（命令 / 文件:行） |
|---|---|---|
| 直接改动 | README.md（纯文档，3 行，以 `\n` 结尾） | `tail -c 1 README.md \| xxd` → 0a |
| 调用方 / 依赖方 | 无 | `rg -n -i readme` 全仓仅命中 .claude/rules/harness-guardrails.md:34（泛指依赖包 README）；pyproject.toml / package.json 无 readme 字段 |
| 受影响的测试 | 无 | tests/test_app.py、tests/unit/sum.test.ts 不引用 README |
| 对外契约（API、事件、schema、配置、URL） | 无 | — |
| 数据 / 迁移 | 无 | — |
| 依赖变更 | 无 | — |
| 风险等级与理由 | low：纯文档追加，无调用方、无契约、不在 locks.txt | `cat .harness/locks.txt`；基线 `bash .harness/verify.sh` 在 main@18e0d02 退出 0（ruff/mypy/pytest 1 passed/vitest 1 passed） |

## 4. 修改过程（计划 → 执行日志）
- [ ] 1. 在 README.md 末尾追加 `Nightly loop retest (harness 0.2.2).` 并保留结尾换行 — 结果：
- [ ] 2. 断言最后一行正确：`test "$(tail -n 1 README.md)" = 'Nightly loop retest (harness 0.2.2).'` — 结果：
- [ ] 3. 完整验证 `bash .harness/verify.sh` — 结果：

## 5. 验收标准
**A. 机器验收（verifier 子代理逐条核对）**
- [ ] A1. README.md 最后一行恰为 `Nightly loop retest (harness 0.2.2).` — 验证：`test "$(tail -n 1 README.md)" = 'Nightly loop retest (harness 0.2.2).'` 退出码 0 — 证据：
- [ ] A2. README.md 前 3 行未改 — 验证：`git diff origin/main...HEAD -- README.md` 只有一行 `+` 新增、无 `-` 行 — 证据：
- [ ] A3. 已有测试全部通过、未删除/跳过，lint/类型检查通过 — 验证：`bash .harness/verify.sh` 退出码 0 — 证据：
- [ ] A4. 仅修改了 allowed_paths 内的文件（任务卡/交接包除外） — 验证：`git diff --name-only origin/main...HEAD` 只含 README.md 及 .harness/tasks/T-002*、.harness/handoffs/T-002* — 证据：

**B. 人工验收（→ 人工门）**
- 无

## 6. Guardrails（本任务特有）
- 不改：README.md 前 3 行；`.harness/verify.sh`（全局冻结）。
- 不引入：任何依赖、测试、配置变更。
- 兼容：文件末尾保留换行。

## 7. 当前进展（中断/换对话时更新）
- 最后更新：2026-11-16（task-align）
- 做到哪：任务卡已写，等待用户确认
- 下一步：确认后转 ready，交给 `scripts/harness-loop.sh` 派发
- 卡住的点：无

## 8. 发现的问题（不在本任务范围，收尾时进 backlog 提议区）
- 

## 9. 范围变更 / 依赖变更
- 

## 10. Verifier 结论
- 结论：PENDING
- 说明：

## 11. 尝试日志（每次修复前先写假设；同一问题最多 5 次）
| # | 假设 | 改动 | 结果 |
|---|---|---|---|

## 12. 教训

## 13. 对抗审查（risk low，跳过）
| 轮 | 挑错数 | 成立 | 已处理 | 说明 |
|---|---|---|---|---|
