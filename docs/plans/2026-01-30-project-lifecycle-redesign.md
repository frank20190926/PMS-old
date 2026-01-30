# 项目生命周期模块重新设计方案

**设计日期:** 2026-01-30
**问题诊断:** PROJECT_LIFECYCLE_DIAGNOSIS_2026-01-30.md
**目标:** 解决项目生命周期模块的业务流程混乱、数据传递问题和用户体验问题

---

## 一、设计目标

### 核心价值
- ✅ **严格的流程控制** - 明确的阶段划分和里程碑管理
- ✅ **自动化任务生成** - 基于模板和规则自动创建开发任务

### 业务需求
1. **清晰的项目生命周期流程** - 7个标准阶段,支持并行执行
2. **里程碑管理** - 关键节点控制,必须上传文档才能推进
3. **任务自动生成** - Excel模板解析 + PM审核机制
4. **强制任务关联** - 日报必须关联任务,支持3种任务类型

---

## 二、业务流程设计

### 2.1 项目生命周期7阶段

```
┌─────────────┐
│ 1. 项目配置  │ - PM创建项目基本信息
└──────┬──────┘   - 设置阶段配置(串行/并行)
       │          - 分配项目成员
       ↓
┌─────────────┐
│ 2. 需求阶段  │ - 上传需求文档
└──────┬──────┘   - 需求评审通过
       │          - 里程碑: 需求文档审核通过
       ↓
┌─────────────┐
│ 3. 设计阶段  │ - 上传设计文档(架构/详设)
└──────┬──────┘   - 设计评审通过
       │          - 里程碑: 设计文档审核通过
       ↓
┌─────────────┐
│ 4. 开发阶段  │ - 上传任务模板(Excel)
└──────┬──────┘   - 系统解析生成任务预览
       │          - PM审核分配任务
       │          - 里程碑: 开发任务全部完成
       ↓
┌─────────────┐
│ 5. 测试阶段  │ - 执行测试任务
└──────┬──────┘   - 提交测试报告
       │          - 里程碑: 测试报告审核通过
       ↓
┌─────────────┐
│ 6. 实施阶段  │ - 部署上线
└──────┬──────┘   - 上传部署文档
       │          - 里程碑: 上线验收通过
       ↓
┌─────────────┐
│ 7. 项目关闭  │ - 项目复盘
└─────────────┘   - 归档文档
```

### 2.2 阶段推进控制

**模式:** 并行执行 + 里程碑控制

- **并行执行:** 多个阶段可以同时进行(如需求确认的同时开始架构设计)
- **里程碑控制:** 每个阶段有关键里程碑,必须完成才能进入下一阶段

**里程碑示例:**
```javascript
{
  phaseType: 'REQUIREMENT',
  milestone: {
    name: '需求文档审核通过',
    requiredDocs: ['需求规格说明书', '原型设计'],
    blockNextPhase: true  // 阻塞下一阶段开始
  }
}
```

### 2.3 任务生成流程

```
[PM上传Excel任务模板]
    ↓
[系统解析Excel] ← EffTaskTemplateService
    ├─ 解析任务名称、负责人、工时
    ├─ 验证数据完整性
    └─ 生成任务预览数据
    ↓
[保存到预览表] ← eff_task_generation_preview
    ↓
[PM审核页面] ← task-generation-preview.vue
    ├─ 查看任务列表
    ├─ 修改工时/负责人
    ├─ 删除不需要的任务
    └─ 批准生成
    ↓
[批量创建正式任务] ← EffTaskService.batchCreateFromPreview()
    ├─ 写入 eff_task 表
    ├─ 设置 taskType = 'PROJECT'
    ├─ 设置 source = 'TEMPLATE'
    └─ 触发通知
```

**Excel模板格式:**
```
| 任务名称 | 负责人工号 | 预估工时(天) | 开始日期 | 结束日期 | 优先级 | 备注 |
|---------|-----------|-------------|---------|---------|--------|------|
| 登录模块开发 | 1001 | 3 | 2026-02-01 | 2026-02-03 | HIGH | 含单元测试 |
```

### 2.4 日报与任务关联

