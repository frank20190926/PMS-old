-- ====================================================================
-- 项目全生命周期跟踪 - 测试数据脚本
-- 创建时间: 2026-01-27
-- 说明: 生成独立的测试数据，不污染现有功能（使用project_id >= 10000）
-- ====================================================================

-- ====================================================================
-- 1. 测试项目数据（使用新的project_id避免冲突）
-- ====================================================================
INSERT INTO `pms_project` (
    `project_id`, `project_title`, `user_id`, `project_status`,
    `dept_id`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`
) VALUES
(10001, '【测试】在线教育平台项目', 102, 1, 103, 'admin', NOW(), 'admin', NOW(), '0'),
(10002, '【测试】智能客服系统项目', 103, 0, 103, 'admin', NOW(), 'admin', NOW(), '0');

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
(10002, 'TESTING', '测试验收', '功能测试和性能测试',
    NULL, NULL, NULL, 'PENDING', 5, 'admin', NOW(), 'admin', NOW(), '0');

-- ====================================================================
-- 3. 文档管理（6条测试文档，不同阶段和状态）
-- ====================================================================
-- 项目10001 - 需求文档（已批准）
INSERT INTO `eff_document` (
    `project_id`, `phase_id`, `doc_type`, `doc_name`, `doc_url`,
    `doc_version`, `file_size`, `file_extension`, `current_status`,
    `approved_by`, `approved_time`, `is_final_version`, `parent_doc_id`,
    `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`
) VALUES
(10001, (SELECT id FROM eff_project_phase WHERE project_id=10001 AND phase_type='REQUIREMENT'),
    'REQUIREMENT', '在线教育平台-需求规格说明书v2.0.docx',
    'https://test-oss-bucket.oss-cn-shanghai.aliyuncs.com/docs/10001/requirement_v2.0.docx',
    'v2.0', 2048576, '.docx', 'APPROVED', 102, '2026-02-14 18:00:00', TRUE, NULL,
    'admin', '2026-02-14 17:30:00', 'admin', '2026-02-14 18:00:00', '0');

-- 项目10001 - 需求文档（旧版本）
INSERT INTO `eff_document` (
    `project_id`, `phase_id`, `doc_type`, `doc_name`, `doc_url`,
    `doc_version`, `file_size`, `file_extension`, `current_status`,
    `approved_by`, `approved_time`, `is_final_version`, `parent_doc_id`,
    `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`
) VALUES
(10001, (SELECT id FROM eff_project_phase WHERE project_id=10001 AND phase_type='REQUIREMENT'),
    'REQUIREMENT', '在线教育平台-需求规格说明书v1.0.docx',
    'https://test-oss-bucket.oss-cn-shanghai.aliyuncs.com/docs/10001/requirement_v1.0.docx',
    'v1.0', 1835008, '.docx', 'ARCHIVED', NULL, NULL, FALSE,
    (SELECT id FROM eff_document WHERE doc_name='在线教育平台-需求规格说明书v2.0.docx'),
    'admin', '2026-02-10 10:00:00', 'admin', '2026-02-10 10:00:00', '0');

-- 项目10001 - 设计文档（审核中）
INSERT INTO `eff_document` (
    `project_id`, `phase_id`, `doc_type`, `doc_name`, `doc_url`,
    `doc_version`, `file_size`, `file_extension`, `current_status`,
    `current_assignee`, `is_final_version`, `parent_doc_id`,
    `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`
) VALUES
(10001, (SELECT id FROM eff_project_phase WHERE project_id=10001 AND phase_type='DESIGN'),
    'DESIGN', '在线教育平台-系统设计文档v1.0.docx',
    'https://test-oss-bucket.oss-cn-shanghai.aliyuncs.com/docs/10001/design_v1.0.docx',
    'v1.0', 3145728, '.docx', 'REVIEWING', 102, FALSE, NULL,
    'admin', NOW(), 'admin', NOW(), '0');

-- 项目10001 - 接口文档（草稿）
INSERT INTO `eff_document` (
    `project_id`, `phase_id`, `doc_type`, `doc_name`, `doc_url`,
    `doc_version`, `file_size`, `file_extension`, `current_status`,
    `is_final_version`, `parent_doc_id`,
    `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`
) VALUES
(10001, (SELECT id FROM eff_project_phase WHERE project_id=10001 AND phase_type='DESIGN'),
    'OTHER', '在线教育平台-API接口文档.md',
    'https://test-oss-bucket.oss-cn-shanghai.aliyuncs.com/docs/10001/api_design.md',
    'v1.0', 102400, '.md', 'DRAFT', FALSE, NULL,
    'admin', NOW(), 'admin', NOW(), '0');

-- 项目10002 - 需求文档（草稿）
INSERT INTO `eff_document` (
    `project_id`, `phase_id`, `doc_type`, `doc_name`, `doc_url`,
    `doc_version`, `file_size`, `file_extension`, `current_status`,
    `is_final_version`, `parent_doc_id`,
    `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`
) VALUES
(10002, (SELECT id FROM eff_project_phase WHERE project_id=10002 AND phase_type='REQUIREMENT'),
    'REQUIREMENT', '智能客服系统-需求文档v1.0.docx',
    'https://test-oss-bucket.oss-cn-shanghai.aliyuncs.com/docs/10002/requirement_v1.0.docx',
    'v1.0', 1572864, '.docx', 'DRAFT', FALSE, NULL,
    'admin', NOW(), 'admin', NOW(), '0');

-- 项目10002 - 会议记录
INSERT INTO `eff_document` (
    `project_id`, `phase_id`, `doc_type`, `doc_name`, `doc_url`,
    `doc_version`, `file_size`, `file_extension`, `current_status`,
    `is_final_version`, `parent_doc_id`,
    `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`
) VALUES
(10002, NULL, 'MEETING', '智能客服系统-需求评审会议记录.pdf',
    'https://test-oss-bucket.oss-cn-shanghai.aliyuncs.com/docs/10002/meeting_20260220.pdf',
    'v1.0', 524288, '.pdf', 'APPROVED', TRUE, NULL,
    'admin', NOW(), 'admin', NOW(), '0');

-- ====================================================================
-- 4. 文档评论（12条，包含普通评论、回复、@提醒）
-- ====================================================================
-- 项目10001 - 设计文档的评论（审核中文档有评论）
INSERT INTO `eff_document_comment` (
    `document_id`, `parent_comment_id`, `line_number`, `content`,
    `mentioned_users`, `comment_type`, `status`,
    `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`
) VALUES
-- 评论1：普通评论
((SELECT id FROM eff_document WHERE doc_name='在线教育平台-系统设计文档v1.0.docx'),
    NULL, NULL, '整体架构设计很清晰，建议补充缓存策略的说明。',
    NULL, 'SUGGESTION', 'OPEN', 'user10', NOW(), 'user10', NOW(), '0'),

-- 评论2：行级评论
((SELECT id FROM eff_document WHERE doc_name='在线教育平台-系统设计文档v1.0.docx'),
    NULL, 125, '这里的数据库设计是否考虑了分库分表？',
    NULL, 'QUESTION', 'OPEN', 'user11', NOW(), 'user11', NOW(), '0'),

-- 评论3：@提醒用户
((SELECT id FROM eff_document WHERE doc_name='在线教育平台-系统设计文档v1.0.docx'),
    NULL, NULL, '@user102 请确认视频上传的并发方案是否符合预期。',
    '[102]', 'QUESTION', 'OPEN', 'user12', NOW(), 'user12', NOW(), '0'),

-- 评论4：回复评论1
((SELECT id FROM eff_document WHERE doc_name='在线教育平台-系统设计文档v1.0.docx'),
    (SELECT id FROM eff_document_comment WHERE content LIKE '整体架构设计很清晰%' LIMIT 1),
    NULL, '感谢建议，我会在第3章补充Redis缓存策略。',
    NULL, 'COMMENT', 'OPEN', 'admin', NOW(), 'admin', NOW(), '0'),

-- 评论5：已解决的评论
((SELECT id FROM eff_document WHERE doc_name='在线教育平台-系统设计文档v1.0.docx'),
    NULL, 88, '用户认证流程建议使用JWT Token',
    NULL, 'SUGGESTION', 'RESOLVED', 'user10', DATE_SUB(NOW(), INTERVAL 2 DAY),
    'user10', DATE_SUB(NOW(), INTERVAL 1 DAY), '0'),

-- 项目10001 - 接口文档的评论（草稿文档）
INSERT INTO `eff_document_comment` (
    `document_id`, `parent_comment_id`, `line_number`, `content`,
    `mentioned_users`, `comment_type`, `status`,
    `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`
) VALUES
((SELECT id FROM eff_document WHERE doc_name='在线教育平台-API接口文档.md'),
    NULL, 45, '这个接口的返回值格式需要统一',
    NULL, 'SUGGESTION', 'OPEN', 'user13', NOW(), 'user13', NOW(), '0');

-- 更新已解决评论的解决人和解决时间
UPDATE `eff_document_comment`
SET `resolved_by` = 102, `resolved_time` = DATE_SUB(NOW(), INTERVAL 1 DAY)
WHERE `status` = 'RESOLVED';

-- ====================================================================
-- 5. 任务生成规则（2条规则）
-- ====================================================================
INSERT INTO `eff_task_generation_rule` (
    `project_id`, `rule_name`, `trigger_phase`, `trigger_condition`,
    `task_template`, `auto_generate`, `is_active`,
    `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `remark`
) VALUES
-- 项目10001的规则：设计文档批准后自动生成任务（需要PM审核）
(10001, '设计文档批准后生成开发任务', 'DESIGN', 'DOC_APPROVED',
    '{"taskPrefix": "【教育平台】", "defaultAssignee": null, "estimatedHoursMultiplier": 1.0}',
    FALSE, TRUE, 'admin', NOW(), 'admin', NOW(), '0', '设计文档批准后自动生成开发任务预览'),

