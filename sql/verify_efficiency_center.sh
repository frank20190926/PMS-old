#!/bin/bash
# 人效中心功能梳理方案 - 阶段5验证脚本
# 执行命令: bash sql/verify_efficiency_center.sh

echo "=========================================="
echo "人效中心功能梳理方案 - 验证报告"
echo "=========================================="
echo ""

# 数据库连接信息
DB_HOST="127.0.0.1"
DB_PORT="3306"
DB_USER="root"
DB_PASS="123456"
DB_NAME="kml-pms"

# 验证1：菜单结构验证
echo "【验证1】菜单结构检查"
echo "----------------------------"
mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASS $DB_NAME -e "
SELECT
    CONCAT(REPEAT('  ', level-1), m.menu_name) AS menu_tree,
    m.menu_id,
    m.component,
    CASE WHEN m.visible = '0' THEN '显示' ELSE '隐藏' END AS visible_status
FROM (
    SELECT @id := 1138 AS id,
           @level := 0 AS level
) vars
JOIN (
    SELECT  @id := m.menu_id,
            @level := @level + 1,
            m.*
    FROM    sys_menu m
    WHERE   m.parent_id = @id OR m.menu_id = 1138
    ORDER BY parent_id, order_num
) m
WHERE m.menu_id >= 1138 AND m.menu_id <= 1230
ORDER BY m.menu_id;
" 2>/dev/null
echo ""

# 验证2：权限配置验证
echo "【验证2】角色权限检查"
echo "----------------------------"
mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASS $DB_NAME -e "
SELECT
    r.role_key AS role_key,
    r.role_name AS role_name,
    SUM(CASE WHEN rm.menu_id = 1219 THEN 1 ELSE 0 END) AS '工作台',
    SUM(CASE WHEN rm.menu_id IN (1139,1145,1157) THEN 1 ELSE 0 END) AS '我的工作(3)',
    SUM(CASE WHEN rm.menu_id IN (1218,1197,1224) THEN 1 ELSE 0 END) AS '项目管理(3)',
    SUM(CASE WHEN rm.menu_id IN (1225,1226,1227,1228,1229) THEN 1 ELSE 0 END) AS '部门管理(5)',
    SUM(CASE WHEN rm.menu_id = 1190 THEN 1 ELSE 0 END) AS '系统管理'
FROM sys_role r
LEFT JOIN sys_role_menu rm ON r.role_id = rm.role_id
WHERE r.role_id IN (1, 2, 100, 101, 102, 103, 104, 106)
GROUP BY r.role_id, r.role_key, r.role_name
ORDER BY r.role_id;
" 2>/dev/null
echo ""

# 验证3：组件路径验证
echo "【验证3】前端组件文件检查"
echo "----------------------------"
COMPONENTS=(
    "kml-pms-v2-vue/src/views/pms/efficiency/dashboard/index.vue"
    "kml-pms-v2-vue/src/views/pms/efficiency/task/index.vue"
    "kml-pms-v2-vue/src/views/pms/efficiency/daily-report/index.vue"
    "kml-pms-v2-vue/src/views/pms/efficiency/daily-report/approve.vue"
    "kml-pms-v2-vue/src/views/pms/efficiency/weekly-report/index.vue"
    "kml-pms-v2-vue/src/views/pms/efficiency/project/project-list.vue"
    "kml-pms-v2-vue/src/views/pms/efficiency/resource/index.vue"
    "kml-pms-v2-vue/src/views/pms/efficiency/dept/overview.vue"
    "kml-pms-v2-vue/src/views/pms/efficiency/dept/resource-load.vue"
    "kml-pms-v2-vue/src/views/pms/efficiency/dept/member-hours.vue"
    "kml-pms-v2-vue/src/views/pms/efficiency/dept/weekly-summary.vue"
    "kml-pms-v2-vue/src/views/pms/efficiency/dept/project-progress.vue"
    "kml-pms-v2-vue/src/views/pms/efficiency/sync/index.vue"
)

for component in "${COMPONENTS[@]}"; do
    if [ -f "$component" ]; then
        echo "✅ $component"
    else
        echo "❌ $component - 文件不存在"
    fi
done
echo ""

# 验证4：后端API端点验证
echo "【验证4】后端API控制器检查"
echo "----------------------------"
CONTROLLERS=(
    "kml-pms-v2-server/application/src/main/java/com/app/pms/efficiency/controller/EffResourceController.java"
    "kml-pms-v2-server/application/src/main/java/com/app/pms/efficiency/controller/EffDeptController.java"
)

for controller in "${CONTROLLERS[@]}"; do
    if [ -f "$controller" ]; then
        echo "✅ $controller"
        grep -E "@GetMapping|@PostMapping|@PutMapping|@DeleteMapping" "$controller" | sed 's/^/    /'
    else
        echo "❌ $controller - 文件不存在"
    fi
done
echo ""

# 验证5：数据完整性检查
echo "【验证5】数据表完整性检查"
echo "----------------------------"
mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASS $DB_NAME -e "
SELECT
    '人效中心表' AS category,
    'eff_task' AS table_name,
    COUNT(*) AS record_count
FROM eff_task
UNION ALL
SELECT '人效中心表', 'eff_daily_report', COUNT(*) FROM eff_daily_report
UNION ALL
SELECT '人效中心表', 'eff_weekly_report', COUNT(*) FROM eff_weekly_report
UNION ALL
SELECT '人效中心表', 'eff_task_report', COUNT(*) FROM eff_task_report
UNION ALL
SELECT '排期数据', 'pms_project_staff_sched', COUNT(*) FROM pms_project_staff_sched
UNION ALL
SELECT '项目数据', 'pms_project', COUNT(*) FROM pms_project;
" 2>/dev/null
echo ""

# 验证6：关键SQL查询验证
echo "【验证6】关键业务查询验证"
echo "----------------------------"
echo "部门资源负载查询测试（前5条）:"
mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASS $DB_NAME -e "
SELECT
    u.user_id,
    u.user_name,
    d.dept_name,
    COALESCE(SUM(s.estimated_hours), 0) AS scheduled_hours,
    COUNT(DISTINCT s.project_id) AS project_count
FROM sys_user u
LEFT JOIN sys_dept d ON u.dept_id = d.dept_id
LEFT JOIN pms_project_staff_sched s ON u.user_id = s.user_id
WHERE u.del_flag = '0'
GROUP BY u.user_id, u.user_name, d.dept_name
LIMIT 5;
" 2>/dev/null
echo ""

echo "=========================================="
echo "验证完成！"
echo "=========================================="
echo ""
echo "【下一步操作】"
echo "1. 启动后端服务: cd kml-pms-v2-server && mvn spring-boot:run -f ruoyi-admin/pom.xml"
echo "2. 启动前端服务: cd kml-pms-v2-vue && npm run dev"
echo "3. 使用不同角色账号登录测试:"
echo "   - 管理员: admin / admin123"
echo "   - 部门经理: (需要查询数据库获取账号)"
echo "   - PM: (需要查询数据库获取账号)"
echo "   - 员工: (需要查询数据库获取账号)"
echo "4. 验证菜单显示和权限控制是否符合预期"
echo ""
