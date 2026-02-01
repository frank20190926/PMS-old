# API Specification

<!-- SCOPE: REST API specification for PMS project following OpenAPI 3.0 structure -->
<!-- NO_CODE_EXAMPLES: This document defines API contracts only - no controller implementations -->

## Overview

本文档定义 PMS 项目管理系统的 REST API 规范。

| 属性 | 值 |
|------|-----|
| 基础路径 | http://localhost:8090 |
| API 版本 | v1 |
| 认证方式 | JWT Bearer Token |
| 文档 | http://localhost:8090/swagger-ui/index.html |

---

## Authentication

### 认证方式

| 类型 | 说明 |
|------|------|
| Header | `Authorization: Bearer {token}` |
| Token 有效期 | 14400 分钟 (10 天) |
| 获取方式 | POST /login |

### 通用响应格式

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": { ... }
}
```

### 错误码

| 错误码 | 说明 |
|--------|------|
| 200 | 成功 |
| 401 | 未认证 |
| 403 | 无权限 |
| 500 | 服务器错误 |

---

## API Endpoints

### 1. 系统认证 (/login)

| 端点 | 方法 | 说明 | 权限 |
|------|------|------|------|
| /login | POST | 用户登录 | 公开 |
| /logout | POST | 用户登出 | 已认证 |
| /getInfo | GET | 获取用户信息 | 已认证 |
| /getRouters | GET | 获取路由菜单 | 已认证 |

---

### 2. 人效中心 - 任务管理 (/pms/efficiency/task)

| 端点 | 方法 | 说明 | 权限 |
|------|------|------|------|
| /pms/efficiency/task/list | GET | 查询任务列表 | pms:efficiency:task:list |
| /pms/efficiency/task/tree/{projectId} | GET | 获取任务树结构 | pms:efficiency:task:list |
| /pms/efficiency/task/my | GET | 获取我的任务 | pms:efficiency:task:list |
| /pms/efficiency/task/{id} | GET | 获取任务详情 | pms:efficiency:task:query |
| /pms/efficiency/task | POST | 创建任务 | pms:efficiency:task:add |
| /pms/efficiency/task | PUT | 更新任务 | pms:efficiency:task:edit |
| /pms/efficiency/task/status/{id}/{status} | PUT | 更新任务状态 | pms:efficiency:task:edit |
| /pms/efficiency/task/{ids} | DELETE | 删除任务 | pms:efficiency:task:remove |
| /pms/efficiency/task/export | POST | 导出任务 | pms:efficiency:task:export |

#### 任务状态枚举

| 值 | 说明 |
|----|------|
| PENDING | 待处理 |
| IN_PROGRESS | 进行中 |
| COMPLETED | 已完成 |
| DELAYED | 已延误 |

---

### 3. 人效中心 - 日报管理 (/pms/efficiency/daily-report)

| 端点 | 方法 | 说明 | 权限 |
|------|------|------|------|
| /pms/efficiency/daily-report/list | GET | 查询日报列表 | pms:efficiency:daily-report:list |
| /pms/efficiency/daily-report/my | GET | 获取我的日报 | pms:efficiency:daily-report:list |
| /pms/efficiency/daily-report/pending | GET | 获取待审核日报 | pms:efficiency:daily-report:approve |
| /pms/efficiency/daily-report/date/{date} | GET | 按日期查询日报 | pms:efficiency:daily-report:list |
| /pms/efficiency/daily-report/{id} | GET | 获取日报详情 | pms:efficiency:daily-report:query |
| /pms/efficiency/daily-report | POST | 创建日报 | pms:efficiency:daily-report:add |
| /pms/efficiency/daily-report | PUT | 更新日报 | pms:efficiency:daily-report:edit |
| /pms/efficiency/daily-report/submit/{id} | PUT | 提交日报 | pms:efficiency:daily-report:edit |
| /pms/efficiency/daily-report/approve/{id} | PUT | 审核日报 | pms:efficiency:daily-report:approve |
| /pms/efficiency/daily-report/{ids} | DELETE | 删除日报 | pms:efficiency:daily-report:remove |
| /pms/efficiency/daily-report/export | POST | 导出日报 | pms:efficiency:daily-report:export |

#### 日报状态枚举

| 值 | 说明 |
|----|------|
| DRAFT | 草稿 |
| SUBMITTED | 已提交 |
| APPROVED | 已通过 |
| REJECTED | 已驳回 |

---

### 4. 人效中心 - 周报管理 (/pms/efficiency/weekly-report)

| 端点 | 方法 | 说明 | 权限 |
|------|------|------|------|
| /pms/efficiency/weekly-report/list | GET | 查询周报列表 | pms:efficiency:weekly-report:list |
| /pms/efficiency/weekly-report/my | GET | 获取我的周报 | pms:efficiency:weekly-report:list |
| /pms/efficiency/weekly-report/generate/{weekStartDate} | GET | 自动生成周报 | pms:efficiency:weekly-report:add |
| /pms/efficiency/weekly-report/{id} | GET | 获取周报详情 | pms:efficiency:weekly-report:query |
| /pms/efficiency/weekly-report | POST | 创建周报 | pms:efficiency:weekly-report:add |
| /pms/efficiency/weekly-report | PUT | 更新周报 | pms:efficiency:weekly-report:edit |
| /pms/efficiency/weekly-report/submit/{id} | PUT | 提交周报 | pms:efficiency:weekly-report:edit |
| /pms/efficiency/weekly-report/approve/{id} | PUT | 审核周报 | pms:efficiency:weekly-report:approve |
| /pms/efficiency/weekly-report/{ids} | DELETE | 删除周报 | pms:efficiency:weekly-report:remove |
| /pms/efficiency/weekly-report/export | POST | 导出周报 | pms:efficiency:weekly-report:export |

---

### 5. 人效中心 - 仪表盘 (/pms/efficiency/dashboard)

| 端点 | 方法 | 说明 | 权限 |
|------|------|------|------|
| /pms/efficiency/dashboard/overview | GET | 概览数据 | pms:efficiency:dashboard:view |
| /pms/efficiency/dashboard/hours-stats | GET | 工时统计 | pms:efficiency:dashboard:view |
| /pms/efficiency/dashboard/task-progress | GET | 任务进度 | pms:efficiency:dashboard:view |
| /pms/efficiency/dashboard/delayed-tasks | GET | 延误任务 | pms:efficiency:dashboard:view |
| /pms/efficiency/dashboard/member-hours-ranking | GET | 成员工时排名 | pms:efficiency:dashboard:view |
| /pms/efficiency/dashboard/pending-reports | GET | 待审核报告 | pms:efficiency:dashboard:view |
| /pms/efficiency/dashboard/report-status | GET | 报告状态统计 | pms:efficiency:dashboard:view |

---

### 6. 人效中心 - 看板视图 (/pms/efficiency/kanban)

| 端点 | 方法 | 说明 | 权限 |
|------|------|------|------|
| /pms/efficiency/kanban/data/{projectId} | GET | 获取看板数据 | pms:efficiency:kanban:view |
| /pms/efficiency/kanban/task/{id}/status/{status} | PUT | 更新任务状态 | pms:efficiency:task:edit |

---

### 7. 人效中心 - 甘特图 (/pms/efficiency/gantt)

| 端点 | 方法 | 说明 | 权限 |
|------|------|------|------|
| /pms/efficiency/gantt/data/{projectId} | GET | 获取甘特图数据 | pms:efficiency:gantt:view |
| /pms/efficiency/gantt/task/{id}/dates | PUT | 更新任务日期 | pms:efficiency:task:edit |
| /pms/efficiency/gantt/task/{id}/progress/{progress} | PUT | 更新任务进度 | pms:efficiency:task:edit |

---

### 8. 人效中心 - 数据同步 (/pms/efficiency/sync)

| 端点 | 方法 | 说明 | 权限 |
|------|------|------|------|
| /pms/efficiency/sync/schedule | POST | 同步排期数据 | pms:efficiency:sync:execute |
| /pms/efficiency/sync/milestone | POST | 同步里程碑数据 | pms:efficiency:sync:execute |
| /pms/efficiency/sync/report | POST | 同步日报数据 | pms:efficiency:sync:execute |
| /pms/efficiency/sync/all | POST | 全量同步 | pms:efficiency:sync:execute |
| /pms/efficiency/sync/incremental | POST | 增量同步 | pms:efficiency:sync:execute |
| /pms/efficiency/sync/status | GET | 查看同步状态 | pms:efficiency:sync:view |

---

## Request/Response Examples

### 创建任务

**Request:**
```json
{
  "projectId": 1,
  "parentId": null,
  "taskType": "DAILY",
  "name": "完成用户模块开发",
  "description": "实现用户 CRUD 功能",
  "assigneeId": 1,
  "startDate": "2026-01-23",
  "endDate": "2026-01-25",
  "estimatedHours": 8.0
}
```

**Response:**
```json
{
  "code": 200,
  "msg": "操作成功",
  "data": null
}
```

### 提交日报

**Request:**
```json
{
  "reportDate": "2026-01-23",
  "summary": "完成任务 A、B",
  "issues": "遇到环境配置问题",
  "tomorrowPlan": "继续完成任务 C",
  "tasks": [
    {
      "taskId": 1,
      "spentHours": 4.0,
      "progress": 50,
      "workDesc": "完成了基础功能"
    }
  ]
}
```

---

## Maintenance

### Update Triggers

| 触发条件 | 操作 |
|----------|------|
| 新端点添加 | 更新对应模块的端点表 |
| 权限变更 | 更新权限标识 |
| 参数变更 | 更新请求/响应示例 |

### Verification Checklist

- [ ] 所有端点有权限标识
- [ ] 所有端点有方法说明
- [ ] 状态枚举完整
- [ ] 示例与实际 API 一致

### Last Updated

2026-01-23
