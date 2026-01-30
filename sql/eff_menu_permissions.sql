-- 人效中心菜单权限配置
-- 根据角色分配菜单访问权限
-- 执行命令: mysql -h 127.0.0.1 -u root -p123456 --default-character-set=utf8mb4 kml-pms < sql/eff_menu_permissions.sql

SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- ========================================
-- 第1步：清理现有人效中心权限（可选）
-- ========================================
-- 如果需要重新配置，可以先清理旧权限
-- DELETE FROM sys_role_menu WHERE menu_id >= 1138 AND menu_id <= 1229;

-- ========================================
-- 第2步：为超级管理员（role_id=1）配置全部权限
-- ========================================
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES
-- 人效中心根菜单
(1, 1138),
-- 工作台
(1, 1219),
-- 我的工作目录及子菜单
(1, 1220), (1, 1139), (1, 1145), (1, 1157),
-- 项目管理目录及子菜单
(1, 1221), (1, 1218), (1, 1197), (1, 1224),
-- 部门管理目录及子菜单
(1, 1222), (1, 1225), (1, 1226), (1, 1227), (1, 1228), (1, 1229),
-- 系统管理目录及子菜单
(1, 1223), (1, 1190);

-- 为超级管理员添加所有功能按钮权限
INSERT IGNORE INTO sys_role_menu (role_id, menu_id)
SELECT 1, menu_id FROM sys_menu WHERE menu_id >= 1140 AND menu_id <= 1196;

-- ========================================
-- 第3步：为管理员（role_id=2）配���全部权限
-- ========================================
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES
-- 人效中心根菜单
(2, 1138),
-- 工���台
(2, 1219),
-- 我的工作目录及子菜单
(2, 1220), (2, 1139), (2, 1145), (2, 1157),
-- 项目管理目录及子菜单
(2, 1221), (2, 1218), (2, 1197), (2, 1224),
-- 部门管理目录及子菜单
(2, 1222), (2, 1225), (2, 1226), (2, 1227), (2, 1228), (2, 1229),
-- 系统管理目录及子菜单
(2, 1223), (2, 1190);

-- 为管理员添加所有功能按钮权限
INSERT IGNORE INTO sys_role_menu (role_id, menu_id)
SELECT 2, menu_id FROM sys_menu WHERE menu_id >= 1140 AND menu_id <= 1196;

-- ========================================
-- 第4步：为软件研发经理（role_id=100, 部门负责人）配置权限
-- ========================================
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES
-- 人效中心根菜单
(100, 1138),
-- 工作台
(100, 1219),
-- 我的工作目录及子菜单
(100, 1220), (100, 1139), (100, 1145), (100, 1157),
-- 项目管理目录及子菜单
(100, 1221), (100, 1218), (100, 1197), (100, 1224),
-- 部门管理目录及子菜单
(100, 1222), (100, 1225), (100, 1226), (100, 1227), (100, 1228), (100, 1229);

-- 为部门负责人添加任务、日报、周报、项目的功能按钮权限
INSERT IGNORE INTO sys_role_menu (role_id, menu_id)
SELECT 100, menu_id FROM sys_menu WHERE menu_id IN (1140, 1141, 1142, 1143, 1144, 1146, 1147, 1148, 1149, 1150, 1151, 1158, 1159, 1160, 1161, 1162, 1163);

-- ========================================
-- ���5步：为项目经理角色（role_id=102/103/104）配置权限
-- ========================================
-- 软研一部项目经理（role_id=102）
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES
-- 人效中心根菜单
(102, 1138),
-- 工作台
(102, 1219),
-- 我的工作目录及子菜单
(102, 1220), (102, 1139), (102, 1145), (102, 1157),
-- 项目管理目录及子菜单
(102, 1221), (102, 1218), (102, 1197), (102, 1224);

-- 软研二部项目经理（role_id=103）
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES
(103, 1138), (103, 1219),
(103, 1220), (103, 1139), (103, 1145), (103, 1157),
(103, 1221), (103, 1218), (103, 1197), (103, 1224);

-- 软研三部项目经理（role_id=104）
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES
(104, 1138), (104, 1219),
(104, 1220), (104, 1139), (104, 1145), (104, 1157),
(104, 1221), (104, 1218), (104, 1197), (104, 1224);

-- 为三个项目经理添加任务、日报、周报的功能按钮权限
INSERT IGNORE INTO sys_role_menu (role_id, menu_id)
SELECT role_id, menu_id FROM (
    SELECT 102 AS role_id UNION SELECT 103 UNION SELECT 104
) AS roles CROSS JOIN (
    SELECT menu_id FROM sys_menu WHERE menu_id IN (1140, 1141, 1142, 1143, 1144, 1146, 1147, 1148, 1149, 1150, 1151, 1158, 1159, 1160, 1161, 1162, 1163)
) AS menus;

-- ========================================
-- 第6步：为软件研发助理（role_id=101, PM角色）配置权限
-- ========================================
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES
-- 人效中心根菜单
(101, 1138),
-- 工作台
(101, 1219),
-- 我的工作目录及子菜单
(101, 1220), (101, 1139), (101, 1145), (101, 1157),
-- 项目管理目录及子菜单
(101, 1221), (101, 1218), (101, 1197), (101, 1224);

-- 为软件研发助理添加部分功能按钮权限（查看、提交、编辑）
INSERT IGNORE INTO sys_role_menu (role_id, menu_id)
SELECT 101, menu_id FROM sys_menu WHERE menu_id IN (1140, 1146, 1147, 1148, 1158, 1159, 1160);

-- ========================================
-- 第7步：为员工（role_id=106）配置基本权限
-- ========================================
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES
-- 人效中心根菜单
(106, 1138),
-- 工作台
(106, 1219),
-- 我的工作目录及子菜单
(106, 1220), (106, 1139), (106, 1145), (106, 1157);

-- 为员工添加基本功能按钮权限（查看任务、提交日报和周报）
INSERT IGNORE INTO sys_role_menu (role_id, menu_id)
SELECT 106, menu_id FROM sys_menu WHERE menu_id IN (1140, 1146, 1147, 1148, 1158, 1159, 1160);

COMMIT;

-- ========================================
-- 验证查询
-- ========================================
SELECT '人效中心菜单权限配置完成！' AS message;

-- 查看各角色的人效中心权限统计
SELECT r.role_id, r.role_name, r.role_key, COUNT(srm.menu_id) AS menu_count
FROM sys_role r
LEFT JOIN sys_role_menu srm ON r.role_id = srm.role_id AND srm.menu_id >= 1138 AND srm.menu_id <= 1229
WHERE r.del_flag = '0'
GROUP BY r.role_id, r.role_name, r.role_key
ORDER BY r.role_id;

-- 详细权限列表（可选）
SELECT r.role_name, r.role_key, m.menu_id, m.menu_name, m.parent_id, m.menu_type
FROM sys_role r
JOIN sys_role_menu srm ON r.role_id = srm.role_id
JOIN sys_menu m ON srm.menu_id = m.menu_id
WHERE r.del_flag = '0' AND m.menu_id >= 1138 AND m.menu_id <= 1229
ORDER BY r.role_id, m.parent_id, m.order_num;
