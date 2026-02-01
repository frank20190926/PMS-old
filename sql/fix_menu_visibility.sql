-- 修复项目生命周期相关菜单的可见性问题
-- 问题：所有新开发的菜单 visible=0，导致前端无法显示

USE kml-pms;

-- 1. 修复"人效中心"主菜单
UPDATE sys_menu SET visible = '1' WHERE menu_id = 1138;

-- 2. 修复"数据同步"菜单
UPDATE sys_menu SET visible = '1' WHERE menu_id = 1190;

-- 3. 修复"项目生命周期"菜单
UPDATE sys_menu SET visible = '1' WHERE menu_id = 1198;

-- 4. 修复"阶段配置"及其子菜单
UPDATE sys_menu SET visible = '1' WHERE menu_id = 1199;
UPDATE sys_menu SET visible = '1' WHERE parent_id = 1199;

-- 5. 修复"文档管理"及其子菜单
UPDATE sys_menu SET visible = '1' WHERE menu_name = '文档管理' AND parent_id = 1198;
UPDATE sys_menu SET visible = '1' WHERE parent_id IN (
    SELECT menu_id FROM (SELECT menu_id FROM sys_menu WHERE menu_name = '文档管理' AND parent_id = 1198) AS tmp
);

-- 6. 修复"任务生成"及其子菜单
UPDATE sys_menu SET visible = '1' WHERE menu_name = '任务生成' AND parent_id = 1198;
UPDATE sys_menu SET visible = '1' WHERE parent_id IN (
    SELECT menu_id FROM (SELECT menu_id FROM sys_menu WHERE menu_name = '任务生成' AND parent_id = 1198) AS tmp
);

-- 7. 修复"流程仪表盘"及其子菜单
UPDATE sys_menu SET visible = '1' WHERE menu_name = '流程仪表盘' AND parent_id = 1198;
UPDATE sys_menu SET visible = '1' WHERE parent_id IN (
    SELECT menu_id FROM (SELECT menu_id FROM sys_menu WHERE menu_name = '流程仪表盘' AND parent_id = 1198) AS tmp
);

-- 8. 批量修复"项目生命周期"下的所有子菜单
UPDATE sys_menu
SET visible = '1'
WHERE parent_id = 1198;

-- 9. 验证修复结果
SELECT menu_id, menu_name, parent_id, visible, path
FROM sys_menu
WHERE menu_id IN (1138, 1190, 1198, 1199)
   OR parent_id IN (1138, 1190, 1198, 1199)
ORDER BY menu_id;
