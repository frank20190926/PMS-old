# 项目详情功能增强 Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 实现项目详情的完整功能，包括 Vuex 状态管理、路由守卫、项目概览页面和临时任务创建

**Architecture:** 使用 Vuex 统一管理项目上下文，通过路由守卫预加载数据，优化项目概览页面展示项目进度和统计信息，增强日报表单支持快速创建临时任务

**Tech Stack:** Vue2, Vuex, Vue Router, Element UI, Axios

---

## Task 1: 创建 Vuex projectContext 模块

**Files:**
- Create: `kml-pms-v2-vue/src/store/modules/projectContext.js`
- Modify: `kml-pms-v2-vue/src/store/index.js`

**Step 1: 创建 projectContext 状态模块**

在 `src/store/modules/projectContext.js` 创建完整的状态管理模块：

```javascript
import { getProject } from '@/api/pms/project'
import { listPhase } from '@/api/pms/efficiency/projectPhase'
import { listTask } from '@/api/pms/efficiency/task'
import { listDocument } from '@/api/pms/efficiency/projectDocument'

const state = {
  // 当前项目基本信息
  currentProject: {
    projectId: null,
    projectTitle: '',
    projectSn: '',
    projectStatus: '',
    pmUserId: null,
    pmUserName: '',
    startDate: null,
    endDate: null
  },

  // 项目阶段列表
  projectPhases: [],

  // 项目任务列表
  projectTasks: [],

  // 项目文档列表（按阶段分组）
  projectDocuments: {
    REQUIREMENT: [],
    DESIGN: [],
    DEVELOPMENT: [],
    TESTING: [],
    DEPLOYMENT: []
  },

  // 权限缓存
  permissions: {
    canEditPhase: false,
    canUploadDoc: false,
    canApproveDoc: false,
    canGenerateTask: false,
    canAssignTask: false
  },

  // 加载状态
  loading: false,

  // 最后加载时间
  lastLoadTime: null
}

const getters = {
  // 当前项目ID
  projectId: state => state.currentProject.projectId,

  // 项目整体进度（已完成阶段/总阶段数）
  projectProgress: state => {
    const total = state.projectPhases.length
    if (total === 0) return 0
    const completed = state.projectPhases.filter(p => p.status === 'COMPLETED').length
    return Math.round((completed / total) * 100)
  },

  // 当前进行中的阶段
  currentPhase: state => {
    return state.projectPhases.find(p => p.status === 'IN_PROGRESS') || null
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
  },

  // 待审批文档数量
  pendingDocsCount: state => {
    let count = 0
    Object.values(state.projectDocuments).forEach(docs => {
      count += docs.filter(d => d.approvalStatus === 'PENDING').length
    })
    return count
  },

  // 是否已加载项目数据
  isProjectLoaded: state => {
    return state.currentProject.projectId !== null && state.lastLoadTime !== null
  }
}

const mutations = {
  SET_PROJECT(state, project) {
    state.currentProject = project
  },

  SET_PHASES(state, phases) {
    state.projectPhases = phases || []
  },

  SET_TASKS(state, tasks) {
    state.projectTasks = tasks || []
  },

  SET_DOCUMENTS(state, { phaseType, documents }) {
    if (state.projectDocuments[phaseType] !== undefined) {
      state.projectDocuments[phaseType] = documents || []
    }
  },

  SET_PERMISSIONS(state, permissions) {
    state.permissions = { ...state.permissions, ...permissions }
  },

  SET_LOADING(state, loading) {
    state.loading = loading
  },

  SET_LOAD_TIME(state, time) {
    state.lastLoadTime = time
  },

  UPDATE_PHASE_STATUS(state, { phaseId, status }) {
    const phase = state.projectPhases.find(p => p.phaseId === phaseId)
    if (phase) {
      phase.status = status
    }
  },

  ADD_TASK(state, task) {
    state.projectTasks.push(task)
  },

  UPDATE_TASK(state, { taskId, updates }) {
    const task = state.projectTasks.find(t => t.taskId === taskId)
    if (task) {
      Object.assign(task, updates)
    }
  },

  CLEAR_PROJECT(state) {
    state.currentProject = {
      projectId: null,
      projectTitle: '',
      projectSn: '',
      projectStatus: '',
      pmUserId: null,
      pmUserName: '',
      startDate: null,
      endDate: null
    }
    state.projectPhases = []
    state.projectTasks = []
    state.projectDocuments = {
      REQUIREMENT: [],
      DESIGN: [],
      DEVELOPMENT: [],
      TESTING: [],
      DEPLOYMENT: []
    }
    state.lastLoadTime = null
  }
}

const actions = {
  // 加载项目完整上下文（并行加载）
  async loadProjectContext({ commit, state }, projectId) {
    // 如果已加载且是同一项目，且加载时间在5分钟内，跳过
    if (
      state.currentProject.projectId === projectId &&
      state.lastLoadTime &&
      Date.now() - state.lastLoadTime < 5 * 60 * 1000
    ) {
      return { success: true, cached: true }
    }

    commit('SET_LOADING', true)

    try {
      // 并行加载项目基本信息、阶段、任务
      const [projectRes, phasesRes, tasksRes] = await Promise.all([
        getProject(projectId),
        listPhase({ projectId }).catch(() => ({ rows: [] })),
        listTask({ projectId }).catch(() => ({ rows: [] }))
      ])

      if (projectRes.code !== 200) {
        throw new Error(projectRes.msg || '加载项目信息失败')
      }

      commit('SET_PROJECT', projectRes.data)
      commit('SET_PHASES', phasesRes.rows)
      commit('SET_TASKS', tasksRes.rows)
      commit('SET_LOAD_TIME', Date.now())

      // 加载文档（可选，后台加载）
      const phaseTypes = ['REQUIREMENT', 'DESIGN', 'DEVELOPMENT', 'TESTING', 'DEPLOYMENT']
      Promise.all(
        phaseTypes.map(async type => {
          try {
            const docsRes = await listDocument({ projectId, phaseType: type })
            commit('SET_DOCUMENTS', { phaseType: type, documents: docsRes.rows || [] })
          } catch (e) {
            console.warn(`加载 ${type} 文档失败:`, e)
          }
        })
      )

      return { success: true, cached: false }
    } catch (error) {
      console.error('加载项目上下文失败:', error)
      return { success: false, error: error.message }
    } finally {
      commit('SET_LOADING', false)
    }
  },

  // 刷新项目数据（强制重新加载）
  async refreshProjectContext({ commit, state }) {
    const projectId = state.currentProject.projectId
    if (!projectId) return { success: false, error: '无项目ID' }

    // 清除加载时间，强制重新加载
    commit('SET_LOAD_TIME', null)
    return await this.dispatch('projectContext/loadProjectContext', projectId)
  },

  // 清除项目上下文
  clearProjectContext({ commit }) {
    commit('CLEAR_PROJECT')
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

**Step 2: 在 store/index.js 注册模块**

修改 `src/store/index.js`，添加 projectContext 模块：

```javascript
import projectContext from './modules/projectContext'

