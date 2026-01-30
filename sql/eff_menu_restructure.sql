-- 人效中心菜单结构重组
-- 新菜单体系：工作台 > 我的工作 > 项目管理 > 部门管理 > 系统管理
-- 执行命令: mysql -h 127.0.0.1 -u root -p123456 --default-character-set=utf8mb4 kml-pms < sql/eff_menu_restructure.sql

SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- ========================================
-- 第1步：更新现有一级菜单
-- ========================================
-- 人效中心菜单已存在（menu_id=1138），保持不变

-- ========================================
-- 第2步：创建新的一级菜单（工作台）
-- ========================================
INSERT INTO sys_menu (menu_id, parent_id, menu_name, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_time)
VALUES
(1219, 1138, '工作台', 0, 'dashboard', 'pms/efficiency/dashboard/index', 1, 0, 'C', '0', '0', 'pms:efficiency:dashboard:view', 'el-icon-data-analysis', NOW());

-- ========================================
-- 第3步：创建"我的工作"目录（二级菜单）
-- ========================================
INSERT INTO sys_menu (menu_id, parent_id, menu_name, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_time)
VALUES
(1220, 1138, '我的工作', 1, 'my-work', NULL, 1, 0, 'M', '0', '0', '', 'el-icon-user-solid', NOW());

-- ========================================
-- 第4步：创建"项目管理"目录（二级菜单）
-- ========================================
INSERT INTO sys_menu (menu_id, parent_id, menu_name, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_time)
VALUES
(1221, 1138, '项目管理', 2, 'project-mgmt', NULL, 1, 0, 'M', '0', '0', '', 'el-icon-s-folder', NOW());

-- ========================================
-- 第5步：创建"部门管理"目录（二级菜单）
-- ========================================
INSERT INTO sys_menu (menu_id, parent_id, menu_name, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_time)
VALUES
(1222, 1138, '部门管理', 3, 'dept-mgmt', NULL, 1, 0, 'M', '0', '0', '', 'el-icon-office-building', NOW());

-- ========================================
-- 第6步：创建"系统管理"目录（二级菜单）
-- ========================================
INSERT INTO sys_menu (menu_id, parent_id, menu_name, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_time)
VALUES
(1223, 1138, '系统管理', 4, 'sys-mgmt', NULL, 1, 0, 'M', '0', '0', '', 'el-icon-setting', NOW());

-- ========================================
-- 第7步：更新现有菜单的父级和排序（我的工作目录下）
-- ========================================
-- 任务管理（1139） -> 我的任务，父级改为1220
UPDATE sys_menu SET parent_id = 1220, order_num = 0, path = 'task', component = 'pms/efficiency/task/index', menu_name = '我的任务'
WHERE menu_id = 1139;

-- 日报填写（1145） -> 日报填写，父级改为1220
UPDATE sys_menu SET parent_id = 1220, order_num = 1, path = 'daily-report', component = 'pms/efficiency/daily-report/index', menu_name = '日报填写'
WHERE menu_id = 1145;

-- 周报填写（1157） -> 周报填写，父级改为1220
UPDATE sys_menu SET parent_id = 1220, order_num = 2, path = 'weekly-report', component = 'pms/efficiency/weekly-report/index', menu_name = '周报填写'
WHERE menu_id = 1157;

-- ========================================
-- 第8步：更新现有菜单的父级和排序（项目管理目录下）
-- ========================================
-- 项目列表（1218） -> 项目列表，父级改为1221
UPDATE sys_menu SET parent_id = 1221, order_num = 0, path = 'list', component = 'pms/efficiency/project/project-list', menu_name = '项目列表'
WHERE menu_id = 1218;

-- 日报审核（1197） -> 日报审核，父级改为1221
UPDATE sys_menu SET parent_id = 1221, order_num = 1, path = 'daily-report-approve', component = 'pms/efficiency/daily-report/approve', menu_name = '日报审核', visible = '0'
WHERE menu_id = 1197;

-- ========================================
-- 第9步：创建新的项目管理子菜单
-- ========================================
-- 人员排期
INSERT INTO sys_menu (menu_id, parent_id, menu_name, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_time)
VALUES
(1224, 1221, '人员排期', 2, 'resource-schedule', 'pms/efficiency/resource/index', 1, 0, 'C', '0', '0', 'pms:efficiency:resource:view', 'el-icon-user', NOW());

-- ========================================
-- 第10步：创建部门管理子菜单（5个）
-- ========================================
INSERT INTO sys_menu (menu_id, parent_id, menu_name, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_time)
VALUES
(1225, 1222, '部门概览', 0, 'overview', 'pms/efficiency/dept/overview', 1, 0, 'C', '0', '0', 'pms:efficiency:dept:overview', 'el-icon-pie-chart', NOW()),
(1226, 1222, '资源负载', 1, 'resource-load', 'pms/efficiency/dept/resource-load', 1, 0, 'C', '0', '0', 'pms:efficiency:dept:load', 'el-icon-data-line', NOW()),
(1227, 1222, '成员工时', 2, 'member-hours', 'pms/efficiency/dept/member-hours', 1, 0, 'C', '0', '0', 'pms:efficiency:dept:hours', 'el-icon-s-management', NOW()),
(1228, 1222, '周报汇总', 3, 'weekly-summary', 'pms/efficiency/dept/weekly-summary', 1, 0, 'C', '0', '0', 'pms:efficiency:dept:summary', 'el-icon-notebook-2', NOW()),
(1229, 1222, '项目进度', 4, 'project-progress', 'pms/efficiency/dept/project-progress', 1, 0, 'C', '0', '0', 'pms:efficiency:dept:progress', 'el-icon-s-order', NOW());

-- ========================================
-- 第11步：更新系统管理子菜单（数据同步）
-- ========================================
-- 数据同步（1190） -> 数据同步，父级改为1223
UPDATE sys_menu SET parent_id = 1223, order_num = 0, path = 'sync', component = 'pms/efficiency/sync/index', menu_name = '数据同步'
WHERE menu_id = 1190;

-- ========================================
-- 第12步：隐藏原有的一级菜单（不再直接显示的功能）
-- ========================================
-- 原有的单独菜单项（甘特图、看板等）设为隐藏，这些功能现在集成在项目详情内
UPDATE sys_menu SET visible = '1' WHERE menu_id IN (1152, 1153, 1155);

-- ========================================
-- 第13步：删除或隐藏子菜单项（原有的按钮操作）
-- ========================================
-- 原有的功能菜单项（1140-1151, 1154, 1156, 1158-1163等按钮）保持不变
-- 这些菜单项的 parent_id 已经更新，无需手动修改

-- ========================================
-- 第14步：清理冗余的菜单项（可选）
-- ========================================
-- 原有的 dashboard (1152), gantt (1153), kanban (1155) 作为功能层菜单，仍然保留
-- 但设置为 visible=1 表示不显示在菜单树中（通过项目壳内部路由访问）

COMMIT;

-- ========================================
-- 验证查询
-- ========================================
SELECT '菜单结构重组完成！' AS message;

-- 查看重新组织后的菜单层级
SELECT menu_id, parent_id, menu_name, path, order_num, visible, menu_type FROM sys_menu
WHERE menu_id >= 1138 AND menu_id <= 1229
ORDER BY parent_id, order_num;
