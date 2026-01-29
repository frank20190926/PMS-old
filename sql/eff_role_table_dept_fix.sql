-- 为 pms_project 补充项目经理角色的数据权限映射
-- 目标：role_id=102（软研一部项目经理）可访问 dept_id=106（研发一部）的项目
INSERT INTO sys_role_table_dept (role_id, table_name, dept_id)
VALUES (102, 'pms_project', 106);
