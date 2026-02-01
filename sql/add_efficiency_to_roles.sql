-- 为各角色添加人效中心权限
-- 执行命令: mysql -h 127.0.0.1 -u root -p123456 --default-character-set=utf8mb4 kml-pms < sql/add_efficiency_to_roles.sql

SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- ========================================
-- 第1步：为管理员角色（role_id=2）添加完整权限
-- ========================================
-- 人效中心顶级菜单
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1138);

-- 任务管理模块（6个）
INSERT INTO sys_role_menu (role_id, menu_id) VALUES
(2, 1139), (2, 1140), (2, 1141), (2, 1142), (2, 1143), (2, 1144);

-- 日报管理模块（7个）
INSERT INTO sys_role_menu (role_id, menu_id) VALUES
(2, 1145), (2, 1146), (2, 1147), (2, 1148), (2, 1149), (2, 1150), (2, 1151);

-- PM工作台/甘特图/看板（5个）
INSERT INTO sys_role_menu (role_id, menu_id) VALUES
(2, 1152), (2, 1153), (2, 1154), (2, 1155), (2, 1156);

-- 周报管理模块（7个）
INSERT INTO sys_role_menu (role_id, menu_id) VALUES
(2, 1157), (2, 1158), (2, 1159), (2, 1160), (2, 1161), (2, 1162), (2, 1163);

-- 数据同步模块（7个）
INSERT INTO sys_role_menu (role_id, menu_id) VALUES
(2, 1190), (2, 1191), (2, 1192), (2, 1193), (2, 1194), (2, 1195), (2, 1196);

-- 日报审核（1个）
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1197);

-- ========================================
-- 第2步：为软件研发经理（role_id=100）添加完整权限
-- ========================================
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (100, 1138);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES
(100, 1139), (100, 1140), (100, 1141), (100, 1142), (100, 1143), (100, 1144);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES
(100, 1145), (100, 1146), (100, 1147), (100, 1148), (100, 1149), (100, 1150), (100, 1151);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES
(100, 1152), (100, 1153), (100, 1154), (100, 1155), (100, 1156);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES
(100, 1157), (100, 1158), (100, 1159), (100, 1160), (100, 1161), (100, 1162), (100, 1163);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES
(100, 1190), (100, 1191), (100, 1192), (100, 1193), (100, 1194), (100, 1195), (100, 1196);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (100, 1197);

-- ========================================
-- 第3步：为三个项目经理角色添加完整权限
-- ========================================
-- 软研一部项目经理（role_id=102）
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (102, 1138);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES
(102, 1139), (102, 1140), (102, 1141), (102, 1142), (102, 1143), (102, 1144),
(102, 1145), (102, 1146), (102, 1147), (102, 1148), (102, 1149), (102, 1150), (102, 1151),
(102, 1152), (102, 1153), (102, 1154), (102, 1155), (102, 1156),
(102, 1157), (102, 1158), (102, 1159), (102, 1160), (102, 1161), (102, 1162), (102, 1163),
(102, 1190), (102, 1191), (102, 1192), (102, 1193), (102, 1194), (102, 1195), (102, 1196),
(102, 1197);

-- 软研二部项目经理（role_id=103）
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (103, 1138);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES
(103, 1139), (103, 1140), (103, 1141), (103, 1142), (103, 1143), (103, 1144),
(103, 1145), (103, 1146), (103, 1147), (103, 1148), (103, 1149), (103, 1150), (103, 1151),
(103, 1152), (103, 1153), (103, 1154), (103, 1155), (103, 1156),
(103, 1157), (103, 1158), (103, 1159), (103, 1160), (103, 1161), (103, 1162), (103, 1163),
(103, 1190), (103, 1191), (103, 1192), (103, 1193), (103, 1194), (103, 1195), (103, 1196),
(103, 1197);

-- 软研三部项目经理（role_id=104）
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (104, 1138);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES
(104, 1139), (104, 1140), (104, 1141), (104, 1142), (104, 1143), (104, 1144),
(104, 1145), (104, 1146), (104, 1147), (104, 1148), (104, 1149), (104, 1150), (104, 1151),
(104, 1152), (104, 1153), (104, 1154), (104, 1155), (104, 1156),
(104, 1157), (104, 1158), (104, 1159), (104, 1160), (104, 1161), (104, 1162), (104, 1163),
(104, 1190), (104, 1191), (104, 1192), (104, 1193), (104, 1194), (104, 1195), (104, 1196),
(104, 1197);

-- ========================================
-- 第4步：为软件研发助理（role_id=101）添加部分权限
-- ========================================
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (101, 1138);
-- 任务管理（查询、查看）
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (101, 1139), (101, 1140);
-- 日报管理（查询、新增、修改）
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (101, 1145), (101, 1146), (101, 1147), (101, 1148);
-- 周报管理（查询、新增、修改）
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (101, 1157), (101, 1158), (101, 1159), (101, 1160);

-- ========================================
-- 第5步：为员工（role_id=106）添加基本权限
-- ========================================
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (106, 1138);
-- 任务管理（仅查询）
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (106, 1139), (106, 1140);
-- 日报管理（查询、新增、修改）
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (106, 1145), (106, 1146), (106, 1147), (106, 1148);

-- ========================================
-- 验证查询
-- ========================================
SELECT '人效中心权限配置完成！' AS message;

-- 查看各角色的人效中心权限数量
SELECT role_id,
       (SELECT role_name FROM sys_role WHERE role_id = srm.role_id) AS role_name,
       COUNT(*) AS efficiency_permissions
FROM sys_role_menu srm
WHERE menu_id >= 1138 AND menu_id <= 1197
GROUP BY role_id
ORDER BY role_id;

-- 查看各角色的总权限数量
SELECT role_id,
       (SELECT role_name FROM sys_role WHERE role_id = srm.role_id) AS role_name,
       COUNT(*) AS total_permissions
FROM sys_role_menu srm
GROUP BY role_id
ORDER BY role_id;
