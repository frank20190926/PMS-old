# Requirements Specification

<!-- SCOPE: Functional and non-functional requirements for PMS project -->
<!-- NO_CODE_EXAMPLES: This document defines requirements, not implementations -->

## Overview

本文档定义 PMS 项目管理系统的功能需求和非功能需求。

| 属性 | 值 |
|------|-----|
| 项目 | PMS 项目管理系统 |
| 版本 | 3.8.6 |
| 状态 | Active |

---

## Functional Requirements

### FR-SYS: 系统管理模块

| ID | 需求 | 优先级 | 状态 |
|----|------|--------|------|
| FR-SYS-001 | 用户管理：支持用户的增删改查、密码重置、状态启禁用 | Must | Done |
| FR-SYS-002 | 部门管理：支持树形组织结构的配置和数据权限划分 | Must | Done |
| FR-SYS-003 | 角色管理：支持角色的菜单权限和数据权限配置 | Must | Done |
| FR-SYS-004 | 菜单管理：支持动态菜单配置和按钮权限标识 | Must | Done |
| FR-SYS-005 | 字典管理：支持系统常用固定数据的维护 | Should | Done |
| FR-SYS-006 | 参数管理：支持系统动态配置参数 | Should | Done |
| FR-SYS-007 | 通知公告：支持系统通知公告的发布和维护 | Could | Done |

### FR-LOG: 日志管理模块

| ID | 需求 | 优先级 | 状态 |
|----|------|--------|------|
| FR-LOG-001 | 操作日志：记录和查询系统正常操作日志 | Must | Done |
| FR-LOG-002 | 登录日志：记录和查询系统登录日志（含异常） | Must | Done |
| FR-LOG-003 | 在线用户：监控当前系统活跃用户状态 | Should | Done |

### FR-MON: 系统监控模块

| ID | 需求 | 优先级 | 状态 |
|----|------|--------|------|
| FR-MON-001 | 定时任务：在线管理任务调度，支持查看执行结果日志 | Should | Done |
| FR-MON-002 | 服务监控：监视系统 CPU、内存、磁盘、堆栈信息 | Could | Done |
| FR-MON-003 | 缓存监控：查询系统缓存信息和命令统计 | Could | Done |
| FR-MON-004 | 连接池监控：监视数据库连接池状态，分析 SQL 性能 | Could | Done |

### FR-PMS: 项目管理模块

| ID | 需求 | 优先级 | 状态 |
|----|------|--------|------|
| FR-PMS-001 | 项目管理：支持项目的创建、编辑、删除和状态管理 | Must | Done |
| FR-PMS-002 | 项目类型：支持项目类型的分类配置 | Should | Done |
| FR-PMS-003 | 项目成果：支持项目交付成果的管理 | Should | Done |
| FR-PMS-004 | 假期管理：支持节假日数据的维护 | Could | Done |
| FR-PMS-005 | 报告管理：支持项目报告的查看和导出 | Should | Done |

### FR-EFF: 人效中心模块

| ID | 需求 | 优先级 | 状态 |
|----|------|--------|------|
| FR-EFF-001 | 任务管理：支持任务的创建、分配、状态变更和筛选 | Must | Done |
| FR-EFF-002 | 日报管理：支持员工日报的填写、提交和查看 | Must | Done |
| FR-EFF-003 | 日报审核：项目经理可审核员工提交的日报（通过/驳回） | Must | Done |
| FR-EFF-004 | 周报管理：支持周报的填写、提交和审批流程 | Should | Done |
| FR-EFF-005 | 仪表盘：展示任务状态统计、工时统计等数据 | Should | Done |
| FR-EFF-006 | 看板视图：按任务状态分列展示任务卡片 | Should | Done |
| FR-EFF-007 | 甘特图：以时间线方式展示任务计划和进度 | Could | Done |
| FR-EFF-008 | 数据同步：支持老系统数据自动同步到新表 | Must | Done |

---

