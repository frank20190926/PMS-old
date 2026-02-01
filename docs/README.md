# PMS 项目管理系统 - 文档中心

<!-- SCOPE: Documentation hub and navigation for AI agents and developers -->

## Overview

本文档中心为 **PMS 项目管理系统 (kml-pms-v2)** 提供完整的文档导航和标准规范。

| 属性 | 值 |
|------|-----|
| 项目名称 | PMS 项目管理系统 |
| 技术栈 | Vue 2 + Element UI / Spring Boot + MyBatis-Plus / MySQL + Redis |
| 文档语言 | 中文 (业务文档) / English (技术规范) |

---

## Documentation Standards

所有文档必须遵循以下标准：

| 标准 | 文件 | 说明 |
|------|------|------|
| 文档规范 | [documentation_standards.md](./documentation_standards.md) | 60+ 文档编写要求 |
| 核心原则 | [principles.md](./principles.md) | 8 项核心开发原则 |

---

## Writing Guidelines

### Format Priority

```
Tables/ASCII > Lists > Text
```

### Language Rules

| 文档类型 | 语言 |
|----------|------|
| 业务需求、用户故事 | 中文 |
| API 规范、技术架构 | English |
| 代码注释 | English |

### Naming Conventions

| 类型 | 格式 | 示例 |
|------|------|------|
| 文档文件 | snake_case.md | api_spec.md |
| 目录 | lowercase | project/, reference/ |

---

## Quick Navigation

### Project Documentation

| 文档 | 路径 | 说明 |
|------|------|------|
| 需求文档 | [project/requirements.md](./project/requirements.md) | 功能需求和用户故事 |
| 架构文档 | [project/architecture.md](./project/architecture.md) | 系统架构和组件设计 |
| 技术栈 | [project/tech_stack.md](./project/tech_stack.md) | 技术选型和版本 |
| API 规范 | [project/api_spec.md](./project/api_spec.md) | 后端 API 接口定义 |
| 数据库 | [project/database_schema.md](./project/database_schema.md) | 数据库表结构 |
| 前端设计 | [project/design_guidelines.md](./project/design_guidelines.md) | UI/UX 设计规范 |

### Reference Documentation

| 文档 | 路径 | 说明 |
|------|------|------|
| ADRs | reference/adrs/ | 架构决策记录 |
| Guides | reference/guides/ | 开发指南 |

### Root Documents

| 文档 | 路径 | 说明 |
|------|------|------|
| Claude 指南 | [../CLAUDE.md](../CLAUDE.md) | AI 助手开发指南 |
| 文档标准 | [documentation_standards.md](./documentation_standards.md) | 文档编写规范 |
| 核心原则 | [principles.md](./principles.md) | 开发原则和反模式 |

---

## Maintenance

### Update Triggers

| 触发条件 | 操作 |
|----------|------|
| 新增文档 | 更新 Quick Navigation 表格 |
| 目录结构变更 | 更新所有路径引用 |
| 标准变更 | 更新 Documentation Standards 部分 |

### Verification Checklist

- [ ] 所有链接可访问
- [ ] 导航表格完整
- [ ] 标准与 documentation_standards.md 一致

### Last Updated

2026-01-23
