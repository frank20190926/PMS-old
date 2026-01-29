# 人效中心项目详情壳页面 Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 增加“项目列表 → 项目详情壳 → 项目内菜单”主流程，项目内页面统一基于 projectId 跳转。

**Architecture:** 前端新增项目列表页与项目详情壳页面，项目内菜单通过子路由承载现有页面；后端仅统一项目列表数据范围接口（保持现有 /my-projects）。全局入口保留。

**Tech Stack:** Vue2 + ElementUI, RuoYi 前后端, MyBatis, Playwright E2E

---

### Task 1: 规划前端路由与菜单结构（草改路线图）

**Files:**
- Modify: `kml-pms-v2-vue/.worktrees/eff-project-shell/src/router/index.js`
- Create: `kml-pms-v2-vue/.worktrees/eff-project-shell/src/views/pms/efficiency/project/index.vue`
- Create: `kml-pms-v2-vue/.worktrees/eff-project-shell/src/views/pms/efficiency/project/project-list.vue`

**Step 1: 写路由变更草稿（仅注释/草案）**
- 在 router 中加入 `/efficiency/projects` 和 `/efficiency/project/:projectId`（子路由：tasks/gantt/lifecycle/reports）

**Step 2: 运行前端路由检查（若有）**
Run: `npm run lint`（如项目已有）
Expected: PASS 或提示忽略

**Step 3: 提交草案**
Run:
```bash
git add kml-pms-v2-vue/.worktrees/eff-project-shell/src/router/index.js
git commit -m "feat: scaffold project shell routes"
```

---

### Task 2: 新增项目列表页（项目主入口）

**Files:**
- Create: `kml-pms-v2-vue/.worktrees/eff-project-shell/src/views/pms/efficiency/project/project-list.vue`
- Modify: `kml-pms-v2-vue/.worktrees/eff-project-shell/src/api/pms/efficiency/projectCommon.js`（必要时）

**Step 1: 写失败用例（可选，E2E 或单元）**
- 若无前端单测体系，跳过

**Step 2: 实现项目列表**
- 表格列：项目名称、状态、负责人（如有）、操作“进入项目”
- 数据源：`/pms/efficiency/project/common/my-projects`
- 操作：进入 `/efficiency/project/:projectId`

**Step 3: 本地手动验证**
- 打开项目列表，确认项目可见

**Step 4: 提交**
```bash
git add kml-pms-v2-vue/.worktrees/eff-project-shell/src/views/pms/efficiency/project/project-list.vue
git commit -m "feat: add efficiency project list entry"
```

---

### Task 3: 项目详情壳页面（左侧项目内菜单）

**Files:**
- Create: `kml-pms-v2-vue/.worktrees/eff-project-shell/src/views/pms/efficiency/project/index.vue`
- Modify: `kml-pms-v2-vue/.worktrees/eff-project-shell/src/router/index.js`

**Step 1: 实现壳页面结构**
- 顶部项目信息条（项目名称/编号/负责人/状态/返回）
- 左侧菜单：概览、任务、甘特、生命周期(阶段/文档/任务生成/流程仪表)、日报/周报

**Step 2: 子路由容器**
- `<router-view>` 渲染具体页面
- 将 projectId 保持在 store 或 query

**Step 3: 本地手动验证**
- 从项目列表进入壳页面
- 菜单切换保持 projectId

**Step 4: 提交**
```bash
git add kml-pms-v2-vue/.worktrees/eff-project-shell/src/views/pms/efficiency/project/index.vue kml-pms-v2-vue/.worktrees/eff-project-shell/src/router/index.js
git commit -m "feat: add project shell layout and menu"
```

---

### Task 4: 复用现有页面为项目维度

