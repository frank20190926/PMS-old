-- 方案A：创建项目经理角色并分配人效中心权限
-- 执行命令: mysql -h 127.0.0.1 -u root -p123456 --default-character-set=utf8mb4 kml-pms < sql/create_pm_role_with_efficiency_permissions.sql

SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- 1. 创建"项目经理"角色
INSERT INTO sys_role (role_name, role_key, role_sort, status, del_flag, create_by, create_time, remark)
VALUES ('项目经理', 'pm', 3, '0', '0', 'admin', NOW(), '项目经理角色，拥有人效中心完整权限');

-- 获取刚创建的角色ID（假设为3，如果已有其他角色需要调整）
SET @pm_role_id = LAST_INSERT_ID();

-- 2. 为项目经理角色分配人效中心菜单权限
-- 人效中心顶级菜单
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (@pm_role_id, 1138);

-- 任务管理模块（1139-1144）
INSERT INTO sys_role_menu (role_id, menu_id) VALUES
(@pm_role_id, 1139), -- 任务管理
(@pm_role_id, 1140), -- 任务查询
(@pm_role_id, 1141), -- 任务新增
(@pm_role_id, 1142), -- 任务修改
(@pm_role_id, 1143), -- 任务删除
(@pm_role_id, 1144); -- 任务导出

-- 日报管理模块（1145-1151）
INSERT INTO sys_role_menu (role_id, menu_id) VALUES
(@pm_role_id, 1145), -- 日报管理
(@pm_role_id, 1146), -- 日报查询
(@pm_role_id, 1147), -- 日报新增
(@pm_role_id, 1148), -- 日报修改
(@pm_role_id, 1149), -- 日报删除
(@pm_role_id, 1150), -- 日报审核
(@pm_role_id, 1151); -- 日报导出

-- PM工作台、甘特图、看板（1152-1156）
INSERT INTO sys_role_menu (role_id, menu_id) VALUES
(@pm_role_id, 1152), -- PM工作台
(@pm_role_id, 1153), -- 甘特图
(@pm_role_id, 1154), -- 甘特图编辑
(@pm_role_id, 1155), -- 任务看板
(@pm_role_id, 1156); -- 看板编辑

-- 周报管理模块（1157-1163）
INSERT INTO sys_role_menu (role_id, menu_id) VALUES
(@pm_role_id, 1157), -- 周报管理
(@pm_role_id, 1158), -- 周报查询
(@pm_role_id, 1159), -- 周报新增
(@pm_role_id, 1160), -- 周报修改
(@pm_role_id, 1161), -- 周报删除
(@pm_role_id, 1162), -- 周报审核
(@pm_role_id, 1163); -- 周报导出

-- 数据同步模块（1190-1196）
INSERT INTO sys_role_menu (role_id, menu_id) VALUES
(@pm_role_id, 1190), -- 数据同步
(@pm_role_id, 1191), -- 同步状态查看
(@pm_role_id, 1192), -- 全量同步
(@pm_role_id, 1193), -- 项目同步
(@pm_role_id, 1194), -- 增量同步
(@pm_role_id, 1195), -- 工时统计
(@pm_role_id, 1196); -- 对比报告

-- 日报审核页面（1197）
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (@pm_role_id, 1197);

-- 3. 使用说明：为用户分配项目经理角色
-- 示例：为 leader 用户分配项目经理角色
-- INSERT INTO sys_user_role (user_id, role_id) VALUES (2, @pm_role_id);

-- 4. 验证查询
SELECT '项目经理角色创建成功！' AS message;
SELECT role_id, role_name, role_key FROM sys_role WHERE role_key = 'pm';
SELECT COUNT(*) AS permission_count FROM sys_role_menu WHERE role_id = @pm_role_id;
