-- ====================================================================
-- 项目全生命周期跟踪 - 权限菜单配置脚本
-- 创建时间: 2026-01-27
-- 说明: 为PM角色和管理员角色配置项目生命周期管理的权限
-- ====================================================================

-- 获取当前最大的menu_id（用于插入新菜单）
SET @max_menu_id := (SELECT MAX(menu_id) FROM sys_menu);

-- ====================================================================
-- 1. 插入主菜单：项目生命周期
-- ====================================================================
INSERT INTO `sys_menu` (
    `menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`,
    `is_frame`, `is_cache`, `menu_type`, `visible`, `status`,
    `perms`, `icon`, `create_time`, `remark`
) VALUES (
    @max_menu_id + 1, '项目生命周期', (SELECT menu_id FROM sys_menu WHERE menu_name = '人效中心'),
    5, 'project', NULL, 1, 0, 'M', '0', '0', '',
    'el-icon-project', NOW(), '项目全生命周期管理'
);

SET @lifecycle_menu_id := @max_menu_id + 1;

-- ====================================================================
-- 2. 项目阶段管理菜单和权限
-- ====================================================================
INSERT INTO `sys_menu` (
    `menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`,
    `is_frame`, `is_cache`, `menu_type`, `visible`, `status`,
    `perms`, `icon`, `create_time`, `remark`
) VALUES (
    @lifecycle_menu_id + 1, '阶段配置', @lifecycle_menu_id, 1,
    'phase', 'pms/efficiency/project/phase/index', 1, 0, 'C', '0', '0',
    'pms:efficiency:project:phase:list', 'el-icon-management', NOW(), '项目阶段配置'
);

SET @phase_menu_id := @lifecycle_menu_id + 1;

-- 阶段权限
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`,
    `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_time`) VALUES
(@phase_menu_id + 1, '阶段查询', @phase_menu_id, 1, '', '', 1, 0, 'F', '0', '0',
    'pms:efficiency:project:phase:query', '#', NOW()),
(@phase_menu_id + 2, '阶段新增', @phase_menu_id, 2, '', '', 1, 0, 'F', '0', '0',
    'pms:efficiency:project:phase:add', '#', NOW()),
(@phase_menu_id + 3, '阶段修改', @phase_menu_id, 3, '', '', 1, 0, 'F', '0', '0',
    'pms:efficiency:project:phase:edit', '#', NOW()),
(@phase_menu_id + 4, '阶段删除', @phase_menu_id, 4, '', '', 1, 0, 'F', '0', '0',
    'pms:efficiency:project:phase:remove', '#', NOW()),
(@phase_menu_id + 5, '阶段导出', @phase_menu_id, 5, '', '', 1, 0, 'F', '0', '0',
    'pms:efficiency:project:phase:export', '#', NOW());

-- ====================================================================
-- 3. 文档管理菜单和权限
-- ====================================================================
INSERT INTO `sys_menu` (
    `menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`,
    `is_frame`, `is_cache`, `menu_type`, `visible`, `status`,
    `perms`, `icon`, `create_time`, `remark`
) VALUES (
    @phase_menu_id + 6, '文档管理', @lifecycle_menu_id, 2,
    'document', 'pms/efficiency/project/document/index', 1, 0, 'C', '0', '0',
    'pms:efficiency:project:document:list', 'el-icon-document', NOW(), '项目文档管理'
);

SET @document_menu_id := @phase_menu_id + 6;

-- 文档权限
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`,
    `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_time`) VALUES
(@document_menu_id + 1, '文档查询', @document_menu_id, 1, '', '', 1, 0, 'F', '0', '0',
    'pms:efficiency:project:document:query', '#', NOW()),
(@document_menu_id + 2, '文档上传', @document_menu_id, 2, '', '', 1, 0, 'F', '0', '0',
    'pms:efficiency:project:document:add', '#', NOW()),
(@document_menu_id + 3, '文档修改', @document_menu_id, 3, '', '', 1, 0, 'F', '0', '0',
    'pms:efficiency:project:document:edit', '#', NOW()),
(@document_menu_id + 4, '文档删除', @document_menu_id, 4, '', '', 1, 0, 'F', '0', '0',
    'pms:efficiency:project:document:remove', '#', NOW()),
(@document_menu_id + 5, '文档批准', @document_menu_id, 5, '', '', 1, 0, 'F', '0', '0',
    'pms:efficiency:project:document:approve', '#', NOW()),
(@document_menu_id + 6, '文档导出', @document_menu_id, 6, '', '', 1, 0, 'F', '0', '0',
    'pms:efficiency:project:document:export', '#', NOW());

-- ====================================================================
-- 4. 任务生成菜单和权限
-- ====================================================================
INSERT INTO `sys_menu` (
    `menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`,
    `is_frame`, `is_cache`, `menu_type`, `visible`, `status`,
    `perms`, `icon`, `create_time`, `remark`
) VALUES (
    @document_menu_id + 7, '任务生成', @lifecycle_menu_id, 3,
    'task-generation', 'pms/efficiency/project/task-generation/preview', 1, 0, 'C', '0', '0',
    'pms:efficiency:task-generation:list', 'el-icon-ticket', NOW(), '任务自动生成管理'
);

SET @task_generation_menu_id := @document_menu_id + 7;

