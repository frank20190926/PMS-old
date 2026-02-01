-- 为普通角色添加人效中心菜单权限
-- 执行命令: mysql -h 127.0.0.1 -u root -p123456 --default-character-set=utf8mb4 kml-pms < sql/add_efficiency_permissions_to_common_role.sql

-- 设置字符编码
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- 为普通角色（role_id=2）添加人效中心菜单权限
-- 1138 - 人效中心（顶级菜单）
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1138);

-- 1139 - 任务管理及其子权限
INSERT INTO sys_role_menu (role_id, menu_id) VALUES
(2, 1139), -- 任务管理
(2, 1140), -- 任务查询
(2, 1141), -- 任务新增
(2, 1142), -- 任务修改
(2, 1143), -- 任务删除
(2, 1144); -- 任务导出

-- 1145 - 日报管理及其子权限
INSERT INTO sys_role_menu (role_id, menu_id) VALUES
(2, 1145), -- 日报管理
(2, 1146), -- 日报查询
(2, 1147), -- 日报新增
(2, 1148), -- 日报修改
(2, 1149), -- 日报删除
(2, 1150), -- 日报审核
(2, 1151); -- 日报导出

-- 1152 - PM工作台、甘特图、看板
INSERT INTO sys_role_menu (role_id, menu_id) VALUES
(2, 1152), -- PM工作台
(2, 1153), -- 甘特图
(2, 1154), -- 甘特图编辑
(2, 1155), -- 任务看板
(2, 1156); -- 看板编辑

-- 1157 - 周报管理及其子权限
INSERT INTO sys_role_menu (role_id, menu_id) VALUES
(2, 1157), -- 周报管理
(2, 1158), -- 周报查询
(2, 1159), -- 周报新增
(2, 1160), -- 周报修改
(2, 1161), -- 周报删除
(2, 1162), -- 周报审核
(2, 1163); -- 周报导出

-- 1190 - 数据同步模块
INSERT INTO sys_role_menu (role_id, menu_id) VALUES
(2, 1190), -- 数据同步
(2, 1191), -- 同步状态查看
(2, 1192), -- 全量同步
(2, 1193), -- 项目同步
(2, 1194), -- 增量同步
(2, 1195), -- 工时统计
(2, 1196); -- 对比报告

-- 1197 - 日报审核页面
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1197);

-- 验证查询
SELECT '普通角色权限添加成功！' AS message;
SELECT COUNT(*) AS permission_count FROM sys_role_menu WHERE role_id = 2;
SELECT menu_id,
       (SELECT menu_name FROM sys_menu WHERE menu_id = srm.menu_id) AS menu_name
FROM sys_role_menu srm
WHERE role_id = 2 AND menu_id >= 1138 AND menu_id <= 1197
ORDER BY menu_id;
