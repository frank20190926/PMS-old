-- 为超级管理员 (role_id=1) 配置所有菜单权限
-- 问题：超级管理员的sys_role_menu为空，导致后端不返回任何菜单

USE kml-pms;

-- 清空超级管理员的旧权限（如果有）
DELETE FROM sys_role_menu WHERE role_id = 1;

-- 为超级管理员添加所有菜单权限
INSERT INTO sys_role_menu (role_id, menu_id)
SELECT 1, menu_id FROM sys_menu WHERE del_flag = '0';

-- 验证添加结果
SELECT role_id, COUNT(*) as menu_count
FROM sys_role_menu
WHERE role_id = 1
GROUP BY role_id;

-- 确认人效中心菜单被添加了
SELECT '=== 超级管理员的人效中心权限 ===' as info;
SELECT m.menu_id, m.menu_name, m.component
FROM sys_role_menu rm
INNER JOIN sys_menu m ON rm.menu_id = m.menu_id
WHERE rm.role_id = 1
  AND (m.menu_id = 1138 OR m.parent_id = 1138)
ORDER BY m.menu_id
LIMIT 15;