## Non-Functional Requirements

### NFR-PERF: 性能需求

| ID | 需求 | 指标 |
|----|------|------|
| NFR-PERF-001 | 页面响应时间 | < 3 秒 |
| NFR-PERF-002 | API 响应时间 | < 500ms (P95) |
| NFR-PERF-003 | 并发用户数 | 支持 100 用户同时在线 |
| NFR-PERF-004 | 数据库连接池 | 最大 20 连接 |

### NFR-SEC: 安全需求

| ID | 需求 | 说明 |
|----|------|------|
| NFR-SEC-001 | 身份认证 | JWT Token 认证，支持多终端 |
| NFR-SEC-002 | 权限控制 | RBAC 角色权限模型 |
| NFR-SEC-003 | 密码策略 | 最大错误 5 次，锁定 10 分钟 |
| NFR-SEC-004 | XSS 防护 | 开启 XSS 过滤 |
| NFR-SEC-005 | SQL 注入防护 | MyBatis 参数化查询 |

### NFR-AVAIL: 可用性需求

| ID | 需求 | 指标 |
|----|------|------|
| NFR-AVAIL-001 | 系统可用性 | 99.5% (工作时间) |
| NFR-AVAIL-002 | 数据备份 | 每日备份 |
| NFR-AVAIL-003 | 故障恢复 | RTO < 4 小时 |

### NFR-COMPAT: 兼容性需求

| ID | 需求 | 说明 |
|----|------|------|
| NFR-COMPAT-001 | 浏览器 | Chrome, Firefox, Edge 最新版 |
| NFR-COMPAT-002 | 分辨率 | 1920x1080 及以上 |
| NFR-COMPAT-003 | Java 版本 | JDK 11 |
| NFR-COMPAT-004 | 数据库 | MySQL 8.0+ |

---

## User Stories

### 管理员视角

| Story ID | As a... | I want to... | So that... |
|----------|---------|--------------|------------|
| US-ADM-001 | 管理员 | 管理用户账号和权限 | 控制系统访问 |
| US-ADM-002 | 管理员 | 配置组织结构和部门 | 划分数据权限 |
| US-ADM-003 | 管理员 | 查看系统运行状态 | 及时发现问题 |

### 项目经理视角

| Story ID | As a... | I want to... | So that... |
|----------|---------|--------------|------------|
| US-PM-001 | 项目经理 | 创建和分配任务 | 管理项目进度 |
| US-PM-002 | 项目经理 | 审核员工日报 | 了解工作完成情况 |
| US-PM-003 | 项目经理 | 查看任务看板和甘特图 | 直观了解项目状态 |

### 员工视角

| Story ID | As a... | I want to... | So that... |
|----------|---------|--------------|------------|
| US-EMP-001 | 员工 | 查看分配给我的任务 | 了解工作内容 |
| US-EMP-002 | 员工 | 填写和提交日报 | 汇报工作进度 |
| US-EMP-003 | 员工 | 更新任务状态 | 反映实际进度 |

---

## Constraints

| 类型 | 约束 |
|------|------|
| 技术约束 | 基于 RuoYi-Vue 3.8.6 框架开发 |
| 技术约束 | 后端使用 Java 11 + Spring Boot 2.5 |
| 技术约束 | 前端使用 Vue 2 + Element UI |
| 业务约束 | 人效中心代码限制在 efficiency/ 目录 |
| 部署约束 | 单机部署，无集群需求 |

---

## Maintenance

### Update Triggers

| 触发条件 | 操作 |
|----------|------|
| 新需求提出 | 添加 FR/NFR 条目 |
| 需求变更 | 更新对应条目状态 |
| 需求完成 | 标记状态为 Done |

### Verification Checklist

- [ ] 所有 FR 有唯一 ID
- [ ] 所有 FR 有优先级标记
- [ ] NFR 有可量化指标
- [ ] User Stories 覆盖主要角色

### Last Updated

2026-01-23
