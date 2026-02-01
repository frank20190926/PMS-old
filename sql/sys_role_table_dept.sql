-- =============================================
-- 创建 sys_role_table_dept 表
-- 用于角色-表-部门的数据权限控制
-- =============================================

-- 创建表
CREATE TABLE IF NOT EXISTS `sys_role_table_dept` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `table_name` varchar(100) NOT NULL COMMENT '表名',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `table_name`, `dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色表部门数据权限表';

-- 为现有角色添加默认的数据权限（允许访问所有部门）
-- 这里为每个角色添加对 sys_user 表的部门访问权限

-- 获取所有部门ID并为角色102（软研一部项目经理）添加权限
INSERT IGNORE INTO `sys_role_table_dept` (`role_id`, `table_name`, `dept_id`)
SELECT 102, 'sys_user', dept_id FROM sys_dept WHERE del_flag = '0';

-- 为角色103（软研二部项目经理）添加权限
INSERT IGNORE INTO `sys_role_table_dept` (`role_id`, `table_name`, `dept_id`)
SELECT 103, 'sys_user', dept_id FROM sys_dept WHERE del_flag = '0';

-- 为角色104（软研三部项目经理）添加权限
INSERT IGNORE INTO `sys_role_table_dept` (`role_id`, `table_name`, `dept_id`)
SELECT 104, 'sys_user', dept_id FROM sys_dept WHERE del_flag = '0';

-- 为角色100（软件研发经理）添加权限
INSERT IGNORE INTO `sys_role_table_dept` (`role_id`, `table_name`, `dept_id`)
SELECT 100, 'sys_user', dept_id FROM sys_dept WHERE del_flag = '0';

-- 为角色101（软件研发助理）添加权限
INSERT IGNORE INTO `sys_role_table_dept` (`role_id`, `table_name`, `dept_id`)
SELECT 101, 'sys_user', dept_id FROM sys_dept WHERE del_flag = '0';

-- 为角色106（员工）添加权限
INSERT IGNORE INTO `sys_role_table_dept` (`role_id`, `table_name`, `dept_id`)
SELECT 106, 'sys_user', dept_id FROM sys_dept WHERE del_flag = '0';

-- 为角色2（管理员）添加权限
INSERT IGNORE INTO `sys_role_table_dept` (`role_id`, `table_name`, `dept_id`)
SELECT 2, 'sys_user', dept_id FROM sys_dept WHERE del_flag = '0';

-- 验证数据
SELECT 'sys_role_table_dept 表创建完成' AS message;
SELECT COUNT(*) AS total_records FROM sys_role_table_dept;