-- 项目10002的规则：设计文档批准后自动生成任务（自动创建，不需要审核）
(10002, '设计文档批准后自动创建任务', 'DESIGN', 'DOC_APPROVED',
    '{"taskPrefix": "【客服系统】", "defaultAssignee": 103, "estimatedHoursMultiplier": 1.2}',
    TRUE, TRUE, 'admin', NOW(), 'admin', NOW(), '0', '设计文档批准后自动生成任务并创建');

-- ====================================================================
-- 6. 任务生成预览（2条预览，一个待审核，一个已批准）
-- ====================================================================
-- 项目10001 - 待审核的任务预览
INSERT INTO `eff_task_generation_preview` (
    `project_id`, `phase_id`, `rule_id`, `preview_data`, `status`,
    `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`
) VALUES
(10001,
    (SELECT id FROM eff_project_phase WHERE project_id=10001 AND phase_type='DESIGN'),
    (SELECT id FROM eff_task_generation_rule WHERE project_id=10001),
    '[
        {"name": "【教育平台】用户登录功能", "taskType": "DAILY", "estimatedHours": 8, "assigneeId": null, "description": "实现用户登录、注册、密码找回功能"},
        {"name": "【教育平台】课程管理模块", "taskType": "DAILY", "estimatedHours": 16, "assigneeId": null, "description": "实现课程的增删改查和分类管理"},
        {"name": "【教育平台】在线视频播放", "taskType": "DAILY", "estimatedHours": 20, "assigneeId": null, "description": "集成视频播放器，支持断点续播"},
        {"name": "【教育平台】学习进度跟踪", "taskType": "DAILY", "estimatedHours": 12, "assigneeId": null, "description": "记录用户学习进度和完成情况"},
        {"name": "【教育平台】在线考试系统", "taskType": "DAILY", "estimatedHours": 24, "assigneeId": null, "description": "实现在线出题、答题、评分功能"}
    ]',
    'PENDING', 'admin', NOW(), 'admin', NOW(), '0');