const store = new Vuex.Store({
  modules: {
    // ... 其他模块
    projectContext
  },
  // ... 其他配置
})
```

**Step 3: 手动验证**

在浏览器控制台测试：
```javascript
// 加载项目
this.$store.dispatch('projectContext/loadProjectContext', 1)

// 查看项目信息
this.$store.getters['projectContext/projectId']
this.$store.getters['projectContext/projectProgress']
this.$store.getters['projectContext/taskStats']
```

**Step 4: 提交**

```bash
git add src/store/modules/projectContext.js src/store/index.js
git commit -m "feat: add Vuex projectContext module for project state management"
```

---

## Task 2: 添加路由守卫自动加载项目上下文

**Files:**
- Modify: `kml-pms-v2-vue/src/router/index.js`

**Step 1: 检查当前路由配置**

查看 `src/router/index.js` 中 `/efficiency/project/:projectId` 路由的配置

**Step 2: 添加 beforeEnter 路由守卫**

在项目详情壳路由中添加 beforeEnter 守卫：

```javascript
import store from '@/store'
import { Message } from 'element-ui'

// 在 dynamicRoutes 中找到 /efficiency 路由，修改 project/:projectId 子路由
{
  path: 'project/:projectId',
  component: () => import('@/views/pms/efficiency/project/index'),
  name: 'EfficiencyProjectShell',
  meta: { title: '项目详情' },

  // 添加路由守卫
  beforeEnter: async (to, from, next) => {
    const projectId = to.params.projectId

    if (!projectId) {
      Message.warning('缺少项目ID')
      next('/efficiency/projects')
      return
    }

    // 加载项目上下文到 Vuex
    const result = await store.dispatch('projectContext/loadProjectContext', projectId)

    if (result.success) {
      // 成功加载，继续导航
      if (result.cached) {
        console.log('使用缓存的项目数据')
      }
      next()
    } else {
      // 加载失败，返回项目列表
      Message.error(result.error || '加载项目信息失败')
      next('/efficiency/projects')
    }
  },

  children: [
    // ... 原有的子路由配置
  ]
}
```

**Step 3: 手动验证**

1. 访问 http://localhost:1024/efficiency/projects
2. 点击"进入项目"
3. 观察浏览器控制台，应该看到项目数据加载日志
4. 检查 Vuex DevTools，确认 projectContext 模块有数据

**Step 4: 提交**

```bash
git add src/router/index.js
git commit -m "feat: add route guard to auto-load project context"
```

---

## Task 3: 重构项目概览页面

**Files:**
- Modify: `kml-pms-v2-vue/src/views/pms/efficiency/dashboard/index.vue`

**Step 1: 修改页面从 Vuex 读取数据**

重构 `dashboard/index.vue`，移除重复的项目选择器，从 Vuex 读取数据：

```vue
<template>
  <div class="project-overview">
    <el-card shadow="never">
      <div slot="header">
        <span>项目概览</span>
        <el-button style="float: right" size="small" icon="el-icon-refresh" @click="refreshData">刷新</el-button>
      </div>

      <!-- 项目基本信息 -->
      <el-descriptions :column="3" border class="mb20">
        <el-descriptions-item label="项目名称">{{ project.projectTitle || '-' }}</el-descriptions-item>
        <el-descriptions-item label="项目编号">{{ project.projectSn || '-' }}</el-descriptions-item>
        <el-descriptions-item label="项目状态">
          <dict-tag :options="dict.type.pms_project_status" :value="project.projectStatus" />
        </el-descriptions-item>
        <el-descriptions-item label="项目经理">{{ project.pmUserName || '-' }}</el-descriptions-item>
        <el-descriptions-item label="开始日期">{{ project.startDate || '-' }}</el-descriptions-item>
        <el-descriptions-item label="结束日期">{{ project.endDate || '-' }}</el-descriptions-item>
      </el-descriptions>

      <!-- 项目进度 -->
      <el-row :gutter="20" class="mb20">
        <el-col :span="24">
          <div class="progress-card">
            <div class="progress-label">项目整体进度</div>
            <el-progress :percentage="projectProgress" :stroke-width="20" :text-inside="true" status="success"></el-progress>
            <div class="progress-info">
              已完成 {{ completedPhasesCount }}/{{ totalPhasesCount }} 个阶段
              <span v-if="currentPhase" class="current-phase">
                (当前: {{ currentPhase.phaseName }})
              </span>
            </div>
          </div>
        </el-col>
      </el-row>

      <!-- 统计卡片 -->
      <el-row :gutter="20" class="mb20">
        <el-col :span="6">
          <el-card class="stat-card">
            <div class="stat-value">{{ taskStats.total }}</div>
            <div class="stat-label">总任务数</div>
          </el-card>
        </el-col>
        <el-col :span="6">
          <el-card class="stat-card stat-pending">
            <div class="stat-value">{{ taskStats.pending }}</div>
            <div class="stat-label">待处理</div>
          </el-card>
        </el-col>
        <el-col :span="6">
          <el-card class="stat-card stat-progress">
            <div class="stat-value">{{ taskStats.inProgress }}</div>
            <div class="stat-label">进行中</div>
          </el-card>
        </el-col>
        <el-col :span="6">
          <el-card class="stat-card stat-completed">
            <div class="stat-value">{{ taskStats.completed }}</div>
            <div class="stat-label">已完成</div>
          </el-card>
        </el-col>
      </el-row>

      <!-- 阶段列表 -->
      <el-card shadow="never" class="mb20">
        <div slot="header">项目阶段</div>
        <el-table :data="phases" border>
          <el-table-column label="序号" type="index" width="60"></el-table-column>
          <el-table-column label="阶段名称" prop="phaseName"></el-table-column>
          <el-table-column label="阶段类型" prop="phaseType" width="120">
            <template slot-scope="scope">
              <el-tag>{{ getPhaseTypeLabel(scope.row.phaseType) }}</el-tag>
            </template>
          </el-table-column>
          <el-table-column label="负责人" prop="assigneeName" width="120"></el-table-column>
          <el-table-column label="开始日期" prop="startDate" width="120"></el-table-column>
          <el-table-column label="结束日期" prop="endDate" width="120"></el-table-column>
          <el-table-column label="状态" prop="status" width="100">
            <template slot-scope="scope">
              <el-tag :type="getPhaseStatusType(scope.row.status)">
                {{ getPhaseStatusLabel(scope.row.status) }}
              </el-tag>
            </template>
          </el-table-column>
        </el-table>
      </el-card>

      <!-- 待办事项 -->
      <el-card shadow="never">
        <div slot="header">待办事项</div>
        <el-alert v-if="taskStats.delayed > 0" type="error" :closable="false" class="mb10">
          有 {{ taskStats.delayed }} 个任务已延误，请及时处理
        </el-alert>
        <el-alert v-if="pendingDocsCount > 0" type="warning" :closable="false" class="mb10">
          有 {{ pendingDocsCount }} 个文档待审批
        </el-alert>
        <el-empty v-if="taskStats.delayed === 0 && pendingDocsCount === 0" description="暂无待办事项"></el-empty>
      </el-card>
    </el-card>
  </div>
