# Design Guidelines

<!-- SCOPE: UI/UX design standards, component library, and visual guidelines for PMS frontend -->
<!-- NO_CODE_EXAMPLES: This document defines visual standards - use component references instead -->

## Overview

本文档定义 PMS 项目管理系统前端的设计规范和视觉标准。

| 属性 | 值 |
|------|-----|
| 框架 | Vue 2.7.16 |
| UI 库 | Element UI 2.15.14 |
| 图标 | Element Icons |
| 图表 | ECharts 6.0.0 |
| 预处理器 | Sass |

---

## Design System

### Component Library

| 组件类别 | 库 | 文档 |
|----------|-----|------|
| 基础组件 | Element UI | https://element.eleme.cn/#/zh-CN |
| 图表组件 | ECharts | https://echarts.apache.org/zh/ |
| 树选择 | vue-treeselect | https://www.vue-treeselect.cn/ |
| 富文本 | Quill | https://quilljs.com/ |

### Layout System

| 布局 | 说明 |
|------|------|
| 侧边栏 | 固定宽度 200px，可折叠 |
| 顶部导航 | 固定高度，包含面包屑 |
| 内容区 | 响应式，padding 20px |

---

## Color Palette

### Primary Colors

| 名称 | Hex | 用途 |
|------|-----|------|
| Primary Blue | #324157 | 主色调 |
| Light Blue | #3A71A8 | 链接、高亮 |
| Element Blue | #409EFF | Element UI 主题色 |

### Semantic Colors

| 名称 | Hex | 用途 |
|------|-----|------|
| Success | #30B08F | 成功状态 |
| Warning | #FEC171 | 警告状态 |
| Danger | #C03639 | 错误、删除 |
| Info | #4AB7BD | 信息提示 |

### Menu Theme Colors

| 名称 | Hex | 用途 |
|------|-----|------|
| Menu Background | #304156 | 侧边栏背景 |
| Menu Text | #bfcbd9 | 菜单文字 |
| Menu Active | #f4f4f5 | 选中菜单 |
| Sub Menu | #1f2d3d | 子菜单背景 |
| Sub Menu Hover | #001528 | 子菜单悬停 |

### Status Colors (任务状态)

| 状态 | 颜色 | Hex |
|------|------|-----|
| PENDING | 灰色 | #909399 |
| IN_PROGRESS | 蓝色 | #409EFF |
| COMPLETED | 绿色 | #67C23A |
| DELAYED | 红色 | #F56C6C |

### Report Status Colors (日报/周报状态)

| 状态 | 颜色 | Hex |
|------|------|-----|
| DRAFT | 灰色 | #909399 |
| SUBMITTED | 蓝色 | #409EFF |
| APPROVED | 绿色 | #67C23A |
| REJECTED | 红色 | #F56C6C |

---

## Typography

### Font Family

| 用途 | 字体 |
|------|------|
| 正文 | "Helvetica Neue", Helvetica, "PingFang SC", "Hiragino Sans GB", "Microsoft YaHei", Arial, sans-serif |
| 代码 | Consolas, Monaco, "Andale Mono", monospace |

### Font Sizes

| 级别 | 大小 | 用途 |
|------|------|------|
| H1 | 20px | 页面标题 |
| H2 | 18px | 模块标题 |
| H3 | 16px | 卡片标题 |
| Body | 14px | 正文内容 |
| Small | 12px | 辅助文字 |
| Mini | 10px | 标签、徽章 |

### Font Weights

| 名称 | 值 | 用途 |
|------|-----|------|
| Regular | 400 | 正文 |
| Medium | 500 | 强调 |
| Bold | 600 | 标题 |

---

## Spacing

### Spacing Scale

| Token | 值 | 用途 |
|-------|-----|------|
| xs | 4px | 图标间距 |
| sm | 8px | 紧凑间距 |
| md | 12px | 标准间距 |
| lg | 16px | 卡片内边距 |
| xl | 20px | 区块间距 |
| xxl | 24px | 页面边距 |

