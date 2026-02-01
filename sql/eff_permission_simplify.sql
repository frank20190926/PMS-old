-- 权限简化：30+ 细粒度权限 → 5 个核心权限
-- 新权限体系:
--   efficiency:project:manage  - 项目管理（阶段配置、流程管理）
--   efficiency:document:manage - 文档管理（上传、审批）
--   efficiency:task:manage     - 任务管理（创建、分配、任务生成）
--   efficiency:report:submit   - 报告提交（日报、周报填写）
--   efficiency:report:approve  - 报告审批（日报审核、周报审批）

-- 1. 插入新的权限菜单（按钮级别, menu_type='F'）
-- 找到人效中心父菜单ID
SET @effMenuId = (SELECT menu_id FROM sys_menu WHERE menu_name = '人效中心' LIMIT 1);

-- 插入5个核心权限按钮
INSERT INTO sys_menu (menu_name, parent_id, order_num, perms, menu_type, visible, status, create_time)
VALUES
('项目管理权限', IFNULL(@effMenuId, 0), 1, 'efficiency:project:manage', 'F', '0', '0', NOW()),
('文档管理权限', IFNULL(@effMenuId, 0), 2, 'efficiency:document:manage', 'F', '0', '0', NOW()),
('任务管理权限', IFNULL(@effMenuId, 0), 3, 'efficiency:task:manage', 'F', '0', '0', NOW()),
('报告提交权限', IFNULL(@effMenuId, 0), 4, 'efficiency:report:submit', 'F', '0', '0', NOW()),
('报告审批权限', IFNULL(@effMenuId, 0), 5, 'efficiency:report:approve', 'F', '0', '0', NOW());

-- 2. 为管理员角色(role_id=2)分配所有5个权限
INSERT INTO sys_role_menu (role_id, menu_id)
SELECT 2, menu_id FROM sys_menu WHERE perms IN (
    'efficiency:project:manage', 'efficiency:document:manage',
    'efficiency:task:manage', 'efficiency:report:submit', 'efficiency:report:approve'
);

-- 3. 为项目经理角色(role_id=102,103,104)分配所有5个权限
INSERT INTO sys_role_menu (role_id, menu_id)
SELECT r.role_id, m.menu_id
FROM (SELECT 102 AS role_id UNION SELECT 103 UNION SELECT 104) r
CROSS JOIN sys_menu m
WHERE m.perms IN (
    'efficiency:project:manage', 'efficiency:document:manage',
    'efficiency:task:manage', 'efficiency:report:submit', 'efficiency:report:approve'
);

-- 4. 为员工角色(role_id=106)分配提交权限
INSERT INTO sys_role_menu (role_id, menu_id)
SELECT 106, menu_id FROM sys_menu WHERE perms IN (
    'efficiency:report:submit'
);

-- 5. 为助理角色(role_id=101)分配提交+任务查看权限
INSERT INTO sys_role_menu (role_id, menu_id)
SELECT 101, menu_id FROM sys_menu WHERE perms IN (
    'efficiency:task:manage', 'efficiency:report:submit'
);