</template>

<script>
import { mapState, mapGetters } from 'vuex'

export default {
  name: 'ProjectOverview',
  dicts: ['pms_project_status'],

  computed: {
    ...mapState('projectContext', {
      project: state => state.currentProject,
      phases: state => state.projectPhases,
      loading: state => state.loading
    }),

    ...mapGetters('projectContext', [
      'projectId',
      'projectProgress',
      'currentPhase',
      'taskStats',
      'pendingDocsCount'
    ]),

    totalPhasesCount() {
      return this.phases.length
    },

    completedPhasesCount() {
      return this.phases.filter(p => p.status === 'COMPLETED').length
    }
  },

  methods: {
    async refreshData() {
      const result = await this.$store.dispatch('projectContext/refreshProjectContext')
      if (result.success) {
        this.$message.success('刷新成功')
      } else {
        this.$message.error(result.error || '刷新失败')
      }
    },

    getPhaseTypeLabel(type) {
      const labels = {
        'REQUIREMENT': '需求',
        'DESIGN': '设计',
        'DEVELOPMENT': '开发',
        'TESTING': '测试',
        'DEPLOYMENT': '部署'
      }
      return labels[type] || type
    },

    getPhaseStatusLabel(status) {
      const labels = {
        'NOT_STARTED': '未开始',
        'IN_PROGRESS': '进行中',
        'COMPLETED': '已完成'
      }
      return labels[status] || status
    },

    getPhaseStatusType(status) {
      const types = {
        'NOT_STARTED': 'info',
        'IN_PROGRESS': 'warning',
        'COMPLETED': 'success'
      }
      return types[status] || 'info'
    }
  }
}
</script>

