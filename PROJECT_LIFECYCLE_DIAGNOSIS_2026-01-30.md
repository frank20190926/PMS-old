# 项目生命周期模块问题诊断报告

**诊断时间:** 2026-01-30
**诊断范围:** 项目详情页面 `/efficiency/project/:projectId` 及其子页面
**用户反馈:** "项目生命周期内功能有很严重的问题"

---

## 📊 当前模块结构

### 项目详情页面 Shell (index.vue)

**左侧菜单结构:**
```
项目详情
├── 项目概览
├── 任务管理
├── 甘特图
├── 项目生命周期 (子菜单)
│   ├── 阶段配置
│   ├── 文档管理
│   ├── 任务生成
│   └── 流程仪表
└── 日报/周报 (子菜单)
    ├── 日报管理
    └── 周报管理
```

### 权限控制
每个菜单项都有独立的权限检查：
- `pms:efficiency:dashboard:view` - 项目概览
- `pms:efficiency:task:list` - 任务管理
- `pms:efficiency:gantt:view` - 甘特图
- `pms:efficiency:project:phase:list` - 阶段配置
- `pms:efficiency:project:document:list` - 文档管理
- `pms:efficiency:task-generation:list` - 任务生成
- `pms:efficiency:project:workflow:query` - 流程仪表
- `pms:efficiency:daily-report:list` - 日报管理
- `pms:efficiency:weekly-report:list` - 周报管理

---

## ⚠️ 发现的问题

### 问题1: 项目选择器重复 ❌

**问题描述:**
所有生命周期子页面都包含独立的项目选择器：

```vue
<!-- 阶段配置页面 -->
<el-select v-model="selectedProjectId" @change="handleProjectChange">
  <el-option v-for="project in projectList" ...></el-option>
</el-select>

<!-- 文档管理页面 -->
<el-select v-model="selectedProjectId" @change="handleProjectChange">
  <el-option v-for="project in projectList" ...></el-option>
</el-select>

<!-- 流程仪表页面 -->
<el-select v-model="selectedProjectId" @change="handleProjectChange">
  <el-option v-for="project in projectList" ...></el-option>
</el-select>
```

**问题影响:**
- ❌ 用户体验混乱：已经��项目列表选择了项目，进入详情后还要再选一次
- ❌ 状态不一致：Shell页面的 `projectId` 和子页面的 `selectedProjectId` 可能不同步
- ❌ 重复代码：每个子页面都要维护 `projectList` 和 `handleProjectChange`
- ❌ 数据冗余：多个页面重复请求项目列表

### 问题2: projectId 传递混乱 ❌

**当前传递方式:**
1. **Route Params:** `/efficiency/project/:projectId`
2. **Query String:** `?projectId=xxx`
3. **SessionStorage:** `sessionStorage.getItem('effProjectId')`
4. **组件内部状态:** `selectedProjectId` (各子页面独立)

**问题影响:**
- ❌ 多种数据源导致优先级不明确
- ❌ SessionStorage 污染全局状态
- ❌ 刷新页面可能丢失 projectId
- ❌ 子页面无法可靠获取当前项目

### 问题3: 业务流程不清晰 ❌

**当前流程:**
```
阶段配置 → 手动保存 → 手动生成任务
    ↓
文档管理 → 上传 → 审批 → ???
    ↓
任务生成 → 预览 → 批准 → ???
    ↓
流程仪表 → 只读查看 → 无操作
```

**问题分析:**
- ❌ **阶段配置** 和 **任务生成** 之间的关系不清楚
- ❌ **文档审批** 后应该自动触发什么？（代码注释说触发任务生成，但未验证）
- ❌ **任务生成预览** 批准后，任务是否自动创建到 `eff_task` 表？
- ❌ **流程仪表** 只是查看，无法推进流程

### 问题4: 数据同步问题 ❌

**表关系:**
```
eff_project_phase (阶段配置)
    ↓ (关联不明确)
eff_task (任务)
    ↓ (手动关联？)
eff_document (文档)
    ↓ (事件触发？)
eff_task_generation_rule (任务生成规则)
    ↓
eff_task_generation_preview (任务预览)
```

**问题影响:**
- ❌ 阶段配置保存后，是否创建了对应的里程碑任务？
- ❌ 文档审批通过后，DocumentApprovedEvent 是否正确触发？
- ❌ 任务生成预览批准后，预览数据如何转为正式任务？
- ❌ 各模块数据不一致时如何处理？

### 问题5: UI交互问题 ❌

**阶段配置页面:**
- ❌ 模板类型切换时，现有数据是否会丢失？
- ❌ "保存配置" 和 "生成阶段任务" 两个按钮职责不清
- ❌ 拖拽排序功能未实现（只有图标，无逻辑）

**文档管理页面:**
- �� 上传文档需要先选择项目（但已经在项目详情页了）
- ❌ "上传新版本" 按钮逻辑未实现
- ❌ 文档审批流程只有按钮，无审批记录展示

