# 人效中心项目详情壳页面设计（项目内菜单）

## 目标
- 以“项目”为主入口组织人效中心功能，降低顶层菜单复杂度。
- 项目内菜单随单条项目记录走：任务、甘特、生命周期、日报/周报等均基于 projectId。
- PM 只看自己负责项目；管理员/部门负责人可看全部（后端统一控制）。

## 信息架构
### 顶层菜单（全局入口）
- 项目列表（主入口）
- 任务管理（全项目视角）
- 日报 / 周报（全项目视角）
- PM 工作台（全局仪表盘）
- 看板 / 数据同步 / 甘特图（保留全局入口）

### 项目详情壳（项目内入口）
路由：`/efficiency/project/:projectId`

左侧项目内菜单：
- 项目概览（默认页，项目维度 PM 工作台）
- 任务管理（项目维度）
- 甘特图（项目维度）
- 项目生命周期
  - 阶段配置
  - 文档管理
  - 任务生成
  - 流程仪表
- 日报/周报（项目维度）

## 路由结构建议
- `/efficiency/projects` → 项目列表
- `/efficiency/project/:projectId` → 项目概览
- `/efficiency/project/:projectId/tasks`
- `/efficiency/project/:projectId/gantt`
- `/efficiency/project/:projectId/lifecycle/phases`
- `/efficiency/project/:projectId/lifecycle/documents`
- `/efficiency/project/:projectId/lifecycle/task-gen`
- `/efficiency/project/:projectId/lifecycle/flow`
- `/efficiency/project/:projectId/reports`

## 数据与权限
- 项目列表统一走 `/pms/efficiency/project/common/my-projects`。
- 后端根据角色数据范围返回项目：
  - PM：仅自己负责项目（user_id = 当前用户）。
  - 管理员/部门负责人：全部或数据范围内项目。
- 项目内页面所有接口均带 `projectId`。

## 页面结构与交互
- 顶部信息条固定显示项目名称、编号、负责人、状态，提供“返回项目列表”入口。
- 左侧菜单与路由联动，右侧内容区复用现有页面。
- 统一在壳页面解析 `projectId`，存入 store，子页面优先从 store 读取。

## 错误处理
- 项目不存在/无权限：壳页面统一提示并返回项目列表。
- 子页面仅处理业务级错误（保存失败等）。

## 测试与验证
- 项目列表 → 进入项目 → 菜单切换（任务/阶段/文档/日报）。
- 直接访问项目子路由（例如 `/efficiency/project/1/tasks`）。
- 无权限或不存在的 projectId。
