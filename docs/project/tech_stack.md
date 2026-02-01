# Technology Stack

<!-- SCOPE: Complete technology stack with versions, rationale, and configuration -->
<!-- NO_CODE_EXAMPLES: This document defines technology choices, not implementations -->

## Overview

本文档记录 PMS 项目管理系统的完整技术栈，包括版本、选型理由和配置说明。

---

## Frontend Stack

### Core Framework

| 技术 | 版本 | 用途 | 选型理由 |
|------|------|------|----------|
| Vue.js | 2.7.16 | 前端框架 | RuoYi 框架标配，团队熟悉 |
| Vue Router | 3.6.5 | 路由管理 | Vue 2 官方路由方案 |
| Vuex | 3.6.2 | 状态管理 | Vue 2 官方状态管理 |

### UI Components

| 技术 | 版本 | 用途 | 选型理由 |
|------|------|------|----------|
| Element UI | 2.15.14 | UI 组件库 | 企业级组件，中文文档完善 |
| ECharts | 6.0.0 | 图表可视化 | 功能丰富，支持甘特图 |

### Build Tools

| 技术 | 版本 | 用途 | 选型理由 |
|------|------|------|----------|
| Vue CLI | 4.4.6 | 构建工具 | Vue 2 官方脚手架 |
| Webpack | (Vue CLI 内置) | 打包工具 | Vue CLI 默认 |
| Babel | (Vue CLI 内置) | 转译工具 | ES6+ 兼容性 |

### HTTP & Utilities

| 技术 | 版本 | 用途 | 选型理由 |
|------|------|------|----------|
| Axios | 1.13.2 | HTTP 客户端 | Promise API，拦截器支持 |
| js-cookie | 3.5 | Cookie 管理 | 轻量级，API 简洁 |
| jsencrypt | 3.5.4 | RSA 加密 | 密码加密传输 |

### Code Quality

| 技术 | 版本 | 用途 | 选型理由 |
|------|------|------|----------|
| ESLint | 7.15.0 | 代码检查 | 统一代码风格 |
| Sass | 1.32.13 | CSS 预处理 | 变量、嵌套支持 |

---

## Backend Stack

### Core Framework

| 技术 | 版本 | 用途 | 选型理由 |
|------|------|------|----------|
| Spring Boot | 2.5.15 | 应用框架 | RuoYi 框架标配，生态成熟 |
| Spring Security | (Boot 内置) | 安全框架 | 认证授权一体化 |
| Spring MVC | (Boot 内置) | Web 框架 | RESTful API 支持 |

### RuoYi Framework

| 模块 | 版本 | 用途 |
|------|------|------|
| ruoyi-admin | 3.8.6 | 应用入口 |
| ruoyi-framework | 3.8.6 | 核心框架 (Security, Redis) |
| ruoyi-system | 3.8.6 | 系统管理 (用户、角色、权限) |
| ruoyi-common | 3.8.6 | 公共工具类 |
| ruoyi-quartz | 3.8.6 | 定时任务 |
| ruoyi-generator | 3.8.6 | 代码生成器 |

### Data Access

| 技术 | 版本 | 用途 | 选型理由 |
|------|------|------|----------|
| MyBatis-Plus | 3.5.1 | ORM 框架 | 增强 MyBatis，简化 CRUD |
| Druid | 1.2.16 | 连接池 | 阿里出品，监控完善 |
| PageHelper | 1.4.6 | 分页插件 | MyBatis 分页标准方案 |

### Caching

| 技术 | 版本 | 用途 | 选型理由 |
|------|------|------|----------|
| Redis | 6.0+ | 缓存/Session | 高性能，RuoYi 标配 |
| Lettuce | (Boot 内置) | Redis 客户端 | 异步支持，线程安全 |

### Security

| 技术 | 版本 | 用途 | 选型理由 |
|------|------|------|----------|
| JWT (jjwt) | 0.9.1 | Token 认证 | 无状态，多终端支持 |
| Kaptcha | 2.3.3 | 验证码 | 安全，可定制 |

### Documentation

| 技术 | 版本 | 用途 | 选型理由 |
|------|------|------|----------|
| Springfox (Swagger) | 3.0.0 | API 文档 | 自动生成，可交互 |

### Utilities