**任务生成页面:**
- ❌ 直接是 `<task-generation-preview />` 组件，缺少说明
- ❌ 用户不知道如何触发任务生成

**流程仪表页面:**
- ❌ 数据只读，无任何交互
- ❌ "下一步操作" 提示无法点击执行

### 问题6: 权限粒度过细 ❌

**当前权限:**
```
pms:efficiency:project:phase:list       - 查看阶段
pms:efficiency:project:phase:add        - 添加阶段
pms:efficiency:project:phase:edit       - 编辑阶段
pms:efficiency:project:document:list    - 查看文档
pms:efficiency:project:document:upload  - 上传文档
pms:efficiency:project:document:approve - 审批文档
... (30+ 个权限点)
```

**问题影响:**
- ❌ 权限配置复杂，难以维护
- ❌ 用户看到页面但按钮被禁用，体验差
- ❌ PM角色应该有完整的项目生命周期管理权限，但拆分过细导致配置困难

---

## 🔍 根本原因分析

### 1. 设计缺陷
- **项目维度不明确**: Shell 页面已���确定了项目，子页面不应该再有项目选择器
- **流程割裂**: 各个模块独立开发，缺少统一的业务流程设计

### 2. 状态管理混乱
- **多数据源**: Route + Query + SessionStorage + 组件状态
- **无统一Store**: 未使用 Vuex 管理项目上下文
- **Props缺失**: Shell → 子组件未通过 Props 传递 projectId

### 3. 业务逻辑不完整
- **手动触发**: 阶段配置 → 任务生成需要手动操作
- **事件未验证**: 文档审批 → 任务生成的自动化流程未测试
- **状态机缺失**: 项目生命周期应该有明确的状态机，当前只有零散的状态标签

---

## 💡 建议的解决方案

### 方案A: 最小化修复（2天）

**目标**: 修复最严重的问题��保持现有结构

1. **移除子页面的项目选择器**
   - 从 Route Params 读取 projectId
   - 移除 SessionStorage 依赖
   - 统一数据源

2. **修复数据传递**
   - Shell 页面通过 `provide` 传递 projectId
   - 子页面通过 `inject` 接收
   - 去除重复的项目列表请求

3. **完善交互提示**
   - 添加操作说明文本
   - 明确按钮的作用
   - 添加操作确认对话框

**优点**: 快速见效，风险低
**缺点**: 未解决业务流程混乱问题

### 方案B: 重构项目生命周期（5天）

**目标**: 重新设计业务流程，统一状态管理

1. **建立项目上下文管理**
   ```javascript
   // store/modules/projectContext.js
   state: {
     currentProject: null,
     currentPhase: null,
     workflow: null
   }
   ```

2. **设计清晰的业务流程**
   ```
   项目启动 → 配置阶段 → 阶段执行 → 阶段完成
        ↓            ↓          ↓          ↓
      创建项目    上传需求    开发任务    验收文档
   ```

3. **统一页面结构**
   - 移除子页面项目选择器
   - 使用面包屑导航
   - 流程步骤条展示当前位置

4. **完善自动化流程**
   - 阶段配置保存后自动创建里程碑任务
   - 文档审批通过后自动生成下一阶段任务
   - 流程仪表显示可操作的下一步按钮

**优点**: 彻底解决问题，用户体验好
**缺点**: 工作量大，需要详细设计

### 方案C: 简化生命周期模块（3天）

**目标**: 保留核心功能，移除复杂流程

1. **精简菜单**
   ```
   项目详情
   ├── 概览
   ├── 任务
   ├── 甘特图
   ├── 文档
   └── 报告
   ```

2. **移除的模块**
   - ❌ 阶段配置（并入项目概览）
   - ❌ 任务生成（自动化，不需要页面）
   - ❌ 流程仪表（功能重复）

3. **保留的模块**
   - ✅ 文档管理（简化审批流程）
   - ✅ 任务管理（增强功能）
   - ✅ 日报周报（保持不变）

**优点**: 降低复杂度，聚焦核心功能
**缺点**: 丢失部分功能，需要评估业务影响

---

## 📋 推荐方案

**推荐: 方案A + 方案C 混合**

**阶段1 (1天): 紧急修复**
- 移除所有子页面的项目选择器
- 统一 projectId 传递方式
- 修复最明显的交互问题

**阶段2 (2天): 功能精简**
- 评估各模块使用频率
- 移除低价值模块
- 合并重复功能

**阶段3 (2天): 体验优化**
- 添加操作引导
- 完善错误提示
- 统一视觉风格

**总工期: 5天**

---

## 🎯 下一步行动

1. **用户确认**
   - 确认当前最严重的问题
   - 确认是否可以移除某些功能
   - 确认期望的完成时间

2. **制定详细计划**
   - 分解任务
   - 评估风险
   - 确定验收标准

3. **执行修复**
   - 创建新分支
   - 逐模块修复
   - 单元测试 + E2E测试

**是否开始执行修复？请确认选择的方案。**

