# Database Schema

<!-- SCOPE: Database schema documentation with ER diagrams and table definitions -->
<!-- NO_CODE_EXAMPLES: This document defines schema contracts only -->

## Overview

本文档定义 PMS 项目管理系统的数据库结构。

| 属性 | 值 |
|------|-----|
| 数据库 | MySQL 8.0+ |
| 数据库名 | kml-pms |
| 字符集 | utf8mb4 |
| 排序规则 | utf8mb4_general_ci |

---

## ER Diagram

### 人效中心模块

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           人效中心 ER 图                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌──────────────┐       ┌──────────────────┐       ┌──────────────────┐    │
│  │  sys_user    │       │    eff_task      │       │   pms_project    │    │
│  │──────────────│       │──────────────────│       │──────────────────│    │
│  │ id           │◄──────│ assignee_id      │       │ id               │    │
│  │ user_name    │       │ project_id       │──────►│ project_name     │    │
│  │ dept_id      │       │ parent_id ───────┤       │ status           │    │
│  └──────────────┘       │ task_type        │       └──────────────────┘    │
│         │               │ name             │                               │
│         │               │ status           │                               │
│         │               │ start_date       │                               │
│         │               │ end_date         │                               │
│         │               └────────┬─────────┘                               │
│         │                        │                                         │
│         │                        │ task_id                                 │
│         │                        ▼                                         │
│         │               ┌──────────────────┐                               │
│         │               │  eff_task_report │                               │
│         │               │──────────────────│                               │
│         │               │ id               │                               │
│         │               │ task_id          │                               │
│         │               │ report_id ───────┼────────────┐                  │
│         │               │ spent_hours      │            │                  │
│         │               │ progress         │            │                  │
│         │               └──────────────────┘            │                  │
│         │                                               │                  │
│         │    user_id                                    │                  │
│         ▼                                               ▼                  │
│  ┌──────────────────┐                        ┌──────────────────┐          │
│  │ eff_daily_report │                        │ eff_weekly_report│          │
│  │──────────────────│                        │──────────────────│          │
│  │ id               │                        │ id               │          │
│  │ user_id          │                        │ user_id          │          │
│  │ report_date      │                        │ week_start_date  │          │
│  │ total_hours      │                        │ week_end_date    │          │
│  │ status           │                        │ total_hours      │          │
│  │ approver_id      │                        │ status           │          │
│  └──────────────────┘                        └──────────────────┘          │
│                                                                             │
│  ┌──────────────────┐       ┌──────────────────┐                           │
│  │     eff_tag      │◄──────│  eff_task_tag    │                           │
│  │──────────────────│       │──────────────────│                           │
│  │ id               │       │ task_id          │                           │
│  │ name             │       │ tag_id           │                           │
│  │ color            │       └──────────────────┘                           │
│  └──────────────────┘                                                      │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Table Definitions

### eff_task (任务表)

| 列名 | 类型 | 可空 | 默认值 | 说明 |
|------|------|------|--------|------|
| id | bigint | NO | AUTO_INCREMENT | 任务ID (PK) |
| project_id | bigint | NO | - | 项目ID (FK → pms_project) |
| parent_id | bigint | YES | NULL | 父任务ID (自关联) |
| task_type | varchar(20) | NO | - | 任务类型: MILESTONE/WEEKLY/DAILY |
| name | varchar(200) | NO | - | 任务名称 |
| description | text | YES | NULL | 任务描述 |
| assignee_id | bigint | YES | NULL | 负责人ID (FK → sys_user) |
| status | varchar(20) | YES | 'PENDING' | 状态: PENDING/IN_PROGRESS/COMPLETED/DELAYED |
| start_date | date | YES | NULL | 开始日期 |
| end_date | date | YES | NULL | 结束日期 |
| actual_end_date | date | YES | NULL | 实际完成日期 |
| estimated_hours | decimal(10,1) | YES | 0 | 预估工时 |
| story_points | decimal(5,1) | YES | NULL | 故事点 |
| is_delayed | tinyint(1) | YES | 0 | 是否延误 |
| pm_score | decimal(5,1) | YES | NULL | PM评分 |
| pm_reviewed | tinyint(1) | YES | 0 | PM是否已审核 |
| review_comment | text | YES | NULL | PM审核意见 |
| output_url | varchar(500) | YES | NULL | 产出物链接 |
| sort_order | int | YES | 0 | 排序 |
| synced_sched_id | bigint | YES | NULL | 同步排期ID |
| progress | int | YES | 0 | 进度百分比 0-100 |
| del_flag | char(1) | YES | '0' | 删除标志 |
| create_by | varchar(64) | YES | NULL | 创建者 |
| create_time | datetime | YES | CURRENT_TIMESTAMP | 创建时间 |
| update_by | varchar(64) | YES | NULL | 更新者 |
| update_time | datetime | YES | CURRENT_TIMESTAMP | 更新时间 |
| remark | varchar(500) | YES | NULL | 备注 |

