CREATE TABLE IF NOT EXISTS eff_sync_audit (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  eff_daily_report_id BIGINT NOT NULL,
  project_id BIGINT NOT NULL,
  pms_report_id BIGINT NULL,
  status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
  attempts INT NOT NULL DEFAULT 0,
  last_error TEXT NULL,
  next_retry_time DATETIME NULL,
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uk_report_project (eff_daily_report_id, project_id)
) ENGINE=InnoDB COMMENT='日报回写审计表';
