# 人效中心测试方案（自动化）

**范围**: 核心链路 + 权限/数据范围
**方法**: 接口自动化（pytest + requests） + 前端 E2E（Playwright）

---

## 1. 总体策略

- 接口自动化覆盖后端功能、权限、联动与回写逻辑
- 前端 E2E 覆盖端到端用户流程与 UI 行为
- 数据隔离：使用测试项目与测试账号

---

## 2. 接口自动化用例清单（pytest）

### A. 任务链路
1. 创建阶段/里程碑/任务（模板或手动）
2. 任务下发（负责人分配）
3. 任务状态更新（PENDING→IN_PROGRESS→DELAYED→COMPLETED）
4. 任务转派（含已完成/归档二次确认）
5. 任务批量操作（下发/时间/状态）

### B. 日报链路
1. 员工提交日报（关联任务，多条明细）
2. 工时 > 8h 可提交，但需理由
3. PM 审核日报，更新任务进度
4. 未提交日报记录生成

### C. 周报链路
1. 工作周自动生成周报草稿
2. 员工编辑并提交
3. 缺失日报天数标记

### D. 回写联动
1. 提交日报 → 创建 `pms_report`
2. 审核通过 → 更新同一条 `pms_report`
3. 工时回写固定 8 小时
4. 同步审计表状态与重试

### E. 权限与范围
1. 员工仅访问自身任务/日报
2. PM 管理权限
3. 部门负责人只读范围（项目配置）

---

## 3. 前端 E2E 流程清单（Playwright）

1. 项目初始化/排期
   - PM 登录 → 项目列表“快速初始化” → 选模板 → 自动排期 → 调整 → 保存 → 生成任务
2. 任务下发与进度
   - PM 下发任务 → 员工看到任务 → 提交日报 → PM 审核 → 任务进度更新
3. 日报附件
   - 员工上传附件 → PM/部门负责人可查看 → 权限校验
4. 周报
   - 周五生成草稿 → 员工编辑提交 → 个人总览 + 项目拆分视图
5. 回写联动验证
   - 提交日报后检查老系统日报列表/详情（若 UI 可访问）

---

## 4. 推荐目录结构

```
tests/
  api/
    conftest.py
    test_tasks.py
    test_daily_reports.py
    test_weekly_reports.py
    test_sync_writeback.py
    test_permissions.py
  e2e/
    playwright.config.ts
    tests/
      project_init.spec.ts
      task_flow.spec.ts
      daily_report.spec.ts
      weekly_report.spec.ts
      attachments.spec.ts
```

---

## 5. 通过标准

- 接口自动化全部通过
- E2E 核心流程全部通过
- 权限抽样验证通过