**3种任务类型:**

1. **项目任务 (PROJECT)** - 从排期/模板生成的正式任务
2. **临时任务 (TEMPORARY)** - 员工自行添加的非计划任务
3. **管理任务 (MANAGEMENT)** - 会议、培训等非开发任务

**日报填写规则:**
```javascript
// 前端验证
if (report.taskReports.length === 0) {
  this.$message.error('请至少关联一个任务')
  return false
}

// 每个任务必须填写工时
report.taskReports.forEach(tr => {
  if (!tr.actualHours || tr.actualHours <= 0) {
    this.$message.error('请填写任务的实际工时')
    return false
  }
})
```

**临时任务快速创建:**
```vue
<el-dialog title="添加临时任务">
  <el-form>
    <el-form-item label="任务名称">
      <el-input v-model="tempTask.taskName" />
    </el-form-item>
    <el-form-item label="任务类型">
      <el-select v-model="tempTask.taskType">
        <el-option label="临时开发" value="TEMPORARY" />
        <el-option label="会议沟通" value="MANAGEMENT" />
      </el-select>
    </el-form-item>
  </el-form>
</el-dialog>
```

---

## 三、技术架构设计

### 3.1 整体架构

```
┌─────────────────────────────────────────────────┐
│              展示层 (Presentation)               │
│  - ProjectShell.vue (项目外壳)                   │
│  - PhaseConfig.vue (阶段配置)                    │
│  - DocumentManagement.vue (文档管理)             │
│  - TaskManagement.vue (任务管理)                 │
│  - MilestoneTracking.vue (里程碑跟踪)            │
│  - ProjectOverview.vue (项目概览)                │
│  - DailyReportForm.vue (日报填写)                │
└─────────────────┬───────────────────────────────┘
                  │
                  ↓
┌─────────────────────────────────────────────────┐
│              业务层 (Business)                   │
│  - ProjectLifecycleService (生命周期管理)        │
│  - TaskTemplateService (任务模板解析)            │
│  - MilestoneService (里程碑管理)                 │
│  - DocumentWorkflowService (文档流程)            │
└─────────────────┬───────────────────────────────┘
                  │
                  ↓
┌─────────────────────────────────────────────────┐
│              数据层 (Data)                       │
│  - Vuex Store: projectContext                    │
│    ├─ currentProject (当前项目信息)              │
│    ├─ projectPhases (阶段配置)                   │
│    ├─ projectDocuments (文档列表)                │
│    ├─ projectTasks (任务列表)                    │
│    └─ permissions (权限缓存)                     │
│  - Backend API                                   │
│    ├─ EffProjectController                       │
│    ├─ EffPhaseController                         │
│    ├─ EffDocumentController                      │
│    └─ EffTaskController                          │
└─────────────────────────────────────────────────┘
```

### 3.2 Vuex状态管理

**store/modules/projectContext.js**

