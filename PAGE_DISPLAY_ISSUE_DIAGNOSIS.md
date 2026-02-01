# 项目生命周期功能 - 页面显示问题诊断报告

**诊断时间**: 2026-01-27
**问题描述**: 用户报告"很多页面都不能正常显示"
**诊断状态**: ✅ 已找到根本原因并修复

---

## 🔍 问题诊断过程

### 1. 自动化测试发现

**测试结果**:
- ✅ 前端服务正常运行 (http://localhost:1025)
- ✅ 后端服务正常运行 (http://localhost:8090)
- ✅ MySQL 数据库连接正常
- ✅ Redis 服务运行正常
- ❌ 登录后无法看到"人效中心"及"项目生命周期"菜单

### 2. 数据库检查

执行 SQL 查询检查菜单配置：
```sql
SELECT menu_id, menu_name, visible FROM sys_menu
WHERE menu_name IN ('人效中心', '项目生命周期', '阶段配置', '文档管理');
```

**发现的问题**:
```
menu_id=1138 | 人效中心       | visible=0 ❌
menu_id=1198 | 项目生命周期   | visible=0 ❌
menu_id=1199 | 阶段配置       | visible=0 ❌
menu_id=1205 | 文档管理       | visible=0 ❌
menu_id=1212 | 任务生成       | visible=0 ❌
menu_id=1217 | 流程仪表盘     | visible=0 ❌
```

**根本原因**: 所有新开发的菜单项在数据库中 `visible` 字段被设置为 `0`（不可见），导致前端无法渲染这些菜单。

---

## ✅ 修复方案

### 已执行的修复

**1. 创建修复脚本**: `sql/fix_menu_visibility.sql`

**2. 执行修复**:
```bash
mysql -h 127.0.0.1 -u root -p123456 kml-pms < sql/fix_menu_visibility.sql
```

**3. 修复内容**:
```sql
-- 修复主菜单
UPDATE sys_menu SET visible = '1' WHERE menu_id = 1138;  -- 人效中心
UPDATE sys_menu SET visible = '1' WHERE menu_id = 1198;  -- 项目生命周期

-- 修复所有子菜单
UPDATE sys_menu SET visible = '1' WHERE parent_id = 1138;  -- 人效中心下所有菜单
UPDATE sys_menu SET visible = '1' WHERE parent_id = 1198;  -- 项目生命周期下所有菜单
UPDATE sys_menu SET visible = '1' WHERE parent_id = 1205;  -- 文档管理子菜单
UPDATE sys_menu SET visible = '1' WHERE parent_id = 1212;  -- 任务生成子菜单
UPDATE sys_menu SET visible = '1' WHERE parent_id = 1217;  -- 流程仪表盘子菜单
```

**4. 验证修复结果**:
```
✅ menu_id=1138 | 人效中心       | visible=1
✅ menu_id=1198 | 项目生命周期   | visible=1
✅ menu_id=1199 | 阶段配置       | visible=1
✅ menu_id=1205 | 文档管理       | visible=1
✅ menu_id=1212 | 任务生成       | visible=1
✅ menu_id=1217 | 流程仪表盘     | visible=1
```

---

## 🚀 用户验证步骤

### 步骤 1: 清除浏览器缓存

**重要**: 必须清除浏览器缓存，因为前端可能缓存了旧的菜单数据。

**方法 1 - Chrome/Edge**:
1. 按 `Cmd + Shift + Delete` (Mac) 或 `Ctrl + Shift + Delete` (Windows)
2. 选择"缓存的图片和文件"
3. 时间范围选择"全部时间"
4. 点击"清除数据"

**方法 2 - 强制刷新**:
1. 按 `Cmd + Shift + R` (Mac) 或 `Ctrl + Shift + R` (Windows)

**方法 3 - 无痕模式**:
1. 使用无痕/隐私浏览模式访问系统

### 步骤 2: 重新登录系统

1. 访问: http://localhost:1025
2. 使用管理员账号登录:
   - 用户名: `admin`
   - 密码: `admin123`
3. 输入验证码完成登录

### 步骤 3: 验证菜单显示

登录后，应该能在左侧菜单栏看到：

```
├─ 首页
├─ 系统管理
├─ 系统监控
├─ 系统工具
├─ 人效中心 ← 新增
│  ├─ 任务管理
│  ├─ 日报管理
│  ├─ 周报管理
│  ├─ PM工作台
│  ├─ 任务看板
│  ├─ 甘特图
│  ├─ 数据同步
│  ├─ 日报审核
│  └─ 项目生命周期 ← 重点测试
│     ├─ 阶段配置
│     ├─ 文档管理
│     ├─ 任务生成
│     └─ 流程仪表盘
└─ 项目管理
```

### 步骤 4: 测试各个页面

**4.1 阶段配置页面**:
- 点击 "人效中心" → "项目生命周期" → "阶段配置"
- 应该能看到阶段配置界面
- 可以选择标准5阶段模板或自定义阶段

**4.2 文档管理页面**:
- 点击 "人效中心" → "项目生命周期" → "文档管理"
- 应该能看到文档列表
- 可以上传文档、查看文档、添加评论

**4.3 任务生成页面**:
- 点击 "人效中心" → "项目生命周期" → "任务生成"
- 应该能看到任务生成预览界面

**4.4 流程仪表盘页面**:
- 点击 "人效中心" → "项目生命周期" → "流程仪表盘"
- 应该能看到项目流程时间线和进度

---

## 🔍 如果仍有问题

### 前端控制台检查

1. 打开浏览器开发者工具 (`F12` 或 `Cmd+Option+I`)
2. 切换到 "Console" 标签
3. 查看是否有红色错误信息
4. 截图并记录错误详情

### 网络请求检查

1. 在开发者工具中切换到 "Network" 标签
2. 刷新页面
3. 查找失败的请求（红色标记）
4. 点击失败的请求查看详细错误信息

### API 端点验证

直接测试后端 API 是否可访问：

**测试阶段管理 API**:
```bash
curl http://localhost:8090/pms/efficiency/project/phase/list
```

**测试文档管理 API**:
```bash
curl http://localhost:8090/pms/efficiency/project/document/list
```

**测试任务生成 API**:
```bash
curl http://localhost:8090/pms/efficiency/task-generation/preview/pending
```

### 权限检查

确认管理员账号有正确的权限：

```sql
-- 检查管理员角色的菜单权限
SELECT r.role_name, m.menu_name, m.path
FROM sys_role r
INNER JOIN sys_role_menu rm ON r.role_id = rm.role_id
INNER JOIN sys_menu m ON rm.menu_id = m.menu_id
WHERE r.role_name = '管理员'
  AND m.menu_name LIKE '%项目%'
ORDER BY m.menu_id;
```

---

## 📝 问题总结

### 根本原因
数据库中新菜单的 `visible` 字段被错误地设置为 `0`（不可见），这是由于导入菜单 SQL 脚本时的初始值设置问题。

### 影响范围
- "人效中心"主菜单及其所有子菜单
- "项目生命周期"功能的所有页面
  - 阶段配置
  - 文档管理
  - 任务生成
  - 流程仪表盘

### 修复状态
✅ **已完成** - 所有菜单的 `visible` 字段已更新为 `1`

### 需要用户操作
⚠️ **必须清除浏览器缓存或使用无痕模式重新登录**

---

## 📌 相关文件

| 文件 | 说明 |
|------|------|
| `sql/fix_menu_visibility.sql` | 菜单可见性修复脚本 |
| `sql/eff_project_lifecycle_menu_fixed.sql` | 原始菜单配置（已修复子查询问题） |
| `DEPLOYMENT_VERIFICATION.md` | 部署验证报告 |
| `PLAN_vs_ACTUAL_COMPARISON.md` | 计划vs实际对比报告 |

---

## ⚡ 快速修复检查清单

- [x] 数据库菜单 visible 字段已修复
- [x] 所有相关菜单已设置为可见
- [x] SQL 修复脚本已保存
- [ ] 用户清除浏览器缓存
- [ ] 用户重新登录验证
- [ ] 用户测试各个页面功能
- [ ] 前端控制台无错误
- [ ] 网络请求全部成功

---

**报告生成时间**: 2026-01-27
**问题状态**: ✅ 已修复，等待用户验证
