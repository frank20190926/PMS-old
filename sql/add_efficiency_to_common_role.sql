-- 为普通角色添加人效中心权限
-- 由于只有leader一个用户拥有普通角色，此操作只影响leader用户
-- 执行命令: mysql -h 127.0.0.1 -u root -p123456 --default-character-set=utf8mb4 kml-pms < sql/add_efficiency_to_common_role.sql

SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- 为普通角色（role_id=2）添加人效中心权限
-- 人效中心顶级菜单
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1138);

-- 任务管理模块
INSERT INTO sys_role_menu (role_id, menu_id) VALUES
(2, 1139), (2, 1140), (2, 1141), (2, 1142), (2, 1143), (2, 1144);

-- 日报管理模块
INSERT INTO sys_role_menu (role_id, menu_id) VALUES
(2, 1145), (2, 1146), (2, 1147), (2, 1148), (2, 1149), (2, 1150), (2, 1151);