```javascript
const state = {
  // 当前项目基本信息
  currentProject: {
    projectId: null,
    projectTitle: '',
    projectSn: '',
    projectStatus: '',  // PLANNING/IN_PROGRESS/COMPLETED
    pmUserId: null,
    pmUserName: '',
    startDate: null,
    endDate: null,
    projectType: ''     // DEVELOPMENT/TESTING/OPERATION
  },

  // 项目阶段配置
  projectPhases: [
    {
      phaseId: null,
      phaseName: '',
      phaseType: '',     // REQUIREMENT/DESIGN/DEVELOPMENT/TESTING/DEPLOYMENT
      startDate: null,
      endDate: null,
      status: '',        // NOT_STARTED/IN_PROGRESS/COMPLETED
      assigneeId: null,
      assigneeName: '',
      orderNum: 0,
      milestone: {
        milestoneId: null,
        milestoneName: '',
        requiredDocs: [],
        isCompleted: false,
        completedDate: null
      }
    }
  ],

  // 项目文档(按阶段分组)
  projectDocuments: {
    'REQUIREMENT': [],
    'DESIGN': [],
    'TESTING': [],
    'DEPLOYMENT': []
  },

  // 项目任务列表
  projectTasks: [
    {
      taskId: null,
      taskName: '',
      taskType: '',      // PROJECT/TEMPORARY/MANAGEMENT
      phaseId: null,
      assigneeId: null,
      assigneeName: '',
      estimatedDays: 0,
      status: '',        // PENDING/IN_PROGRESS/COMPLETED/DELAYED
      progress: 0,
      createTime: null,
      startDate: null,
      endDate: null,
      source: ''         // SCHEDULE_SYNC/TEMPLATE/MANUAL
    }
  ],

  // 权限缓存
  permissions: {
    canEditPhase: false,
    canUploadDoc: false,
    canApproveDoc: false,
    canGenerateTask: false,
    canAssignTask: false,
    canCompleteMilestone: false
  },

  // 加载状态
  loading: {
    project: false,
    phases: false,
    documents: false,
    tasks: false
  }
}

const getters = {
  // 当前项目ID
  projectId: state => state.currentProject.projectId,

  // 当前阶段(最新的进行中阶段)
  currentPhase: state => {
    return state.projectPhases.find(p => p.status === 'IN_PROGRESS') || null
  },

  // 项目整体进度(已完成阶段/总阶段数)
  projectProgress: state => {
    const total = state.projectPhases.length
    const completed = state.projectPhases.filter(p => p.status === 'COMPLETED').length
    return total > 0 ? Math.round((completed / total) * 100) : 0
  },

  // 待审批文档数量
  pendingDocsCount: state => {
    let count = 0
    Object.values(state.projectDocuments).forEach(docs => {
      count += docs.filter(d => d.approvalStatus === 'PENDING').length
    })
    return count
  },

  // 待完成里程碑
  pendingMilestones: state => {
    return state.projectPhases
      .filter(p => p.milestone && !p.milestone.isCompleted)
      .map(p => p.milestone)
  },

  // 任务统计
  taskStats: state => {
    const tasks = state.projectTasks
    return {
      total: tasks.length,
      pending: tasks.filter(t => t.status === 'PENDING').length,
      inProgress: tasks.filter(t => t.status === 'IN_PROGRESS').length,
      completed: tasks.filter(t => t.status === 'COMPLETED').length,
      delayed: tasks.filter(t => t.status === 'DELAYED').length
    }
  }
}

const mutations = {
  SET_PROJECT(state, project) {
    state.currentProject = project
  },

  SET_PHASES(state, phases) {
    state.projectPhases = phases
  },

  SET_DOCUMENTS(state, { phaseType, documents }) {
    state.projectDocuments[phaseType] = documents
  },

  SET_TASKS(state, tasks) {
    state.projectTasks = tasks
  },

  SET_PERMISSIONS(state, permissions) {
    state.permissions = permissions
  },

  SET_LOADING(state, { key, value }) {
    state.loading[key] = value
  },

  UPDATE_PHASE_STATUS(state, { phaseId, status }) {
    const phase = state.projectPhases.find(p => p.phaseId === phaseId)
    if (phase) {
      phase.status = status
    }
  },

  COMPLETE_MILESTONE(state, { phaseId, completedDate }) {
    const phase = state.projectPhases.find(p => p.phaseId === phaseId)
    if (phase && phase.milestone) {
      phase.milestone.isCompleted = true
      phase.milestone.completedDate = completedDate
    }
  }
}

const actions = {
  // 加载项目完整上下文(并行加载)
  async loadProjectContext({ commit, dispatch }, projectId) {
    commit('SET_LOADING', { key: 'project', value: true })

    try {
      // 并行加载所有数据
      const [project, phases, tasks, permissions] = await Promise.all([
        api.getProjectDetail(projectId),
        api.getProjectPhases(projectId),
        api.getProjectTasks(projectId),
        api.getProjectPermissions(projectId)
      ])

      commit('SET_PROJECT', project.data)
      commit('SET_PHASES', phases.data)
      commit('SET_TASKS', tasks.data)
      commit('SET_PERMISSIONS', permissions.data)

      // 加载各阶段文档
      const phaseTypes = ['REQUIREMENT', 'DESIGN', 'TESTING', 'DEPLOYMENT']
      await Promise.all(
        phaseTypes.map(async type => {
          const docs = await api.getProjectDocuments(projectId, type)
          commit('SET_DOCUMENTS', { phaseType: type, documents: docs.data })
        })
      )

      return { success: true }
    } catch (error) {
      console.error('加载项目上下文失败:', error)
      return { success: false, error }
    } finally {
      commit('SET_LOADING', { key: 'project', value: false })
    }
  },

  // 审批文档(触发里程碑检查)
  async approveDocument({ commit, dispatch }, { docId, approved, reason }) {
    const result = await api.approveDocument(docId, { approved, reason })
    if (result.code === 200) {
      // 重新加载文档列表
      await dispatch('loadProjectContext', state.currentProject.projectId)
    }
    return result
  },

  // 从模板生成任务
  async generateTasksFromTemplate({ commit, state }, { templateFile, phaseId }) {
    const formData = new FormData()
    formData.append('file', templateFile)
    formData.append('projectId', state.currentProject.projectId)
    formData.append('phaseId', phaseId)

    const result = await api.uploadTaskTemplate(formData)
    if (result.code === 200) {
      // 生成预览后跳转到审核页面
      return { success: true, previewId: result.data.previewId }
    }
    return { success: false, message: result.msg }
  },

  // 完成里程碑
  async completeMilestone({ commit, state }, { phaseId }) {
    const result = await api.completeMilestone(phaseId)
    if (result.code === 200) {
      commit('COMPLETE_MILESTONE', {
        phaseId,
        completedDate: new Date().toISOString()
      })
    }
    return result
  }
}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}
```