**索引:**

| 索引名 | 类型 | 列 |
|--------|------|-----|
| PRIMARY | Primary | id |
| idx_project_id | Index | project_id |
| idx_parent_id | Index | parent_id |
| idx_assignee_id | Index | assignee_id |
| idx_status | Index | status |
| idx_task_type | Index | task_type |

---

### eff_daily_report (日报表)

| 列名 | 类型 | 可空 | 默认值 | 说明 |
|------|------|------|--------|------|
| id | bigint | NO | AUTO_INCREMENT | 日报ID (PK) |
| user_id | bigint | NO | - | 用户ID (FK → sys_user) |
| report_date | date | NO | - | 日报日期 |
| total_hours | decimal(10,1) | YES | 0 | 总工时 |
| summary | text | YES | NULL | 工作内容摘要 |
| issues | text | YES | NULL | 遇到的问题 |
| tomorrow_plan | text | YES | NULL | 明日计划 |
| status | varchar(20) | YES | 'DRAFT' | 状态: DRAFT/SUBMITTED/APPROVED/REJECTED |
| approver_id | bigint | YES | NULL | 审核人ID |
| approve_time | datetime | YES | NULL | 审核时间 |
| approve_comment | text | YES | NULL | 审核意见 |
| del_flag | char(1) | YES | '0' | 删除标志 |
| create_by | varchar(64) | YES | NULL | 创建者 |
| create_time | datetime | YES | CURRENT_TIMESTAMP | 创建时间 |
| update_by | varchar(64) | YES | NULL | 更新者 |
| update_time | datetime | YES | CURRENT_TIMESTAMP | 更新时间 |
| remark | varchar(500) | YES | NULL | 备注 |

**索引:**

| 索引名 | 类型 | 列 |
|--------|------|-----|
| PRIMARY | Primary | id |
| uk_user_date | Unique | user_id, report_date |
| idx_report_date | Index | report_date |
| idx_status | Index | status |

---

### eff_task_report (任务日报关联表)

| 列名 | 类型 | 可空 | 默认值 | 说明 |
|------|------|------|--------|------|
| id | bigint | NO | AUTO_INCREMENT | ID (PK) |
| task_id | bigint | NO | - | 任务ID (FK → eff_task) |
| report_id | bigint | NO | - | 日报ID (FK → eff_daily_report) |
| project_id | bigint | NO | - | 项目ID (冗余) |
| spent_hours | decimal(10,1) | YES | 0 | 花费工时 |
| progress | int | YES | 0 | 进度百分比 |
| work_desc | text | YES | NULL | 工作描述 |
| issues | text | YES | NULL | 遇到的问题 |
| create_time | datetime | YES | CURRENT_TIMESTAMP | 创建时间 |

**索引:**

| 索引名 | 类型 | 列 |
|--------|------|-----|
| PRIMARY | Primary | id |
| idx_task_id | Index | task_id |
| idx_report_id | Index | report_id |
| idx_project_id | Index | project_id |

---

### eff_weekly_report (周报表)

