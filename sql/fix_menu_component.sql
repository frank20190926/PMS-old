-- 修复人效中心菜单的 component 配置
-- 问题：父菜单的 component 为 NULL，导致前端无法渲染

USE kml-pms;

-- 1. 修复"人效中心"主菜单 - 使用 Layout
UPDATE sys_menu
SET component = 'Layout'
WHERE menu_id = 1138;

-- 2. 修复"项目生命周期"子菜单 - 使用 ParentView
UPDATE sys_menu
SET component = 'ParentView'
WHERE menu_id = 1198;

-- 3. 验证修复结果
SELECT menu_id, menu_name, component, path, visible
FROM sys_menu
WHERE menu_id IN (1138, 1198);

-- 4. 检查所有子菜单的component配置
SELECT menu_id, menu_name, component, path
FROM sys_menu
WHERE parent_id IN (1138, 1198)
ORDER BY menu_id;
