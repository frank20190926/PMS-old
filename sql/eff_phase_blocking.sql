-- 添加阶段阻塞机制相关字段
-- 2026-01-31

-- 添加阶段前置条件和阻塞标记
ALTER TABLE eff_project_phase ADD COLUMN required_docs VARCHAR(500) DEFAULT NULL COMMENT '必须文档类型(逗号分隔,如REQUIREMENT,DESIGN)';
ALTER TABLE eff_project_phase ADD COLUMN block_next_phase TINYINT(1) DEFAULT 1 COMMENT '是否阻塞下一阶段(1=是,0=否)';
ALTER TABLE eff_project_phase ADD COLUMN prerequisite_phase_id BIGINT DEFAULT NULL COMMENT '前置阶段ID';