| 列名 | 类型 | 可空 | 默认值 | 说明 |
|------|------|------|--------|------|
| id | bigint | NO | AUTO_INCREMENT | 周报ID (PK) |
| user_id | bigint | NO | - | 用户ID (FK → sys_user) |
| dept_id | bigint | YES | NULL | 部门ID |
| week_start_date | date | NO | - | 周开始日期 |
| week_end_date | date | NO | - | 周结束日期 |
| week_number | int | YES | NULL | 年内周数 |
| total_hours | decimal(10,1) | YES | 0 | 周总工时 |
| week_summary | text | YES | NULL | 本周工作总结 |
| achievements | text | YES | NULL | 主要成果 |
| issues | text | YES | NULL | 遇到的问题 |
| next_week_plan | text | YES | NULL | 下周计划 |
| status | varchar(20) | YES | 'DRAFT' | 状态: DRAFT/SUBMITTED/APPROVED/REJECTED |
| approver_id | bigint | YES | NULL | 审核人ID |
| approve_time | datetime | YES | NULL | 审核时间 |
| approve_comment | text | YES | NULL | 审核意见 |
| del_flag | char(1) | YES | '0' | 删除标志 |
| create_by | varchar(64) | YES | NULL | 创建者 |
| create_time | datetime | YES | CURRENT_TIMESTAMP | 创建时间 |
| update_by | varchar(64) | YES | NULL | 更新者 |
| update_time | datetime | YES | CURRENT_TIMESTAMP | 更新时间 |
| remark | varchar(500) | YES | NULL | 备注 |

**索引:**

| 索引名 | 类型 | 列 |
|--------|------|-----|
| PRIMARY | Primary | id |
| uk_user_week | Unique | user_id, week_start_date |

---

### eff_tag (标签表)

| 列名 | 类型 | 可空 | 默认值 | 说明 |
|------|------|------|--------|------|
| id | bigint | NO | AUTO_INCREMENT | 标签ID (PK) |
| name | varchar(50) | NO | - | 标签名称 |
| color | varchar(20) | YES | '#409EFF' | 标签颜色 |
| del_flag | char(1) | YES | '0' | 删除标志 |
| create_by | varchar(64) | YES | NULL | 创建者 |
| create_time | datetime | YES | CURRENT_TIMESTAMP | 创建时间 |
| update_by | varchar(64) | YES | NULL | 更新者 |
| update_time | datetime | YES | CURRENT_TIMESTAMP | 更新时间 |

---

### eff_task_tag (任务标签关联表)

| 列名 | 类型 | 可空 | 默认值 | 说明 |
|------|------|------|--------|------|
| task_id | bigint | NO | - | 任务ID (PK, FK → eff_task) |
| tag_id | bigint | NO | - | 标签ID (PK, FK → eff_tag) |

---

## Table Summary

| 表前缀 | 表数量 | 说明 |
|--------|--------|------|
| sys_ | 10+ | 系统管理表 (RuoYi 框架) |
| pms_ | 8+ | 项目管理表 |
| eff_ | 6 | 人效中心表 |

### 人效中心表统计

| 表名 | 行数 (估计) | 说明 |
|------|------------|------|
| eff_task | 131+ | 任务数据 |
| eff_daily_report | 8+ | 日报数据 |
| eff_task_report | 30+ | 任务工时关联 |
| eff_weekly_report | 4+ | 周报数据 |
| eff_tag | 6+ | 标签数据 |
| eff_task_tag | - | 多对多关联 |

---

## SQL Scripts

| 脚本 | 路径 | 说明 |
|------|------|------|
| eff_tables.sql | sql/eff_tables.sql | 表结构创建 |
| eff_menu.sql | sql/eff_menu.sql | 菜单配置 |
| eff_test_data.sql | sql/eff_test_data.sql | 测试数据 |
| eff_data_fix.sql | sql/eff_data_fix.sql | 数据补充脚本 |
| eff_sync_fields.sql | sql/eff_sync_fields.sql | 同步字段扩展 |

---

## Maintenance

### Update Triggers

| 触发条件 | 操作 |
|----------|------|
| 新表添加 | 更新 ER 图和表定义 |
| 字段变更 | 更新表定义 |
| 索引变更 | 更新索引列表 |

### Verification Checklist

- [ ] ER 图与表定义一致
- [ ] 所有外键关系标注
- [ ] 索引定义完整
- [ ] 枚举值说明完整

### Last Updated

2026-01-23
