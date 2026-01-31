-- =====================================================
-- 人效中心菜单扁平化脚本
-- 功能：将"我的工作"子菜单提升到人效中心一级
-- 执行时间：2026-01-31
-- =====================================================

-- 1. 获取人效中心的 menu_id
SET @eff_parent_id = (SELECT menu_id FROM sys_menu WHERE menu_name = '人效中心' LIMIT 1);

-- 2. 隐藏"我的工作"父菜单（设置 visible = '1' 表示隐藏）
UPDATE sys_menu
SET visible = '1'
WHERE menu_name = '我的工作'
  AND parent_id = @eff_parent_id;

-- 3. 将子菜单提升到人效中心下
-- 更新"我的任务"
UPDATE sys_menu
SET parent_id = @eff_parent_id, order_num = 2
WHERE menu_name = '我的任务'
  AND EXISTS (SELECT 1 FROM (SELECT menu_id FROM sys_menu WHERE menu_name = '我的工作' AND parent_id = @eff_parent_id) t WHERE sys_menu.parent_id = t.menu_id);

-- 更新"日报填写"
UPDATE sys_menu
SET parent_id = @eff_parent_id, order_num = 3
WHERE menu_name = '日报填写'
  AND EXISTS (SELECT 1 FROM (SELECT menu_id FROM sys_menu WHERE menu_name = '我的工作' AND parent_id = @eff_parent_id) t WHERE sys_menu.parent_id = t.menu_id);

-- 更新"周报填写"
UPDATE sys_menu
SET parent_id = @eff_parent_id, order_num = 4
WHERE menu_name = '周报填写'
  AND EXISTS (SELECT 1 FROM (SELECT menu_id FROM sys_menu WHERE menu_name = '我的工作' AND parent_id = @eff_parent_id) t WHERE sys_menu.parent_id = t.menu_id);

-- 4. 添加日报审核菜单（如果不存在）
INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT '日报审核', @eff_parent_id, 5, 'daily-approve', 'pms/efficiency/daily-report/approve', 1, 0, 'C', '0', '0', 'efficiency:report:approve', 'check', 'admin', NOW(), '日报审核'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM sys_menu
    WHERE menu_name = '日报审核'
      AND parent_id = @eff_parent_id
);

-- 5. 添加人员排期菜单（如果不存在）
INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT '人员排期', @eff_parent_id, 6, 'resource-schedule', 'pms/efficiency/resource/index', 1, 0, 'C', '0', '0', 'efficiency:resource:list', 'peoples', 'admin', NOW(), '人员排期'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM sys_menu
    WHERE menu_name = '人员排期'
      AND parent_id = @eff_parent_id
);

-- 6. 为 PM 角色添加日报审核和人员排期权限
-- 获取新添加菜单的 ID
SET @daily_approve_menu_id = (SELECT menu_id FROM sys_menu WHERE menu_name = '日报审核' AND parent_id = @eff_parent_id LIMIT 1);
SET @resource_menu_id = (SELECT menu_id FROM sys_menu WHERE menu_name = '人员排期' AND parent_id = @eff_parent_id LIMIT 1);

-- 为管理员角色 (role_id = 2) 添加权限
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (2, @daily_approve_menu_id);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (2, @resource_menu_id);

-- 为项目经理角色添加权限 (role_id = 102, 103, 104)
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (102, @daily_approve_menu_id);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (102, @resource_menu_id);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (103, @daily_approve_menu_id);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (103, @resource_menu_id);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (104, @daily_approve_menu_id);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (104, @resource_menu_id);

-- 7. 验证结果
SELECT menu_id, menu_name, parent_id, order_num, path, visible
FROM sys_menu
WHERE parent_id = @eff_parent_id
ORDER BY order_num;