**Files:**
- Modify: `kml-pms-v2-vue/.worktrees/eff-project-shell/src/views/pms/efficiency/task/index.vue`
- Modify: `kml-pms-v2-vue/.worktrees/eff-project-shell/src/views/pms/efficiency/gantt/index.vue`
- Modify: `kml-pms-v2-vue/.worktrees/eff-project-shell/src/views/pms/efficiency/project/phase/setup.vue`
- Modify: `kml-pms-v2-vue/.worktrees/eff-project-shell/src/views/pms/efficiency/project/document/index.vue`
- Modify: `kml-pms-v2-vue/.worktrees/eff-project-shell/src/views/pms/efficiency/project/task-generation/index.vue`
- Modify: `kml-pms-v2-vue/.worktrees/eff-project-shell/src/views/pms/efficiency/project/workflow/index.vue`
- Modify: `kml-pms-v2-vue/.worktrees/eff-project-shell/src/views/pms/efficiency/daily-report/index.vue`
- Modify: `kml-pms-v2-vue/.worktrees/eff-project-shell/src/views/pms/efficiency/weekly-report/index.vue`

**Step 1: 读取 projectId**
- 优先从路由 params
- 若无 params，回退 query 或 store
- 对没有 projectId 的情况做引导（跳项目列表）

**Step 2: 接口筛选**
- 所有列表/查询接口添加 `projectId` 过滤（现有接口支持则直接传）

**Step 3: 手动验证关键页面**
- 任务列表/甘特/文档/阶段/日报/周报都能在项目内正常展示

**Step 4: 提交**
```bash
git add kml-pms-v2-vue/.worktrees/eff-project-shell/src/views/pms/efficiency/**
git commit -m "feat: scope efficiency pages by projectId"
```

---

### Task 5: 权限与菜单显示（前端）

**Files:**
- Modify: `kml-pms-v2-vue/.worktrees/eff-project-shell/src/router/index.js`
- Optional: `kml-pms-v2-vue/.worktrees/eff-project-shell/src/views/pms/efficiency/project/index.vue`

**Step 1: 顶层菜单保留全局入口**
- 项目列表、任务、日报、周报、PM 工作台、看板、数据同步

**Step 2: 项目内菜单不显示无权限项**
- 依据现有权限指令控制

**Step 3: 提交**
```bash
git add kml-pms-v2-vue/.worktrees/eff-project-shell/src/router/index.js
git commit -m "chore: adjust efficiency menus for project shell"
```

---

### Task 6: 后端项目列表数据范围（如需修正）

**Files:**
- Modify: `kml-pms-v2-server/.worktrees/eff-project-shell/application/src/main/java/com/app/pms/efficiency/project/controller/EffProjectCommonController.java`

**Step 1: 数据范围逻辑确认**
- PM：仅自己负责（user_id）
- 管理员/部门负责人：返回全部或按数据范围

**Step 2: 编译验证**
Run: `mvn -pl application -am install -DskipTests`

**Step 3: 提交**
```bash
git add kml-pms-v2-server/.worktrees/eff-project-shell/application/src/main/java/com/app/pms/efficiency/project/controller/EffProjectCommonController.java
git commit -m "fix: align project list data scope"
```

---

### Task 7: E2E/手测验证

**Files:**
- Modify (if needed): `tests/e2e/tests/project_init.spec.ts`
- Modify (if needed): `tests/e2e/tests/task_flow.spec.ts`

**Step 1: 手测路径**
- 项目列表 → 进入项目 → 任务/阶段/文档/日报/周报切换
- 直接访问 `/efficiency/project/:projectId/tasks`

**Step 2: E2E（可选）**
Run: `npx playwright test tests/project_init.spec.ts`

**Step 3: 提交测试调整（如有）**

---

### Task 8: 文档更新

**Files:**
- Modify: `CLAUDE.md`
- Modify: `docs/plans/2026-01-29-efficiency-project-shell-design.md`（如需）

**Step 1: 记录变更与验证结果**
**Step 2: 提交**
```bash
git add CLAUDE.md
git commit -m "docs: record project shell implementation"
```

---

## 执行说明
- 前端与后端在各自 worktree 中实现与提交。
- 如需要合并回主仓，请告知合并策略。