---

## Component Guidelines

### Buttons

| 类型 | Element 组件 | 用途 |
|------|-------------|------|
| Primary | el-button type="primary" | 主要操作 |
| Success | el-button type="success" | 提交、保存 |
| Warning | el-button type="warning" | 需确认操作 |
| Danger | el-button type="danger" | 删除、危险操作 |
| Info | el-button type="info" | 次要操作 |
| Text | el-button type="text" | 内联操作 |

### Forms

| 规范 | 说明 |
|------|------|
| 标签位置 | 顶部对齐 (label-position="top") |
| 必填标记 | 红色星号 (*) |
| 验证时机 | blur + change |
| 错误提示 | 字段下方红色文字 |

### Tables

| 规范 | 说明 |
|------|------|
| 边框 | 有边框 (border) |
| 斑马纹 | 启用 (stripe) |
| 行高 | 标准 |
| 操作列 | 固定右侧 |
| 分页 | 底部居中 |

### Dialogs

| 规范 | 说明 |
|------|------|
| 宽度 | 小型 400px / 标准 600px / 大型 800px |
| 关闭方式 | 右上角 X + ESC 键 |
| 确认按钮 | 右下角，Primary |
| 取消按钮 | 右下角，默认 |

---

## Icons

### Icon Usage

| 场景 | 图标来源 |
|------|----------|
| 菜单图标 | Element Icons |
| 操作图标 | Element Icons |
| 状态图标 | Element Icons |

### Common Icons

| 用途 | 图标名 |
|------|--------|
| 编辑 | el-icon-edit |
| 删除 | el-icon-delete |
| 查看 | el-icon-view |
| 搜索 | el-icon-search |
| 刷新 | el-icon-refresh |
| 添加 | el-icon-plus |
| 导出 | el-icon-download |

---

## Responsive Design

### Breakpoints

| 名称 | 宽度 | 说明 |
|------|------|------|
| xs | < 768px | 移动端 (不支持) |
| sm | ≥ 768px | 平板 |
| md | ≥ 992px | 小屏桌面 |
| lg | ≥ 1200px | 标准桌面 |
| xl | ≥ 1920px | 大屏桌面 |

### Minimum Requirements

| 要求 | 值 |
|------|-----|
| 最小分辨率 | 1920 x 1080 |
| 最小宽度 | 1200px |

---

## Accessibility (WCAG 2.1)

### Level AA Compliance

| 标准 | 实现 |
|------|------|
| 4.5:1 对比度 | 文字与背景对比 |
| 键盘导航 | Tab 顺序合理 |
| 焦点指示 | 可见焦点样式 |
| 表单标签 | 所有输入有 label |
| 错误提示 | 明确的错误信息 |

### ARIA Guidelines

| 场景 | 实现 |
|------|------|
| 按钮 | aria-label 描述 |
| 表格 | 表头关联 |
| 对话框 | role="dialog" |
| 加载状态 | aria-busy |

---

## File Structure

### Frontend Structure

| 目录 | 说明 |
|------|------|
| src/assets/styles/ | 全局样式 |
| src/components/ | 公共组件 |
| src/views/pms/ | PMS 业务页面 |
| src/views/pms/efficiency/ | 人效中心页面 |

### Style Files

| 文件 | 说明 |
|------|------|
| variables.scss | 变量定义 |
| element-variables.scss | Element UI 主题变量 |
| ruoyi.scss | RuoYi 框架样式 |
| custom.scss | 自定义样式 |
| mixin.scss | Sass 混入 |

---

## Maintenance

### Update Triggers

| 触发条件 | 操作 |
|----------|------|
| 新增颜色 | 更新 Color Palette |
| 新增组件 | 更新 Component Guidelines |
| 样式变更 | 更新相应章节 |

### Verification Checklist

- [ ] 颜色值与代码一致
- [ ] 字体配置正确
- [ ] 组件规范完整
- [ ] WCAG 标准满足

### Last Updated

2026-01-23