<style scoped>
.mb10 {
  margin-bottom: 10px;
}

.mb20 {
  margin-bottom: 20px;
}

.progress-card {
  padding: 20px;
  background: #f5f7fa;
  border-radius: 4px;
}

.progress-label {
  font-size: 16px;
  font-weight: bold;
  margin-bottom: 15px;
}

.progress-info {
  margin-top: 10px;
  color: #606266;
  font-size: 14px;
}

.current-phase {
  color: #409EFF;
  font-weight: bold;
}

.stat-card {
  text-align: center;
  padding: 20px 0;
}

.stat-value {
  font-size: 32px;
  font-weight: bold;
  color: #303133;
}

.stat-label {
  font-size: 14px;
  color: #909399;
  margin-top: 10px;
}

.stat-pending .stat-value {
  color: #E6A23C;
}

.stat-progress .stat-value {
  color: #409EFF;
}

.stat-completed .stat-value {
  color: #67C23A;
}
</style>
```

**Step 2: 手动验证**

1. 访问项目概览页面
2. 检查是否显示项目信息、进度、统计数据
3. 点击刷新按钮，验证数据重新加载
4. 检查控制台无错误

**Step 3: 提交**

```bash
git add src/views/pms/efficiency/dashboard/index.vue
git commit -m "feat: refactor project overview page to use Vuex state"
```

---

## Task 4: 日报表单添加临时任务快速创建

**Files:**
- Modify: `kml-pms-v2-vue/src/views/pms/efficiency/daily-report/index.vue`
- Create: `kml-pms-v2-vue/src/views/pms/efficiency/daily-report/components/QuickTaskDialog.vue`

**Step 1: 创建临时任务快速创建对话框组件**

创建 `src/views/pms/efficiency/daily-report/components/QuickTaskDialog.vue`：

```vue
<template>
  <el-dialog
    title="快速创建临时任务"
    :visible.sync="dialogVisible"
    width="500px"
    @close="handleClose"
  >
    <el-form ref="form" :model="form" :rules="rules" label-width="100px">
      <el-form-item label="任务名称" prop="taskName">
        <el-input v-model="form.taskName" placeholder="请输入任务名称"></el-input>
      </el-form-item>

      <el-form-item label="任务类型" prop="taskType">
        <el-select v-model="form.taskType" placeholder="请选择任务类型" style="width: 100%">
          <el-option label="临时开发任务" value="TEMPORARY"></el-option>
          <el-option label="会议沟通" value="MANAGEMENT"></el-option>
          <el-option label="学习培训" value="TRAINING"></el-option>
        </el-select>
      </el-form-item>

      <el-form-item label="预估工时" prop="estimatedHours">
        <el-input-number
          v-model="form.estimatedHours"
          :min="0.5"
          :max="16"
          :step="0.5"
          placeholder="单位：小时"
          style="width: 100%"
        ></el-input-number>
      </el-form-item>

      <el-form-item label="任务说明">
        <el-input
          v-model="form.description"
          type="textarea"
          :rows="3"
          placeholder="简要说明任务内容（可选）"
        ></el-input>
      </el-form-item>
    </el-form>

    <span slot="footer">
      <el-button @click="handleClose">取消</el-button>
      <el-button type="primary" :loading="submitting" @click="handleSubmit">创建并关联</el-button>
    </span>
  </el-dialog>
