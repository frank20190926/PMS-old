-- 任务状态自动更新定时任务
-- 该任务会自动将开始日期已到的PENDING任务更新为IN_PROGRESS
-- 同时将结束日期已过的非完成任务标记为DELAYED

-- 设置字符编码
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- 如果已存在则先删除（修复乱码用）
DELETE FROM sys_job WHERE invoke_target = 'effSyncTask.autoUpdateTaskStatus()';

-- 注册定时任务
-- Cron表达式: 0 30 0 * * ?  (每天凌晨0点30分执行)
INSERT INTO sys_job (
    job_name, job_group, invoke_target, cron_expression,
    misfire_policy, concurrent, status, create_by, create_time, remark
) VALUES (
    '任务状态自动更新',
    'EFFICIENCY',
    'effSyncTask.autoUpdateTaskStatus()',
    '0 30 0 * * ?',
    '1',
    '1',
    '0',
    'admin',
    NOW(),
    '每天凌晨0:30自动更新任务状态（待处理->进行中、逾期->延误）'
);