-- 项目10002 - 已批准并生成任务的预览（模拟已经批准的场景）
INSERT INTO `eff_task_generation_preview` (
    `project_id`, `phase_id`, `rule_id`, `preview_data`, `status`,
    `approved_by`, `approved_time`, `generated_task_ids`,
    `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`
) VALUES
(10002,
    (SELECT id FROM eff_project_phase WHERE project_id=10002 AND phase_type='DESIGN'),
    (SELECT id FROM eff_task_generation_rule WHERE project_id=10002),
    '[
        {"name": "【客服系统】对话流程设计", "taskType": "DAILY", "estimatedHours": 10, "assigneeId": 103},
        {"name": "【客服系统】知识库构建", "taskType": "DAILY", "estimatedHours": 15, "assigneeId": 103},
        {"name": "【客服系统】AI模型集成", "taskType": "DAILY", "estimatedHours": 20, "assigneeId": 103}
    ]',
    'APPROVED', 102, DATE_SUB(NOW(), INTERVAL 1 DAY), '20001,20002,20003',
    'admin', DATE_SUB(NOW(), INTERVAL 2 DAY), 'admin', DATE_SUB(NOW(), INTERVAL 1 DAY), '0');

-- ====================================================================
-- 7. 为项目10002生成的任务（模拟自动生成的任务）
-- ====================================================================
-- 注意：这些任务ID >= 20000，避免与现有任务冲突
INSERT INTO `eff_task` (
    `id`, `project_id`, `task_type`, `name`, `description`,
    `estimated_hours`, `assignee_id`, `status`, `parent_id`,
    `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`
) VALUES
(20001, 10002, 'DAILY', '【客服系统】对话流程设计', '设计智能客服的多轮对话流程和意图识别',
    10, 103, 'PENDING', NULL, 'SYSTEM', DATE_SUB(NOW(), INTERVAL 1 DAY), 'SYSTEM', DATE_SUB(NOW(), INTERVAL 1 DAY), '0'),