</template>

<script>
import { addTask } from '@/api/pms/efficiency/task'

export default {
  name: 'QuickTaskDialog',

  props: {
    visible: {
      type: Boolean,
      default: false
    },
    projectId: {
      type: [String, Number],
      required: true
    }
  },

  data() {
    return {
      form: {
        taskName: '',
        taskType: 'TEMPORARY',
        estimatedHours: 1,
        description: ''
      },

      rules: {
        taskName: [
          { required: true, message: '请输入任务名称', trigger: 'blur' },
          { min: 2, max: 100, message: '长度在 2 到 100 个字符', trigger: 'blur' }
        ],
        taskType: [
          { required: true, message: '请选择任务类型', trigger: 'change' }
        ],
        estimatedHours: [
          { required: true, message: '请输入预估工时', trigger: 'blur' }
        ]
      },

      submitting: false
    }
  },

  computed: {
    dialogVisible: {
      get() {
        return this.visible
      },
      set(val) {
        this.$emit('update:visible', val)
      }
    }
  },

  methods: {
    handleClose() {
      this.$refs.form.resetFields()
      this.dialogVisible = false
    },

    handleSubmit() {
      this.$refs.form.validate(async valid => {
        if (!valid) return

        this.submitting = true

        try {
          const taskData = {
            projectId: this.projectId,
            name: this.form.taskName,
            taskType: this.form.taskType,
            estimatedHours: this.form.estimatedHours,
            description: this.form.description,
            status: 'PENDING',
            source: 'MANUAL'  // 标记为手动创建
          }

          const response = await addTask(taskData)

          if (response.code === 200) {
            this.$message.success('临时任务创建成功')
            this.$emit('task-created', response.data)
            this.handleClose()
          } else {
            this.$message.error(response.msg || '创建失败')
          }
        } catch (error) {
          console.error('创建临时任务失败:', error)
          this.$message.error('创建失败，请重试')
        } finally {
          this.submitting = false
        }
      })
    }
  }
}
</script>
```

**Step 2: 在日报表单中集成快速创建功能**

修改 `src/views/pms/efficiency/daily-report/index.vue`，在任务关联部分添加快速创建按钮：

```vue
<!-- 在任务关联表单项中添加 -->
<el-form-item label="关联任务" prop="taskIds" required>
  <div>
    <el-select
      v-model="form.taskIds"
      multiple
      filterable
      placeholder="请选择关联任务"
      style="width: calc(100% - 120px)"
    >
      <el-option
        v-for="task in taskList"
        :key="task.taskId"
        :label="task.name"
        :value="task.taskId"
      ></el-option>
    </el-select>
    <el-button
      type="primary"
      plain
      icon="el-icon-plus"
      style="margin-left: 10px"
      @click="showQuickTaskDialog"
    >
      快速创建
    </el-button>
  </div>
  <div class="form-tip">
    至少关联一个任务。如果是临时工作，可点击"快速创建"添加临时任务
  </div>
