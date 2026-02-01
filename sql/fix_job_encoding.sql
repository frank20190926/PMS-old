-- 修复所有定时任务名称乱码问题
-- 执行命令: mysql -h 127.0.0.1 -u root -p123456 --default-character-set=utf8mb4 kml-pms < sql/fix_job_encoding.sql

-- 设置字符编码
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- 修复 job_id = 1: 系统默认（无参）
UPDATE sys_job
SET job_name = '系统默认（无参）',
    remark = '定时任务默认（无参）'
WHERE job_id = 1;

-- 修复 job_id = 2: 系统默认（有参）
UPDATE sys_job
SET job_name = '系统默认（有参）',
    remark = '定时任务默认（有参）'
WHERE job_id = 2;

-- 修复 job_id = 3: 系统默认（多参）
UPDATE sys_job
SET job_name = '系统默认（多参）',
    remark = '定时任务默认（多参）'
WHERE job_id = 3;

-- 修复 job_id = 4: 获取节日及调休任务
UPDATE sys_job
SET job_name = '获取节日及调休任务',
    remark = '获取节假日信息'
WHERE job_id = 4;

-- 验证修复结果
SELECT job_id, job_name, job_group, invoke_target, status
FROM sys_job
ORDER BY job_id;