### 3.3 路由配置

**router/index.js**

```javascript
{
  path: '/efficiency/project/:projectId',
  component: () => import('@/views/pms/efficiency/project/index.vue'),
  redirect: '/efficiency/project/:projectId/overview',
  meta: { title: '项目详情', requiresAuth: true },

  // 路由守卫: 进入前加载项目上下文
  beforeEnter: async (to, from, next) => {
    const projectId = to.params.projectId
    if (!projectId) {
      next('/efficiency/projects')
      return
    }

    // 加载项目上下文到Vuex
    const result = await store.dispatch('projectContext/loadProjectContext', projectId)

    if (result.success) {
      next()
    } else {
      Message.error('加载项目信息失败')
      next('/efficiency/projects')
    }
  },

  children: [
    {
      path: 'overview',
      name: 'EffProjectOverview',
      component: () => import('@/views/pms/efficiency/project/overview.vue'),
      meta: { title: '项目概览' }
    },
    {
      path: 'phases',
      name: 'EffProjectPhases',
      component: () => import('@/views/pms/efficiency/project/phase/setup.vue'),
      meta: { title: '阶段配置', permission: 'pms:efficiency:project:phase:list' }
    },
    {
      path: 'documents',
      name: 'EffProjectDocuments',
      component: () => import('@/views/pms/efficiency/project/document/index.vue'),
      meta: { title: '文档管理', permission: 'pms:efficiency:project:document:list' }
    },
    {
      path: 'tasks',
      name: 'EffProjectTasks',
      component: () => import('@/views/pms/efficiency/task/index.vue'),
      meta: { title: '任务管理', permission: 'pms:efficiency:task:list' }
    },
    {
      path: 'milestones',
      name: 'EffProjectMilestones',
      component: () => import('@/views/pms/efficiency/project/milestone/index.vue'),
      meta: { title: '里程碑跟踪', permission: 'pms:efficiency:project:milestone:list' }
    },
    {
      path: 'task-generation',
      name: 'EffTaskGeneration',
      component: () => import('@/views/pms/efficiency/project/task-generation/index.vue'),
      meta: { title: '任务生成', permission: 'pms:efficiency:task-generation:list' }
    }
  ]
}
```

---

## 四、权限简化方案

### 4.1 简化前(30+权限)

