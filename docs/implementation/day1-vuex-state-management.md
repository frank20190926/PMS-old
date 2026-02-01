# 项目生命周期模块重构 - Day 1 实施记录

**日期:** 2026-01-30
**阶段:** Day 1 - Vuex状态管理层
**状态:** ✅ 完成

---

## 已完成工作

### 1. 创建 API 客户端 ✅

**文件:** `kml-pms-v2-vue/src/api/pms/efficiency/project.js`

新增API方法：
- `getProjectDetail(projectId)` - 获取项目详情
- `getProjectPhases(projectId)` - 获取项目阶段列表
- `getProjectDocuments(projectId, phaseType)` - 获取项目文档
- `getProjectTasks(projectId)` - 获取项目任务列表
- `getProjectPermissions(projectId)` - 获取项目权限
- `approveDocument(docId, data)` - 审批文档
- `uploadTaskTemplate(formData)` - 上传任务模板
- `completeMilestone(phaseId)` - 完成里程碑

### 2. 创建 projectContext Vuex 模块 ✅

**文件:** `kml-pms-v2-vue/src/store/modules/projectContext.js`

**State 结构:**
```javascript
{
  currentProject: {      // 当前项目基本信息
    projectId, projectTitle, projectSn, projectStatus,
    pmUserId, pmUserName, startDate, endDate, projectType
  },
  projectPhases: [],     // 项目阶段配置
  projectDocuments: {    // 项目文档(按阶段分组)
    REQUIREMENT: [], DESIGN: [], DEVELOPMENT: [],
    TESTING: [], DEPLOYMENT: []
  },
  projectTasks: [],      // 项目任务列表
  permissions: {         // 权限缓存
    canEditPhase, canUploadDoc, canApproveDoc,
    canGenerateTask, canAssignTask, canCompleteMilestone
  },
  loading: {            // 加载状态
    project, phases, documents, tasks
  }
}
```

**Getters (6个):**
- `projectId` - 当前项目ID
- `currentPhase` - 当前进行中的阶段
- `projectProgress` - 项目整体进度百分比
- `pendingDocsCount` - 待审批文档数量
- `pendingMilestones` - 待完成里程碑列表
- `taskStats` - 任务统计(总数/待处理/进行中/已完成/延误)

**Mutations (8个):**
- `SET_PROJECT` - 设置项目信息
- `SET_PHASES` - 设置阶段列表
- `SET_DOCUMENTS` - 设置文档列表(按阶段)
- `SET_TASKS` - 设置任务列表
- `SET_PERMISSIONS` - 设置权限
- `SET_LOADING` - 设置加载状态
- `UPDATE_PHASE_STATUS` - 更新阶段状态
- `COMPLETE_MILESTONE` - 完成里程碑
- `CLEAR_PROJECT_CONTEXT` - 清空项目上下文

**Actions (5个):**
- `loadProjectContext` - 加载项目完整上下文(并行加载,避免重复)
- `approveDocument` - 审批文档并刷新文档列表
- `generateTasksFromTemplate` - 从Excel模板生成任务
- `completeMilestone` - 完成里程碑
- `clearProjectContext` - 清空项目上下文

**特性:**
- ✅ 并行加载 - 使用 Promise.all 同时加载多个API
- ✅ 智能缓存 - 避免重复加载相同项目
- ✅ 容错处理 - 权限加载失败不影响主流程
- ✅ 兼容性 - 适配后端不同的返回格式

### 3. 注册 Vuex 模块 ✅

**文件:** `kml-pms-v2-vue/src/store/index.js`

已将 `projectContext` 模块注册到主 store，可通过 `this.$store.state.projectContext` 访问。

---

## 技术要点

### 1. 数据兼容性处理

后端返回的数据格式可能不一致，在 `SET_PROJECT` mutation 中做了兼容处理：

```javascript
SET_PROJECT(state, project) {
  state.currentProject = {
    projectTitle: project.projectTitle || project.projectName,  // 兼容不同字段名
    projectStatus: project.projectStatus || project.status,
    startDate: project.startDate || project.planStartTime,
    // ...
  }
}
```

### 2. 并行加载优化

使用 `Promise.all` 并行加载多个API，减少总加载时间：

```javascript
const [projectRes, phasesRes, tasksRes] = await Promise.all([
  getProjectDetail(projectId),
  getProjectPhases(projectId),
  getProjectTasks(projectId)
])
```

### 3. 智能缓存机制

避免重复加载相同项目：

```javascript
if (state.currentProject.projectId === projectId && state.projectPhases.length > 0) {
  return { success: true, cached: true }
}
```

### 4. 容错设计

权限加载失败时使用默认权限，不影响主流程：

```javascript
try {
  const permRes = await getProjectPermissions(projectId)
  // ...
} catch (error) {
  console.warn('加载项目权限失败:', error)
  commit('SET_PERMISSIONS', { /* 默认权限 */ })
}
```

---

## 使用示例

### 组件中使用

```javascript
// 读取状态
computed: {
  ...mapState('projectContext', ['currentProject', 'projectPhases']),
  ...mapGetters('projectContext', ['projectProgress', 'taskStats'])
}

// 调用action
methods: {
  ...mapActions('projectContext', ['loadProjectContext', 'approveDocument']),

  async loadProject() {
    const result = await this.loadProjectContext(this.$route.params.projectId)
    if (result.success) {
      this.$message.success('项目信息加载成功')
    } else {
      this.$message.error(result.error)
    }
  }
}
```

### 路由守卫中使用

```javascript
beforeEnter: async (to, from, next) => {
  const projectId = to.params.projectId
  const result = await store.dispatch('projectContext/loadProjectContext', projectId)

  if (result.success) {
    next()
  } else {
    Message.error('加载项目信息失败')
    next('/efficiency/projects')
  }
}
```

---

## 下一步工作

### Day 2: 项目外壳重构

- [ ] 修改项目详情 Shell 页面 (`views/pms/efficiency/project/index.vue`)
  - 移除重复的项目选择器
  - 从 Vuex 读取 projectId
  - 添加项目信息展示头部

- [ ] 配置路由守卫 (`router/index.js`)
  - 在进入项目详情前自动加载项目上下文
  - 处理加载失败的情况

- [ ] 重构第一批子页面
  - 阶段配置 (`project/phase/setup.vue`)
  - 文档管理 (`project/document/index.vue`)
  - 任务管理 (`task/index.vue`)

  移除每个页面中的：
  - 项目选择器组件
  - 项目列表数据
  - handleProjectChange 方法

  改为从 Vuex 读取：
  - `computed: { ...mapState('projectContext', ['currentProject']) }`
  - `this.$store.getters['projectContext/projectId']`

---

**Day 1 总结:**
- ✅ 完成 Vuex 状态管理层搭建
- ✅ 创建完整的 API 客户端
- ✅ 实现智能缓存和并行加载优化
- ✅ 代码量: ~450行

**下一步:** 开始 Day 2 - 项目外壳重构

**实施人:** Claude Code
**完成时间:** 2026-01-30
