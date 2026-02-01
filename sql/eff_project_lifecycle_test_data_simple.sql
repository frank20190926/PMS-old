-- ====================================================================
-- 项目全生命周期跟踪 - 简化测试数据脚本
-- 创建时间: 2026-01-27
-- 说明: 生成独立的测试数据，不污染现有功能（使用project_id >= 10000）
-- ====================================================================

-- ====================================================================
-- 1. 测试项目数据（使用新的project_id避免冲突）
-- ====================================================================
INSERT INTO `pms_project` (
    `project_id`, `project_title`, `project_sn`, `user_id`, `project_status`,
    `dept_id`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`
) VALUES
(10001, '【测试】在线教育平台项目', 'TEST-EDU-001', 102, 1, 103, 'admin', NOW(), 'admin', NOW(), '0'),
(10002, '【测试】智能客服系统项目', 'TEST-CS-002', 103, 0, 103, 'admin', NOW(), 'admin', NOW(), '0');

-- ====================================================================
-- 2. 项目阶段配置（2个项目 × 5个阶段 = 10条）
-- ====================================================================
-- 项目10001 - 在线教育平台（5个标准阶段）
INSERT INTO `eff_project_phase` (
    `project_id`, `phase_type`, `phase_name`, `description`,
    `start_date`, `end_date`, `assignee_id`, `status`, `sort_order`,
    `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`
) VALUES
(10001, 'REQUIREMENT', '需求分析', '收集和分析用户需求，编写需求文档',
    '2026-02-01', '2026-02-14', 102, 'COMPLETED', 1, 'admin', NOW(), 'admin', NOW(), '0'),
(10001, 'DESIGN', '产品设计', '设计系统架构和界面原型',
    '2026-02-15', '2026-02-28', 102, 'ACTIVE', 2, 'admin', NOW(), 'admin', NOW(), '0'),
(10001, 'FRONTEND', '前端开发', '前端界面和交互开发',
    '2026-03-01', '2026-03-21', NULL, 'PENDING', 3, 'admin', NOW(), 'admin', NOW(), '0'),
(10001, 'BACKEND', '后端开发', '后端API和业务逻辑开发',
    '2026-03-01', '2026-03-21', NULL, 'PENDING', 4, 'admin', NOW(), 'admin', NOW(), '0'),
(10001, 'TESTING', '测试验收', '系统测试和用户验收',
    '2026-03-22', '2026-04-04', NULL, 'PENDING', 5, 'admin', NOW(), 'admin', NOW(), '0');

-- 项目10002 - 智能客服系统（5个标准阶段）
INSERT INTO `eff_project_phase` (
    `project_id`, `phase_type`, `phase_name`, `description`,
    `start_date`, `end_date`, `assignee_id`, `status`, `sort_order`,
    `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`
) VALUES
(10002, 'REQUIREMENT', '需求分析', '收集和分析客服系统需求',
    '2026-02-10', '2026-02-24', 103, 'PENDING', 1, 'admin', NOW(), 'admin', NOW(), '0'),
(10002, 'DESIGN', '产品设计', '设计系统架构和对话流程',
    NULL, NULL, 103, 'PENDING', 2, 'admin', NOW(), 'admin', NOW(), '0'),
(10002, 'FRONTEND', '前端开发', '前端界面开发',
    NULL, NULL, NULL, 'PENDING', 3, 'admin', NOW(), 'admin', NOW(), '0'),
(10002, 'BACKEND', '后端开发', '后端服务和AI集成',
    NULL, NULL, NULL, 'PENDING', 4, 'admin', NOW(), 'admin', NOW(), '0'),
(10002, 'TESTING', '测试验收', '系统测试和验收',
    NULL, NULL, NULL, 'PENDING', 5, 'admin', NOW(), 'admin', NOW(), '0');

-- 获取阶段ID（用于后续插入）
SET @phase_10001_requirement := (SELECT id FROM eff_project_phase WHERE project_id=10001 AND phase_type='REQUIREMENT');
SET @phase_10001_design := (SELECT id FROM eff_project_phase WHERE project_id=10001 AND phase_type='DESIGN');
SET @phase_10002_requirement := (SELECT id FROM eff_project_phase WHERE project_id=10002 AND phase_type='REQUIREMENT');

-- ====================================================================
-- 3. 文档数据
-- ====================================================================
-- 项目10001 - 需求文档（已批准）
INSERT INTO `eff_document` (
    `project_id`, `phase_id`, `doc_type`, `doc_name`, `doc_url`,
    `doc_version`, `file_size`, `file_extension`, `current_status`,
    `approved_by`, `approved_time`, `is_final_version`, `parent_doc_id`,
    `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`
) VALUES
(10001, @phase_10001_requirement, 'REQUIREMENT', '在线教育平台-需求规格说明书.docx',
    '/documents/requirement/在线教育平台-需求规格说明书-v1.0.docx',
    'v1.0', 2048576, '.docx', 'APPROVED', 102, '2026-02-14 18:00:00', TRUE, NULL,
    'admin', '2026-02-14 10:00:00', 'admin', '2026-02-14 18:00:00', '0');

-- 项目10001 - 设计文档（审核中）
INSERT INTO `eff_document` (
    `project_id`, `phase_id`, `doc_type`, `doc_name`, `doc_url`,
    `doc_version`, `file_size`, `file_extension`, `current_status`,
    `current_assignee`, `is_final_version`, `parent_doc_id`,
    `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`
) VALUES
(10001, @phase_10001_design, 'DESIGN', '在线教育平台-系统设计文档.docx',
    '/documents/design/在线教育平台-系统设计文档-v1.0.docx',
    'v1.0', 3145728, '.docx', 'REVIEWING', 102, FALSE, NULL,
    'admin', '2026-02-20 14:00:00', 'admin', '2026-02-20 14:00:00', '0');

-- 项目10001 - 会议记录（草稿）
INSERT INTO `eff_document` (
    `project_id`, `phase_id`, `doc_type`, `doc_name`, `doc_url`,
    `doc_version`, `file_size`, `file_extension`, `current_status`,
    `is_final_version`, `parent_doc_id`,
    `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`
) VALUES
(10001, @phase_10001_design, 'MEETING', '项目启动会议记录.md',
    '/documents/meeting/项目启动会议记录.md',
    'v1.0', 8192, '.md', 'DRAFT', FALSE, NULL,
    'admin', '2026-02-15 11:00:00', 'admin', '2026-02-15 11:00:00', '0');

-- 项目10002 - 需求文档（草稿）
INSERT INTO `eff_document` (
    `project_id`, `phase_id`, `doc_type`, `doc_name`, `doc_url`,
    `doc_version`, `file_size`, `file_extension`, `current_status`,
    `is_final_version`, `parent_doc_id`,
    `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`
) VALUES
(10002, @phase_10002_requirement, 'REQUIREMENT', '智能客服系统-需求文档.docx',
    '/documents/requirement/智能客服系统-需求文档-v1.0.docx',
    'v1.0', 1572864, '.docx', 'DRAFT', FALSE, NULL,
    'admin', '2026-02-15 09:00:00', 'admin', '2026-02-15 09:00:00', '0');

-- 获取文档ID
SET @doc_10001_design := (SELECT id FROM eff_document WHERE project_id=10001 AND doc_type='DESIGN' AND doc_name='在线教育平台-系统设计文档.docx');

-- ====================================================================
-- 4. 文档评论数据
-- ====================================================================
INSERT INTO `eff_document_comment` (
    `document_id`, `parent_comment_id`, `line_number`, `content`,
    `mentioned_users`, `comment_type`, `status`,
    `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`
) VALUES
-- 设计文档的评论
(@doc_10001_design, NULL, NULL, '整体设计方案很完整，架构清晰 @user102',
    '[102]', 'APPROVAL', 'OPEN', 'admin', '2026-02-21 10:00:00', 'admin', '2026-02-21 10:00:00', '0'),
(@doc_10001_design, NULL, 35, '这里的数据库设计需要优化，建议添加索引',
    NULL, 'SUGGESTION', 'OPEN', 'admin', '2026-02-21 11:30:00', 'admin', '2026-02-21 11:30:00', '0'),
(@doc_10001_design, NULL, NULL, '前端技术栈选型是否确定？建议使用Vue3 @user103',
    '[103]', 'QUESTION', 'OPEN', 'admin', '2026-02-21 14:00:00', 'admin', '2026-02-21 14:00:00', '0');

-- ====================================================================
-- 5. 任务生成规则
-- ====================================================================
INSERT INTO `eff_task_generation_rule` (
    `project_id`, `rule_name`, `trigger_phase`, `trigger_condition`,
    `task_template`, `auto_generate`, `is_active`,
    `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `remark`
) VALUES
(10001, '设计文档批准后自动生成开发任务', 'DESIGN', 'DOC_APPROVED',
    '{"default_hours": 8, "task_types": ["DAILY"]}', FALSE, TRUE,
    'admin', '2026-02-15 10:00:00', 'admin', '2026-02-15 10:00:00', '0', '需要PM审核'),
(10002, '设计文档批准后自动生成任务（无需审核）', 'DESIGN', 'DOC_APPROVED',
    '{"default_hours": 10, "task_types": ["DAILY"]}', TRUE, TRUE,
    'admin', '2026-02-15 10:00:00', 'admin', '2026-02-15 10:00:00', '0', '自动生成无需审核');

-- ====================================================================
-- 验证脚本
-- ====================================================================
-- SELECT * FROM pms_project WHERE project_id >= 10000;
-- SELECT * FROM eff_project_phase WHERE project_id >= 10000;
-- SELECT * FROM eff_document WHERE project_id >= 10000;
-- SELECT * FROM eff_document_comment WHERE document_id IN (SELECT id FROM eff_document WHERE project_id >= 10000);
-- SELECT * FROM eff_task_generation_rule WHERE project_id >= 10000;