</el-form-item>

<!-- 在 script 中添加 -->
<script>
import QuickTaskDialog from './components/QuickTaskDialog'

export default {
  components: {
    QuickTaskDialog
  },

  data() {
    return {
      // ... 其他数据
      quickTaskDialogVisible: false
    }
  },

  computed: {
    projectId() {
      return this.$store.getters['projectContext/projectId']
    }
  },

  methods: {
    showQuickTaskDialog() {
      if (!this.projectId) {
        this.$message.warning('请先选择项目')
        return
      }
      this.quickTaskDialogVisible = true
    },

    handleTaskCreated(task) {
      // 任务创建成功后，添加到任务列表并自动选中
      this.taskList.push(task)
      this.form.taskIds.push(task.taskId)
      this.$message.success('任务已自动关联到日报')
    }
  }
}
</script>

<!-- 在 template 末尾添加对话框 -->
<quick-task-dialog
  :visible.sync="quickTaskDialogVisible"
  :project-id="projectId"
  @task-created="handleTaskCreated"
></quick-task-dialog>
```

**Step 3: 手动验证**

1. 访问日报填写页面
2. 点击"快速创建"按钮
3. 填写临时任务信息并提交
4. 验证任务是否自动关联到日报
5. 提交日报，检查是否成功

**Step 4: 提交**

```bash
git add src/views/pms/efficiency/daily-report/
git commit -m "feat: add quick task creation in daily report form"
```

---

## Task 5: 更新其他子页面从 Vuex 读取 projectId

**Files:**
- Modify: `kml-pms-v2-vue/src/views/pms/efficiency/task/index.vue`
- Modify: `kml-pms-v2-vue/src/views/pms/efficiency/gantt/index.vue`

**Step 1: 简化任务页面的 projectId 获取**

修改 `task/index.vue`，优先从 Vuex 读取：

```javascript
computed: {
  ...mapGetters('projectContext', ['projectId']),

  routeProjectId() {
    // 优先从 Vuex 读取，回退到路由参数
    return this.projectId || this.getRouteProjectId()
  }
},

