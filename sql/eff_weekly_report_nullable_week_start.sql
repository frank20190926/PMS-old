-- 修复周报创建失败：允许 week_start/week_end 为空
-- 说明：当前插入只写 week_start_date/week_end_date，week_start/week_end 置空不应阻塞
ALTER TABLE eff_weekly_report
  MODIFY COLUMN week_start date NULL,
  MODIFY COLUMN week_end date NULL;
