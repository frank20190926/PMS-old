-- 创建项目成员表
CREATE TABLE IF NOT EXISTS `pms_project_member` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `project_id` bigint(20) NOT NULL COMMENT '项目ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role` varchar(50) DEFAULT NULL COMMENT '项目角色（PM/成员等）',
  `join_date` datetime DEFAULT NULL COMMENT '加入日期',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_project_user` (`project_id`, `user_id`),
  KEY `idx_project_id` (`project_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='项目成员表';

-- 从现有数据自动填充项目成员（基于排期表）
INSERT INTO pms_project_member (project_id, user_id, role, status, create_time)
SELECT DISTINCT
    ps.project_id,
    ps.sched_user_id as user_id,
    '成员' as role,
    '0' as status,
    NOW() as create_time
FROM pms_project_staff_sched ps
WHERE ps.project_id IS NOT NULL
  AND ps.sched_user_id IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM pms_project_member pm
    WHERE pm.project_id = ps.project_id AND pm.user_id = ps.sched_user_id
  );

-- 添加项目经理到项目成员表（基于项目表）
INSERT INTO pms_project_member (project_id, user_id, role, status, create_time)
SELECT DISTINCT
    p.project_id as project_id,
    p.user_id as user_id,
    '项目经理' as role,
    '0' as status,
    NOW() as create_time
FROM pms_project p
WHERE p.user_id IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM pms_project_member pm
    WHERE pm.project_id = p.project_id AND pm.user_id = p.user_id
  );
