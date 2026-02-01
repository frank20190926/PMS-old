-- ====================================================================
-- 项目全生命周期跟踪 - 数据表脚本
-- 创建时间: 2026-01-27
-- 模块: 人效中心 > 项目管理
-- ====================================================================

-- 1. 项目阶段配置表
DROP TABLE IF EXISTS `eff_project_phase`;
CREATE TABLE `eff_project_phase` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '阶段ID',
    `project_id` BIGINT NOT NULL COMMENT '项目ID（关联pms_project）',
    `phase_type` VARCHAR(50) NOT NULL COMMENT '阶段类型：REQUIREMENT/DESIGN/FRONTEND/BACKEND/TESTING',
    `phase_name` VARCHAR(100) NOT NULL COMMENT '阶段名称',
    `description` TEXT COMMENT '阶段描述',
    `start_date` DATE COMMENT '计划开始日期',
    `end_date` DATE COMMENT '计划结束日期',
    `actual_start_date` DATE COMMENT '实际开始日期',
    `actual_end_date` DATE COMMENT '实际结束日期',
    `assignee_id` BIGINT COMMENT '负责人ID',
    `status` VARCHAR(50) DEFAULT 'PENDING' COMMENT '状态：PENDING/ACTIVE/COMPLETED/DELAYED',
    `sort_order` INT DEFAULT 0 COMMENT '排序',
    `milestone_task_id` BIGINT COMMENT '关联的里程碑任务ID（eff_task表）',
    `del_flag` CHAR(1) DEFAULT '0' COMMENT '删除标志',
    `create_by` VARCHAR(64) COMMENT '创建者',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_by` VARCHAR(64) COMMENT '更新者',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `remark` VARCHAR(500) COMMENT '备注',
    INDEX `idx_project_id` (`project_id`),
    INDEX `idx_phase_type` (`phase_type`),
    INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='项目阶段配置表';

-- 2. 文档管理表
DROP TABLE IF EXISTS `eff_document`;
CREATE TABLE `eff_document` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '文档ID',
    `project_id` BIGINT NOT NULL COMMENT '项目ID',
    `phase_id` BIGINT COMMENT '阶段ID（关联eff_project_phase）',
    `doc_type` VARCHAR(50) NOT NULL COMMENT '文档类型：REQUIREMENT/DESIGN/MEETING/REVIEW/OTHER',
    `doc_name` VARCHAR(200) NOT NULL COMMENT '文档名称',
    `doc_url` VARCHAR(500) NOT NULL COMMENT '文档存储路径/URL',
    `doc_version` VARCHAR(20) DEFAULT 'v1.0' COMMENT '文档版本号',
    `file_size` BIGINT COMMENT '文件大小（字节）',
    `file_extension` VARCHAR(20) COMMENT '文件扩展名',
    `current_status` VARCHAR(50) DEFAULT 'DRAFT' COMMENT '文档状态：DRAFT/REVIEWING/APPROVED/REJECTED/ARCHIVED',
    `current_assignee` BIGINT COMMENT '当前处理人ID',
    `approved_by` BIGINT COMMENT '批准人ID',
    `approved_time` DATETIME COMMENT '批准时间',
    `reject_reason` TEXT COMMENT '驳回原因',
    `is_final_version` BOOLEAN DEFAULT FALSE COMMENT '是否最终版本',
    `parent_doc_id` BIGINT COMMENT '父文档ID（用于版本历史）',
    `del_flag` CHAR(1) DEFAULT '0' COMMENT '删除标志',
    `create_by` VARCHAR(64) COMMENT '创建者',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_by` VARCHAR(64) COMMENT '更新者',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `remark` VARCHAR(500) COMMENT '备注',
    INDEX `idx_project_id` (`project_id`),
    INDEX `idx_phase_id` (`phase_id`),
    INDEX `idx_doc_type` (`doc_type`),
    INDEX `idx_status` (`current_status`),
    INDEX `idx_parent_doc` (`parent_doc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='文档管理表';

-- 3. 文档评论表
DROP TABLE IF EXISTS `eff_document_comment`;
CREATE TABLE `eff_document_comment` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '评论ID',
    `document_id` BIGINT NOT NULL COMMENT '文档ID（关联eff_document）',
    `parent_comment_id` BIGINT COMMENT '父评论ID（用于回复）',
    `line_number` INT COMMENT '行号（用于行级批注）',
    `content` TEXT NOT NULL COMMENT '评论内容',
    `mentioned_users` VARCHAR(500) COMMENT '提及的用户ID列表（JSON格式）',
    `comment_type` VARCHAR(50) DEFAULT 'COMMENT' COMMENT '评论类型：COMMENT/QUESTION/SUGGESTION/APPROVAL',
    `status` VARCHAR(50) DEFAULT 'OPEN' COMMENT '状态：OPEN/RESOLVED/CLOSED',
    `resolved_by` BIGINT COMMENT '解决人ID',
    `resolved_time` DATETIME COMMENT '解决时间',
    `del_flag` CHAR(1) DEFAULT '0' COMMENT '删除标志',
    `create_by` VARCHAR(64) COMMENT '创建者',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_by` VARCHAR(64) COMMENT '更新者',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX `idx_document_id` (`document_id`),
    INDEX `idx_parent_comment` (`parent_comment_id`),
    INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='文档评论表';

-- 4. 任务生成规则表
DROP TABLE IF EXISTS `eff_task_generation_rule`;
CREATE TABLE `eff_task_generation_rule` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '规则ID',
    `project_id` BIGINT NOT NULL COMMENT '项目ID',
    `rule_name` VARCHAR(100) NOT NULL COMMENT '规则名称',
    `trigger_phase` VARCHAR(50) NOT NULL COMMENT '触发阶段：REQUIREMENT/DESIGN',
    `trigger_condition` VARCHAR(50) DEFAULT 'PHASE_COMPLETED' COMMENT '触发条件：PHASE_COMPLETED/DOC_APPROVED',
    `task_template` JSON COMMENT '任务模板（JSON格式）',
    `auto_generate` BOOLEAN DEFAULT FALSE COMMENT '是否自动生成（false需要PM审核）',
    `is_active` BOOLEAN DEFAULT TRUE COMMENT '规则是否激活',
    `del_flag` CHAR(1) DEFAULT '0' COMMENT '删除标志',
    `create_by` VARCHAR(64) COMMENT '创建者',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_by` VARCHAR(64) COMMENT '更新者',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `remark` VARCHAR(500) COMMENT '备注',
    INDEX `idx_project_id` (`project_id`),
    INDEX `idx_trigger_phase` (`trigger_phase`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='任务生成规则表';

-- 5. 任务生成预览表
DROP TABLE IF EXISTS `eff_task_generation_preview`;
CREATE TABLE `eff_task_generation_preview` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '预览ID',
    `project_id` BIGINT NOT NULL COMMENT '项目ID',
    `phase_id` BIGINT COMMENT '阶段ID',
    `rule_id` BIGINT COMMENT '规则ID',
    `preview_data` JSON NOT NULL COMMENT '预览的任务数据（JSON格式）',
    `status` VARCHAR(50) DEFAULT 'PENDING' COMMENT '状态：PENDING/APPROVED/REJECTED',
    `approved_by` BIGINT COMMENT '审核人ID',
    `approved_time` DATETIME COMMENT '审核时间',
    `generated_task_ids` VARCHAR(1000) COMMENT '生成的任务ID列表（逗号分隔）',
    `del_flag` CHAR(1) DEFAULT '0' COMMENT '删除标志',
    `create_by` VARCHAR(64) COMMENT '创建者',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_by` VARCHAR(64) COMMENT '更新者',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX `idx_project_id` (`project_id`),
    INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='任务生成预览表';

-- ====================================================================
-- 验证脚本
-- ====================================================================
-- SELECT COUNT(*) FROM eff_project_phase;
-- SELECT COUNT(*) FROM eff_document;
-- SELECT COUNT(*) FROM eff_document_comment;
-- SELECT COUNT(*) FROM eff_task_generation_rule;
-- SELECT COUNT(*) FROM eff_task_generation_preview;
