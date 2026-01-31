-- 项目流程模块 UX 优化 - 菜单更新脚本
-- 执行时间：2026-01-31
-- 说明：合并流程仪表盘到项目概览，优化菜单结构

-- 1. 更新菜单名称："项目生命周期" → "项目流程"
UPDATE sys_menu
SET menu_name = '项目流程'
WHERE menu_name = '项目生命周期'
  AND menu_type = 'M';

-- 2. 隐藏流程仪表盘菜单（功能已合并到项目概览）
-- visible = '1' 表示隐藏，'0' 表示显示
UPDATE sys_menu
SET visible = '1'
WHERE (menu_name = '流程仪表' OR menu_name = '流程总览' OR menu_name = '流程仪表盘')
  AND parent_id IN (
    SELECT menu_id FROM sys_menu WHERE menu_name = '项目流程'
  );

-- 3. 更新子菜单顺序
-- 阶段配置 -> 1
UPDATE sys_menu
SET order_num = 1
WHERE menu_name = '阶段配置'
  AND parent_id IN (
    SELECT menu_id FROM sys_menu WHERE menu_name = '项目流程'
  );

-- 文档管理 -> 2
UPDATE sys_menu
SET order_num = 2
WHERE menu_name = '文档管理'
  AND parent_id IN (
    SELECT menu_id FROM sys_menu WHERE menu_name = '项目流程'
  );

-- 任务生成 -> 3
UPDATE sys_menu
SET order_num = 3
WHERE menu_name = '任务生成'
  AND parent_id IN (
    SELECT menu_id FROM sys_menu WHERE menu_name = '项目流程'
  );

-- 验证更新结果
SELECT
  menu_id,
  menu_name,
  parent_id,
  order_num,
  visible,
  perms
FROM sys_menu
WHERE menu_name IN ('项目流程', '阶段配置', '文档管理', '任务生成', '流程仪表', '流程总览', '流程仪表盘')
ORDER BY parent_id, order_num;
