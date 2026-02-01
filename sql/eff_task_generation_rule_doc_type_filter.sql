-- 为任务生成规则表添加文档类型过滤字段
ALTER TABLE eff_task_generation_rule
ADD COLUMN doc_type_filter VARCHAR(200) DEFAULT NULL COMMENT '触发文档类型过滤(逗号分隔，如: REQUIREMENT,DESIGN)';