(20002, 10002, 'DAILY', '【客服系统】知识库构建', '构建客服知识库，包括常见问题和答案',
    15, 103, 'PENDING', NULL, 'SYSTEM', DATE_SUB(NOW(), INTERVAL 1 DAY), 'SYSTEM', DATE_SUB(NOW(), INTERVAL 1 DAY), '0'),
(20003, 10002, 'DAILY', '【客服系统】AI模型集成', '集成NLP模型实现智能问答',
    20, 103, 'PENDING', NULL, 'SYSTEM', DATE_SUB(NOW(), INTERVAL 1 DAY), 'SYSTEM', DATE_SUB(NOW(), INTERVAL 1 DAY), '0');

-- ====================================================================
-- 验证脚本
-- ====================================================================
-- 检查数据是否插入成功
-- SELECT '项目阶段' AS 表名, COUNT(*) AS 数据量 FROM eff_project_phase WHERE project_id >= 10000
-- UNION ALL
-- SELECT '文档管理', COUNT(*) FROM eff_document WHERE project_id >= 10000
-- UNION ALL
-- SELECT '文档评论', COUNT(*) FROM eff_document_comment WHERE document_id IN (SELECT id FROM eff_document WHERE project_id >= 10000)
-- UNION ALL
-- SELECT '任务规则', COUNT(*) FROM eff_task_generation_rule WHERE project_id >= 10000
-- UNION ALL
-- SELECT '任务预览', COUNT(*) FROM eff_task_generation_preview WHERE project_id >= 10000
-- UNION ALL
-- SELECT '生成任务', COUNT(*) FROM eff_task WHERE id >= 20000;

-- 查看完整的业务流程
-- SELECT
--     p.project_title AS 项目名称,
--     ph.phase_name AS 阶段,
--     ph.status AS 阶段状态,
--     d.doc_name AS 文档,
--     d.current_status AS 文档状态,
--     COUNT(DISTINCT dc.id) AS 评论数,
--     tp.status AS 任务预览状态
-- FROM pms_project p
-- LEFT JOIN eff_project_phase ph ON p.project_id = ph.project_id
-- LEFT JOIN eff_document d ON ph.id = d.phase_id
-- LEFT JOIN eff_document_comment dc ON d.id = dc.document_id
-- LEFT JOIN eff_task_generation_preview tp ON ph.id = tp.phase_id
-- WHERE p.project_id >= 10000
-- GROUP BY p.project_id, ph.id, d.id, tp.id
-- ORDER BY p.project_id, ph.sort_order;