| 技术 | 版本 | 用途 |
|------|------|------|
| Lombok | 1.18.36 | 代码简化 |
| FastJSON2 | 2.0.39 | JSON 处理 |
| Apache POI | 5.2.5 | Excel 导入导出 |
| Commons-IO | 2.13.0 | IO 工具 |

---

## Database Stack

### Primary Database

| 技术 | 版本 | 用途 | 配置 |
|------|------|------|------|
| MySQL | 8.0+ | 主数据库 | kml-pms, UTF-8MB4 |

### Connection Configuration

| 参数 | 值 | 说明 |
|------|-----|------|
| initialSize | 5 | 初始连接数 |
| minIdle | 10 | 最小空闲连接 |
| maxActive | 20 | 最大活动连接 |
| maxWait | 60000 | 获取连接超时 (ms) |

### Key Tables

| 表前缀 | 模块 | 数量 |
|--------|------|------|
| sys_ | 系统管理 | 10+ |
| pms_ | 项目管理 | 8+ |
| eff_ | 人效中心 | 5 |

---

## Cache Stack

### Redis Configuration

| 参数 | 值 | 说明 |
|------|-----|------|
| host | localhost | 地址 |
| port | 6379 | 端口 |
| database | 0 | 数据库索引 |
| timeout | 10s | 连接超时 |

### Cache Usage

| 用途 | Key Pattern | TTL |
|------|-------------|-----|
| 用户 Token | login_tokens:* | 14400 min |
| 验证码 | captcha_codes:* | 5 min |
| 字典缓存 | sys_dict:* | 永久 |
| 配置缓存 | sys_config:* | 永久 |

---

## Development Tools

### Build & Package

| 技术 | 版本 | 用途 |
|------|------|------|
| Maven | 3.6+ | 后端构建 |
| npm | 6.0+ | 前端包管理 |
| Node.js | 16+ | 前端运行时 |

### IDE & Plugins

| 工具 | 用途 |
|------|------|
| IntelliJ IDEA | Java 开发 |
| VS Code | 前端开发 |
| Lombok Plugin | 代码简化支持 |

### Version Control

| 技术 | 用途 |
|------|------|
| Git | 版本控制 |
| .gitignore | 忽略配置 |

---

## Runtime Requirements

### Java Runtime

| 要求 | 值 |
|------|-----|
| JDK 版本 | 11 |
| JAVA_HOME | /opt/homebrew/opt/openjdk@11 |
| 堆内存 | 建议 1GB+ |

### Node.js Runtime

| 要求 | 值 |
|------|-----|
| Node.js 版本 | 16+ |
| npm 版本 | 6.0+ |

---

## Ports & Endpoints

| 服务 | 端口 | 路径 |
|------|------|------|
| 前端开发 | 1024 | http://localhost:1024 |
| 后端 API | 8090 | http://localhost:8090 |
| Swagger | 8090 | /swagger-ui/index.html |
| Druid 监控 | 8090 | /druid |

---

## Version Compatibility Matrix

| 组件 | 最低版本 | 推荐版本 | 最高测试版本 |
|------|----------|----------|--------------|
| Java | 11 | 11 | 11 |
| MySQL | 5.7 | 8.0 | 8.0 |
| Redis | 5.0 | 6.0 | 7.0 |
| Node.js | 14 | 16 | 18 |
| npm | 6.0 | 8.0 | 9.0 |

---

## Upgrade Considerations

### Planned Upgrades

| 组件 | 当前版本 | 目标版本 | 优先级 | 注意事项 |
|------|----------|----------|--------|----------|
| Vue | 2.7 | - | Low | RuoYi 框架限制 |
| Spring Boot | 2.5 | - | Low | RuoYi 框架限制 |

### Known Limitations

| 限制 | 影响 | 解决方案 |
|------|------|----------|
| Vue 2 EOL | 安全更新 | 使用 Vue 2.7 LTS |
| Spring Boot 2.5 | 安全更新 | 跟进 RuoYi 框架升级 |

---

## Maintenance

### Update Triggers

| 触发条件 | 操作 |
|----------|------|
| 依赖版本升级 | 更新版本号 |
| 新技术引入 | 添加到相应章节 |
| 配置变更 | 更新配置说明 |

### Verification Checklist

- [ ] 所有版本号准确
- [ ] 选型理由完整
- [ ] 配置参数正确
- [ ] 端口信息最新

### Last Updated

2026-01-23