```
pms:efficiency:project:phase:list
pms:efficiency:project:phase:add
pms:efficiency:project:phase:edit
pms:efficiency:project:phase:delete
pms:efficiency:project:document:list
pms:efficiency:project:document:upload
pms:efficiency:project:document:download
pms:efficiency:project:document:approve
pms:efficiency:project:document:delete
pms:efficiency:task-generation:list
pms:efficiency:task-generation:upload
pms:efficiency:task-generation:preview
pms:efficiency:task-generation:approve
... (还有20多个)
```

### 4.2 简化后(5核心权限)

```
1. pms:efficiency:project:manage      - 项目配置管理(含阶段/里程碑)
2. pms:efficiency:document:manage     - 文档管理(含上传/审批)
3. pms:efficiency:task:manage         - 任务管理(含生成/分配)
4. pms:efficiency:report:submit       - 日报填写
5. pms:efficiency:report:approve      - 日报审核
```

### 4.3 角色权限映射

| 角色 | 权限 |
|------|------|
| PM | 全部5个权限 |
| 部门经理 | 全部5个权限 |
| 员工 | report:submit |

---

## 五、实施计划

### Day 1: Vuex状态管理
- [ ] 创建 `store/modules/projectContext.js`
- [ ] 实现state/getters/mutations/actions
- [ ] 在 `store/index.js` 注册模块
- [ ] 测试状态加载和更新

### Day 2: 项目外壳重构
- [ ] 移除 `project/index.vue` 中的重复项目选择器
- [ ] 使用 `beforeEnter` 路由守卫加载项目上下文
- [ ] 修改子页面从 Vuex 读取 projectId
- [ ] 测试路由跳转和数据流

### Day 3: 阶段配置 + 里程碑
- [ ] 重构 `phase/setup.vue` 使用 Vuex
- [ ] 实现里程碑完成逻辑
- [ ] 添加文档要求检查
- [ ] 测试阶段状态更新

### Day 4: 任务模板 + 日报集成
- [ ] 实现 Excel 模板上传和解析
- [ ] 创建任务预览审核页面
- [ ] 修改日报表单添加临时任务创建
- [ ] 测试任务生成流程

### Day 5: 测试和优化
- [ ] 端到端测试完整流程
- [ ] 修复发现的bug
- [ ] 性能优化(减少API调用)
- [ ] 更新文档

---

## 六、验收标准

### 功能验收
- [ ] PM可以配置7个标准阶段
- [ ] 上传文档后可以审批
- [ ] 里程碑完成后阻塞下一阶段
- [ ] Excel模板可以正确解析
- [ ] 日报必须关联任务才能提交
- [ ] 临时任务可以快速创建

### 技术验收
- [ ] 所有子页面从 Vuex 读取 projectId
- [ ] 无重复的项目选择器
- [ ] 路由守卫正确加载数据
- [ ] API调用次数优化(并行加载)
- [ ] 权限控制正确(5个核心权限)

### 性能验收
- [ ] 项目详情页加载时间 < 2秒
- [ ] 阶段切换响应时间 < 500ms
- [ ] 文档列表加载时间 < 1秒

---

## 七、风险与注意事项

### 技术风险
1. **Vuex状态丢失** - 页面刷新后状态会丢失
   - **解决:** 使用 `vuex-persistedstate` 插件持久化

2. **路由守卫性能** - 每次进入子路由都重新加载
   - **解决:** 检查 `state.currentProject.projectId` 是否匹配,避免重复加载

3. **大文件上传超时** - Excel模板可能很大
   - **解决:** 设置 Axios timeout 为 60s,显示上传进度

### 业务风险
1. **里程碑定义不清** - PM可能不理解里程碑概念
   - **解决:** 提供默认里程碑模板,添加帮助文档

2. **任务模板格式不统一** - 不同PM上传的Excel格式不同
   - **解决:** 提供标准模板下载,添加格式校验

---

## 八、后续优化方向

1. **甘特图集成** - 在项目概览页显示阶段和任务的甘特图
2. **智能提醒** - 里程碑到期前3天提醒PM
3. **模板库** - 预置常用项目类型的阶段和任务模板
4. **批量操作** - 支持批量分配任务、批量审批文档

---

**设计完成日期:** 2026-01-30
**预计实施周期:** 5个工作日
**设计负责人:** Claude Code