created() {
  // 如果 Vuex 中有 projectId，使用它
  if (this.projectId) {
    this.queryParams.projectId = this.projectId
  } else {
    // 否则从路由读取（兼容直接访问）
    this.routeProjectId = this.getRouteProjectId()
    if (this.routeProjectId) {
      this.queryParams.projectId = this.routeProjectId
    }
  }
  this.getList()
  this.getProjectList()
  this.getUserList()
}
```

**Step 2: 简化甘特图页面**

同样的方式修改 `gantt/index.vue`

**Step 3: 手动验证**

1. 访问项目详情 → 任务管理
2. 验证任务列表自动过滤当前项目
3. 访问项目详情 → 甘特图
4. 验证甘特图显示当前项目数据

**Step 4: 提交**

```bash
git add src/views/pms/efficiency/task/index.vue src/views/pms/efficiency/gantt/index.vue
git commit -m "refactor: simplify projectId retrieval using Vuex"
```

---

## Task 6: 文档更新

**Files:**
- Modify: `CLAUDE.md`

**Step 1: 更新 CLAUDE.md 记录新功能**

在开发记录部分添加本次实现：

```markdown
### 2026-01-30 - 项目详情功能增强

**操作：** 实现项目详情的完整功能

**实现内容：**

| 功能 | 状态 | 说明 |
|------|------|------|
| Vuex projectContext | ✅ 完成 | 统一管理项目上下文状态 |
| 路由守卫自动加载 | ✅ 完成 | 进入项目详情自动加载数据 |
| 项目概览页面重构 | ✅ 完成 | 展示项目进度和统计信息 |
| 临时任务快速创建 | ✅ 完成 | 日报表单支持快速创建任务 |

**技术亮点：**
- Vuex 模块化状态管理，避免重复请求
- 路由守卫预加载数据，提升用户体验
- 并行加载优化，减少等待时间
- 缓存机制，5分钟内不重复加载

**验证清单：**
- [ ] 项目概览页面显示完整信息
- [ ] 任务统计数据正确
- [ ] 快速创建临时任务功能正常
- [ ] 页面切换无重复请求
```

**Step 2: 提交**

```bash
git add CLAUDE.md
git commit -m "docs: record project detail enhancement implementation"
```

---

## 执行说明

- 在 `kml-pms-v2-vue` 前端仓库中实现
- 每个任务独立提交
- 手动验证每个功能后再继续下一个任务
- 如遇到 API 不存在，需要先检查后端接口是否已实现

---

## 验收标准

### 功能验收
- [ ] Vuex projectContext 模块正常工作
- [ ] 进入项目详情自动加载数据
- [ ] 项目概览页面显示项目进度、统计、阶段列表
- [ ] 日报表单可以快速创建临时任务
- [ ] 所有子页面从 Vuex 读取 projectId

### 技术验收
- [ ] 无重复的项目选择器
- [ ] 路由守卫正确加载数据
- [ ] 5分钟内缓存有效，避免重复加载
- [ ] Vuex DevTools 可查看状态变化
- [ ] 无控制台错误

### 性能验收
- [ ] 项目详情页加载时间 < 2秒
- [ ] 页面切换响应时间 < 500ms
- [ ] 数据并行加载优化生效