-- 任务生成权限
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`,
    `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_time`) VALUES
(@task_generation_menu_id + 1, '生成查询', @task_generation_menu_id, 1, '', '', 1, 0, 'F', '0', '0',
    'pms:efficiency:task-generation:query', '#', NOW()),
(@task_generation_menu_id + 2, '预览编辑', @task_generation_menu_id, 2, '', '', 1, 0, 'F', '0', '0',
    'pms:efficiency:task-generation:edit', '#', NOW()),
(@task_generation_menu_id + 3, '生成批准', @task_generation_menu_id, 3, '', '', 1, 0, 'F', '0', '0',
    'pms:efficiency:task-generation:approve', '#', NOW()),
(@task_generation_menu_id + 4, '生成驳回', @task_generation_menu_id, 4, '', '', 1, 0, 'F', '0', '0',
    'pms:efficiency:task-generation:reject', '#', NOW());

-- ====================================================================
-- 5. 项目流程菜单和权限
-- ====================================================================
INSERT INTO `sys_menu` (
    `menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`,
    `is_frame`, `is_cache`, `menu_type`, `visible`, `status`,
    `perms`, `icon`, `create_time`, `remark`
) VALUES (
    @task_generation_menu_id + 5, '流程仪表盘', @lifecycle_menu_id, 4,
    'workflow', 'pms/efficiency/project/workflow/index', 1, 0, 'C', '0', '0',
    'pms:efficiency:project:workflow:query', 'el-icon-s-promotion', NOW(), '项目流程状态跟踪'
);

-- ====================================================================
-- 6. 为PM角色（role_id=102/103/104）分配权限
-- ====================================================================
-- 软研一部项目经理 (role_id=102)
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES
(102, @lifecycle_menu_id),
(102, @phase_menu_id), (102, @phase_menu_id + 1), (102, @phase_menu_id + 2),
(102, @phase_menu_id + 3), (102, @phase_menu_id + 4), (102, @phase_menu_id + 5),
(102, @document_menu_id), (102, @document_menu_id + 1), (102, @document_menu_id + 2),
(102, @document_menu_id + 3), (102, @document_menu_id + 4), (102, @document_menu_id + 5),
(102, @document_menu_id + 6), (102, @task_generation_menu_id), (102, @task_generation_menu_id + 1),
(102, @task_generation_menu_id + 2), (102, @task_generation_menu_id + 3), (102, @task_generation_menu_id + 4),
(102, @task_generation_menu_id + 5);

-- 软研二部项目经理 (role_id=103)
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES
(103, @lifecycle_menu_id),
(103, @phase_menu_id), (103, @phase_menu_id + 1), (103, @phase_menu_id + 2),
(103, @phase_menu_id + 3), (103, @phase_menu_id + 4), (103, @phase_menu_id + 5),
(103, @document_menu_id), (103, @document_menu_id + 1), (103, @document_menu_id + 2),
(103, @document_menu_id + 3), (103, @document_menu_id + 4), (103, @document_menu_id + 5),
(103, @document_menu_id + 6), (103, @task_generation_menu_id), (103, @task_generation_menu_id + 1),
(103, @task_generation_menu_id + 2), (103, @task_generation_menu_id + 3), (103, @task_generation_menu_id + 4),
(103, @task_generation_menu_id + 5);

-- 软研三部项目经理 (role_id=104)
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES
(104, @lifecycle_menu_id),
(104, @phase_menu_id), (104, @phase_menu_id + 1), (104, @phase_menu_id + 2),
(104, @phase_menu_id + 3), (104, @phase_menu_id + 4), (104, @phase_menu_id + 5),
(104, @document_menu_id), (104, @document_menu_id + 1), (104, @document_menu_id + 2),
(104, @document_menu_id + 3), (104, @document_menu_id + 4), (104, @document_menu_id + 5),
(104, @document_menu_id + 6), (104, @task_generation_menu_id), (104, @task_generation_menu_id + 1),
(104, @task_generation_menu_id + 2), (104, @task_generation_menu_id + 3), (104, @task_generation_menu_id + 4),
(104, @task_generation_menu_id + 5);

-- 管理员 (role_id=2) - 拥有所有权限
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES
(2, @lifecycle_menu_id),
(2, @phase_menu_id), (2, @phase_menu_id + 1), (2, @phase_menu_id + 2),
(2, @phase_menu_id + 3), (2, @phase_menu_id + 4), (2, @phase_menu_id + 5),
(2, @document_menu_id), (2, @document_menu_id + 1), (2, @document_menu_id + 2),
(2, @document_menu_id + 3), (2, @document_menu_id + 4), (2, @document_menu_id + 5),
(2, @document_menu_id + 6), (2, @task_generation_menu_id), (2, @task_generation_menu_id + 1),
(2, @task_generation_menu_id + 2), (2, @task_generation_menu_id + 3), (2, @task_generation_menu_id + 4),
(2, @task_generation_menu_id + 5);

-- ====================================================================
-- 验证脚本
-- ====================================================================
-- SELECT * FROM sys_menu WHERE menu_name LIKE '项目生命周期%' OR menu_name LIKE '%阶段%' OR menu_name LIKE '%文档%';
-- SELECT * FROM sys_role_menu WHERE role_id IN (102, 103, 104, 2) ORDER BY role_id;
