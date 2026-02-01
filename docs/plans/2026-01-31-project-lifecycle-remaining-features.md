# 项目生命周期剩余功能实施计划

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 完成项目生命周期模块剩余 5 项核心功能：里程碑阻塞、Excel 任务模板、权限简化、文档审批串联、日报强制校验。

**Architecture:** 在现有 Spring Boot + Vue 2 + Vuex 基础上，补齐后端校验逻辑和前端交互。后端以 Service 层校验为主，前端以表单校验 + 状态联动为辅。数据库仅需少量 ALTER 和权限菜单调整。

**Tech Stack:** Java 11 / Spring Boot / MyBatis / Vue 2 / Element UI / Vuex / MySQL

---

## Task 1: 里程碑完成与阶段阻塞机制

**Files:**
- Modify: `kml-pms-v2-server/application/src/main/java/com/app/pms/efficiency/service/impl/EffProjectPhaseServiceImpl.java`
- Modify: `kml-pms-v2-server/application/src/main/java/com/app/pms/efficiency/service/impl/EffProjectWorkflowServiceImpl.java`
- Modify: `kml-pms-v2-server/application/src/main/java/com/app/pms/efficiency/service/IEffProjectPhaseService.java`
- Modify: `kml-pms-v2-server/application/src/main/java/com/app/pms/efficiency/domain/EffProjectPhase.java`
- Modify: `kml-pms-v2-server/application/src/main/resources/mapper/pms/efficiency/EffProjectPhaseMapper.xml`
- Modify: `kml-pms-v2-server/application/src/main/java/com/app/pms/efficiency/mapper/EffProjectPhaseMapper.java`
- Modify: `kml-pms-v2-vue/src/views/pms/efficiency/project/phase/setup.vue`
- Modify: `kml-pms-v2-vue/src/views/pms/efficiency/project/workflow/index.vue`
- Create: `sql/eff_phase_blocking.sql`

### Step 1: 添加阶段阻塞字段

创建 SQL 脚本 `sql/eff_phase_blocking.sql`:

```sql
-- 添加阶段前置条件和阻塞标记
ALTER TABLE eff_project_phase ADD COLUMN required_docs VARCHAR(500) DEFAULT NULL COMMENT '必须文档类型(逗号分隔,如REQUIREMENT,DESIGN)';
ALTER TABLE eff_project_phase ADD COLUMN block_next_phase TINYINT(1) DEFAULT 1 COMMENT '是否阻塞下一阶段(1=是,0=否)';
ALTER TABLE eff_project_phase ADD COLUMN prerequisite_phase_id BIGINT DEFAULT NULL COMMENT '前置阶段ID';
```

### Step 2: 更新 Domain 实体

在 `EffProjectPhase.java` 添加字段:

```java
/** 必须文档类型(逗号分隔) */
private String requiredDocs;

/** 是否阻塞下一阶段 */
private Integer blockNextPhase;

/** 前置阶段ID */
private Long prerequisitePhaseId;
```

加对应 getter/setter。

### Step 3: 更新 Mapper XML

在 `EffProjectPhaseMapper.xml` 的 resultMap 和 insert/update SQL 中添加三个字段映射。

### Step 4: 实现里程碑完成逻辑

在 `IEffProjectPhaseService.java` 添加方法签名:

```java
/** 完成阶段里程碑，校验文档和任务 */
public AjaxResult completeMilestone(Long phaseId);

/** 检查阶段是否可以开始（前置阶段已完成） */
public boolean canStartPhase(Long phaseId);
```

在 `EffProjectPhaseServiceImpl.java` 实现:

```java
@Override
public AjaxResult completeMilestone(Long phaseId) {
    EffProjectPhase phase = effProjectPhaseMapper.selectEffProjectPhaseById(phaseId);
    if (phase == null) {
        return AjaxResult.error("阶段不存在");
    }
    // 1. 检查必须文档是否已审批通过
    if (StringUtils.isNotEmpty(phase.getRequiredDocs())) {
        String[] requiredTypes = phase.getRequiredDocs().split(",");
        for (String docType : requiredTypes) {
            int approvedCount = effDocumentMapper.countApprovedByPhaseAndType(phase.getId(), docType.trim());
            if (approvedCount == 0) {
                return AjaxResult.error("阶段要求的 " + docType.trim() + " 类型文档尚未审批通过");
            }
        }
    }
    // 2. 检查里程碑任务是否完成
    if (phase.getMilestoneTaskId() != null) {
        EffTask task = effTaskMapper.selectEffTaskById(phase.getMilestoneTaskId());
        if (task == null || !"COMPLETED".equals(task.getStatus())) {
            return AjaxResult.error("阶段里程碑任务尚未完成");
        }
    }
    // 3. 更新阶段状态
    phase.setStatus("COMPLETED");
    phase.setActualEndDate(new Date());
    effProjectPhaseMapper.updateEffProjectPhase(phase);
    return AjaxResult.success("阶段里程碑已完成");
}

@Override
public boolean canStartPhase(Long phaseId) {
    EffProjectPhase phase = effProjectPhaseMapper.selectEffProjectPhaseById(phaseId);
    if (phase == null) return false;
    if (phase.getPrerequisitePhaseId() == null) return true;
    EffProjectPhase prereq = effProjectPhaseMapper.selectEffProjectPhaseById(phase.getPrerequisitePhaseId());
    return prereq != null && "COMPLETED".equals(prereq.getStatus());
}
```

### Step 5: 更新阶段状态转换校验

在 `EffProjectWorkflowServiceImpl.java` 的 `updatePhaseStatus()` 方法中添加校验:

```java
// 在更新状态前校验
if ("ACTIVE".equals(newStatus)) {
    if (!effProjectPhaseService.canStartPhase(phaseId)) {
        return AjaxResult.error("前置阶段尚未完成，无法开始当前阶段");
    }
}
if ("COMPLETED".equals(newStatus)) {
    return effProjectPhaseService.completeMilestone(phaseId);
}
```

### Step 6: 在 Mapper 中添加文档统计方法

在 `EffDocumentMapper.java` 添加:

```java
int countApprovedByPhaseAndType(@Param("phaseId") Long phaseId, @Param("docType") String docType);
```

在 `EffDocumentMapper.xml` 添加:

```xml
<select id="countApprovedByPhaseAndType" resultType="int">
    SELECT COUNT(*) FROM eff_document
    WHERE phase_id = #{phaseId} AND doc_type = #{docType} AND current_status = 'APPROVED' AND del_flag = '0'
</select>
```

### Step 7: 前端阶段配置增加阻塞选项

在 `phase/setup.vue` 每个阶段行添加:

```html
<el-form-item label="必须文档">
  <el-select v-model="phase.requiredDocs" multiple placeholder="选择必须文档类型" style="width: 200px">
    <el-option label="需求文档" value="REQUIREMENT"></el-option>
    <el-option label="设计文档" value="DESIGN"></el-option>
    <el-option label="评审文档" value="REVIEW"></el-option>
  </el-select>
</el-form-item>
<el-form-item label="阻塞下阶段">
  <el-switch v-model="phase.blockNextPhase" :active-value="1" :inactive-value="0"></el-switch>
</el-form-item>
```

保存时将 `requiredDocs` 数组 join 为逗号字符串。

### Step 8: 前端流程仪表盘增加完成按钮

在 `workflow/index.vue` 阶段卡片中添加"完成里程碑"按钮:

```html
<el-button v-if="phaseStatus.phase.status === 'ACTIVE'" type="success" size="small" @click="completeMilestone(phaseStatus.phase)">
  完成里程碑
</el-button>
```

methods 中添加:

```javascript
completeMilestone(phase) {
  this.$confirm('确认完成该阶段里程碑？系统将检查文档和任务是否满足要求。', '提示', { type: 'warning' }).then(() => {
    completeMilestoneApi(phase.id).then(res => {
      this.$message.success(res.msg || '里程碑已完成')
      this.loadWorkflow()
    })
  })
}
```

### Step 9: 添加完成里程碑 API

在前端 `api/pms/efficiency/projectWorkflow.js` 添加:

```javascript
export function completeMilestone(phaseId) {
  return request({ url: '/pms/efficiency/project/phase/completeMilestone/' + phaseId, method: 'put' })
}
```

后端 `EffProjectPhaseController.java` 添加:

```java
@PutMapping("/completeMilestone/{phaseId}")
public AjaxResult completeMilestone(@PathVariable Long phaseId) {
    return effProjectPhaseService.completeMilestone(phaseId);
}
```

### Step 10: 执行 SQL 并编译验证

```bash
mysql -u root -p123456 kml-pms < sql/eff_phase_blocking.sql
cd kml-pms-v2-server && export JAVA_HOME=/opt/homebrew/opt/openjdk@11 && mvn compile -DskipTests -pl application
```

### Step 11: 提交

```bash
cd kml-pms-v2-vue && git add -A && git commit -m "feat: add milestone completion and phase blocking mechanism"
cd ../kml-pms-v2-server && git add -A && git commit -m "feat: add milestone completion and phase blocking mechanism"
```

---

## Task 2: Excel 任务模板解析和生成

**Files:**
- Modify: `kml-pms-v2-server/application/pom.xml` (添加 Apache POI 依赖)
- Create: `kml-pms-v2-server/application/src/main/java/com/app/pms/efficiency/util/ExcelTaskParser.java`
- Create: `kml-pms-v2-server/application/src/main/java/com/app/pms/efficiency/util/ExcelTaskExporter.java`
- Modify: `kml-pms-v2-server/application/src/main/java/com/app/pms/efficiency/controller/EffTaskGenerationController.java`
- Modify: `kml-pms-v2-server/application/src/main/java/com/app/pms/efficiency/service/impl/EffTaskGenerationServiceImpl.java`
- Modify: `kml-pms-v2-vue/src/views/pms/efficiency/project/task-generation/preview.vue`
- Modify: `kml-pms-v2-vue/src/api/pms/efficiency/taskGeneration.js`

### Step 1: 添加 Apache POI 依赖

在 `application/pom.xml` 的 `<dependencies>` 中添加:

```xml
<dependency>
    <groupId>org.apache.poi</groupId>
    <artifactId>poi-ooxml</artifactId>
    <version>5.2.5</version>
</dependency>
```

### Step 2: 创建 Excel 解析工具类

创建 `ExcelTaskParser.java`:

```java
package com.app.pms.efficiency.util;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import java.io.InputStream;
import java.util.*;

public class ExcelTaskParser {

    /**
     * 解析 Excel 任务模板
     * 格式: 任务名称 | 任务类型 | 预估工时(小时) | 负责人 | 说明
     */
    public static List<Map<String, Object>> parse(InputStream inputStream) throws Exception {
        List<Map<String, Object>> tasks = new ArrayList<>();
        try (Workbook workbook = new XSSFWorkbook(inputStream)) {
            Sheet sheet = workbook.getSheetAt(0);
            // 跳过表头(第一行)
            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row == null) continue;
                String name = getCellString(row, 0);
                if (name == null || name.trim().isEmpty()) continue;

                Map<String, Object> task = new HashMap<>();
                task.put("name", name.trim());
                task.put("taskType", getCellString(row, 1) != null ? getCellString(row, 1).trim() : "DAILY");
                task.put("estimatedHours", getCellDouble(row, 2));
                task.put("assigneeName", getCellString(row, 3));
                task.put("description", getCellString(row, 4));
                tasks.add(task);
            }
        }
        return tasks;
    }

    private static String getCellString(Row row, int col) {
        Cell cell = row.getCell(col);
        if (cell == null) return null;
        cell.setCellType(CellType.STRING);
        return cell.getStringCellValue();
    }

    private static double getCellDouble(Row row, int col) {
        Cell cell = row.getCell(col);
        if (cell == null) return 8.0;
        try {
            return cell.getNumericCellValue();
        } catch (Exception e) {
            return 8.0;
        }
    }
}
```

### Step 3: 创建 Excel 导出工具类

创建 `ExcelTaskExporter.java`:

```java
package com.app.pms.efficiency.util;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

public class ExcelTaskExporter {

    private static final String[] HEADERS = {"任务名称", "任务类型", "预估工时(小时)", "负责人", "说明"};

    /** 导出空模板 */
    public static void exportTemplate(OutputStream out) throws Exception {
        try (Workbook wb = new XSSFWorkbook()) {
            Sheet sheet = wb.createSheet("任务模板");
            Row header = sheet.createRow(0);
            CellStyle style = wb.createCellStyle();
            Font font = wb.createFont();
            font.setBold(true);
            style.setFont(font);
            for (int i = 0; i < HEADERS.length; i++) {
                Cell cell = header.createCell(i);
                cell.setCellValue(HEADERS[i]);
                cell.setCellStyle(style);
                sheet.setColumnWidth(i, 5000);
            }
            // 示例行
            Row example = sheet.createRow(1);
            example.createCell(0).setCellValue("示例：用户登录功能开发");
            example.createCell(1).setCellValue("DAILY");
            example.createCell(2).setCellValue(8);
            example.createCell(3).setCellValue("");
            example.createCell(4).setCellValue("实现用户名密码登录");
            wb.write(out);
        }
    }

    /** 导出已有任务列表 */
    public static void exportTasks(List<Map<String, Object>> tasks, OutputStream out) throws Exception {
        try (Workbook wb = new XSSFWorkbook()) {
            Sheet sheet = wb.createSheet("任务列表");
            Row header = sheet.createRow(0);
            for (int i = 0; i < HEADERS.length; i++) {
                header.createCell(i).setCellValue(HEADERS[i]);
                sheet.setColumnWidth(i, 5000);
            }
            for (int i = 0; i < tasks.size(); i++) {
                Map<String, Object> task = tasks.get(i);
                Row row = sheet.createRow(i + 1);
                row.createCell(0).setCellValue(String.valueOf(task.getOrDefault("name", "")));
                row.createCell(1).setCellValue(String.valueOf(task.getOrDefault("taskType", "DAILY")));
                row.createCell(2).setCellValue(Double.parseDouble(String.valueOf(task.getOrDefault("estimatedHours", 8))));
                row.createCell(3).setCellValue(String.valueOf(task.getOrDefault("assigneeName", "")));
                row.createCell(4).setCellValue(String.valueOf(task.getOrDefault("description", "")));
            }
            wb.write(out);
        }
    }
}
```

### Step 4: 后端添加 Excel 上传/下载接口

在 `EffTaskGenerationController.java` 添加:

```java
@PostMapping("/uploadExcel")
public AjaxResult uploadExcel(@RequestParam("file") MultipartFile file,
                               @RequestParam("projectId") Long projectId,
                               @RequestParam(value = "phaseId", required = false) Long phaseId) {
    try {
        List<Map<String, Object>> tasks = ExcelTaskParser.parse(file.getInputStream());
        if (tasks.isEmpty()) {
            return AjaxResult.error("Excel文件中未找到有效任务数据");
        }
        // 创建预览记录
        String previewData = new com.alibaba.fastjson2.JSONArray(tasks).toJSONString();
        return effTaskGenerationService.createPreviewFromExcel(projectId, phaseId, previewData, tasks.size());
    } catch (Exception e) {
        return AjaxResult.error("解析Excel失败: " + e.getMessage());
    }
}

@GetMapping("/downloadTemplate")
public void downloadTemplate(HttpServletResponse response) throws Exception {
    response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
    response.setHeader("Content-Disposition", "attachment;filename=task_template.xlsx");
    ExcelTaskExporter.exportTemplate(response.getOutputStream());
}
```

### Step 5: Service 层添加 Excel 预览创建

在 `EffTaskGenerationServiceImpl.java` 添加:

```java
public AjaxResult createPreviewFromExcel(Long projectId, Long phaseId, String previewData, int taskCount) {
    EffTaskGenerationPreview preview = new EffTaskGenerationPreview();
    preview.setProjectId(projectId);
    preview.setPhaseId(phaseId);
    preview.setPreviewData(previewData);
    preview.setStatus("PENDING");
    preview.setCreateBy(SecurityUtils.getUsername());
    preview.setCreateTime(new Date());
    effTaskGenerationPreviewMapper.insertEffTaskGenerationPreview(preview);
    return AjaxResult.success("已解析 " + taskCount + " 个任务，请审核", preview);
}
```

同时在接口 `IEffTaskGenerationService.java` 添加方法签名。

### Step 6: 前端任务预览页添加 Excel 功能

在 `task-generation/preview.vue` 的 header 区域添加:

```html
<div style="float: right">
  <el-button size="small" @click="downloadTemplate" icon="el-icon-download">下载模板</el-button>
  <el-upload
    style="display: inline-block; margin-left: 10px"
    action="/api/pms/efficiency/project/task-generation/uploadExcel"
    :data="{ projectId: projectId }"
    :on-success="handleExcelSuccess"
    :on-error="handleExcelError"
    :show-file-list="false"
    accept=".xlsx,.xls">
    <el-button size="small" type="primary" icon="el-icon-upload2">导入Excel</el-button>
  </el-upload>
</div>
```

methods 中添加:

```javascript
downloadTemplate() {
  window.open('/api/pms/efficiency/project/task-generation/downloadTemplate')
},
handleExcelSuccess(response) {
  if (response.code === 200) {
    this.$message.success(response.msg || 'Excel导入成功')
    this.loadPendingPreviews()
  } else {
    this.$message.error(response.msg || '导入失败')
  }
},
handleExcelError(err) {
  this.$message.error('上传失败: ' + (err.message || '未知错误'))
}
```

### Step 7: 前端 API 添加方法

在 `taskGeneration.js` 添加:

```javascript
export function downloadTemplate() {
  return request({ url: '/pms/efficiency/project/task-generation/downloadTemplate', method: 'get', responseType: 'blob' })
}
```

### Step 8: 编译验证

```bash
cd kml-pms-v2-server && export JAVA_HOME=/opt/homebrew/opt/openjdk@11 && mvn compile -DskipTests -pl application
```

### Step 9: 提交

```bash
cd kml-pms-v2-vue && git add -A && git commit -m "feat: add Excel task template upload and download"
cd ../kml-pms-v2-server && git add -A && git commit -m "feat: add Excel task template parsing and export"
```

---

## Task 3: 权限简化（30+ → 5 个核心权限）

**Files:**
- Create: `sql/eff_permission_simplify.sql`
- Modify: `kml-pms-v2-server/application/src/main/java/com/app/pms/efficiency/controller/EffProjectPhaseController.java`
- Modify: `kml-pms-v2-server/application/src/main/java/com/app/pms/efficiency/controller/EffDocumentController.java`
- Modify: `kml-pms-v2-server/application/src/main/java/com/app/pms/efficiency/controller/EffTaskGenerationController.java`
- Modify: `kml-pms-v2-server/application/src/main/java/com/app/pms/efficiency/controller/EffProjectWorkflowController.java`
- Modify: `kml-pms-v2-server/application/src/main/java/com/app/pms/efficiency/controller/EffTaskController.java`
- Modify: `kml-pms-v2-server/application/src/main/java/com/app/pms/efficiency/controller/EffDailyReportController.java`

### Step 1: 创建权限简化 SQL

创建 `sql/eff_permission_simplify.sql`:

```sql
-- 权限简化：30+ 细粒度权限 → 5 个核心权限
-- 新权限体系:
--   efficiency:project:manage  - 项目管理（阶段配置、流程管理）
--   efficiency:document:manage - 文档管理（上传、审批）
--   efficiency:task:manage     - 任务管理（创建、分配、任务生成）
--   efficiency:report:submit   - 报告提交（日报、周报填写）
--   efficiency:report:approve  - 报告审批（日报审核、周报审批）

-- 1. 插入新的权限菜单（按钮级别, menu_type='F'）
-- 找到人效中心父菜单ID
SET @effMenuId = (SELECT menu_id FROM sys_menu WHERE menu_name = '人效中心' LIMIT 1);

-- 插入5个核心权限按钮
INSERT INTO sys_menu (menu_name, parent_id, order_num, perms, menu_type, visible, status, create_time)
VALUES
('项目管理权限', IFNULL(@effMenuId, 0), 1, 'efficiency:project:manage', 'F', '0', '0', NOW()),
('文档管理权限', IFNULL(@effMenuId, 0), 2, 'efficiency:document:manage', 'F', '0', '0', NOW()),
('任务管理权限', IFNULL(@effMenuId, 0), 3, 'efficiency:task:manage', 'F', '0', '0', NOW()),
('报告提交权限', IFNULL(@effMenuId, 0), 4, 'efficiency:report:submit', 'F', '0', '0', NOW()),
('报告审批权限', IFNULL(@effMenuId, 0), 5, 'efficiency:report:approve', 'F', '0', '0', NOW());

-- 2. 为管理员角色(role_id=2)分配所有5个权限
INSERT INTO sys_role_menu (role_id, menu_id)
SELECT 2, menu_id FROM sys_menu WHERE perms IN (
    'efficiency:project:manage', 'efficiency:document:manage',
    'efficiency:task:manage', 'efficiency:report:submit', 'efficiency:report:approve'
);

-- 3. 为项目经理角色(role_id=102,103,104)分配所有5个权限
INSERT INTO sys_role_menu (role_id, menu_id)
SELECT r.role_id, m.menu_id
FROM (SELECT 102 AS role_id UNION SELECT 103 UNION SELECT 104) r
CROSS JOIN sys_menu m
WHERE m.perms IN (
    'efficiency:project:manage', 'efficiency:document:manage',
    'efficiency:task:manage', 'efficiency:report:submit', 'efficiency:report:approve'
);

-- 4. 为员工角色(role_id=106)分配提交权限
INSERT INTO sys_role_menu (role_id, menu_id)
SELECT 106, menu_id FROM sys_menu WHERE perms IN (
    'efficiency:report:submit'
);

-- 5. 为助理角色(role_id=101)分配提交+任务查看权限
INSERT INTO sys_role_menu (role_id, menu_id)
SELECT 101, menu_id FROM sys_menu WHERE perms IN (
    'efficiency:task:manage', 'efficiency:report:submit'
);
```

### Step 2: 更新后端控制器注解

将各控制器中的细粒度权限统一为 5 个核心权限:

**EffProjectPhaseController.java** — 所有方法改为 `@PreAuthorize("@ss.hasPermi('efficiency:project:manage')")`

**EffDocumentController.java** — 所有方法改为 `@PreAuthorize("@ss.hasPermi('efficiency:document:manage')")`

**EffTaskGenerationController.java** — 所有方法改为 `@PreAuthorize("@ss.hasPermi('efficiency:task:manage')")`

**EffProjectWorkflowController.java** — 所有方法改为 `@PreAuthorize("@ss.hasPermi('efficiency:project:manage')")`

**EffTaskController.java** — 所有方法改为 `@PreAuthorize("@ss.hasPermi('efficiency:task:manage')")`

**EffDailyReportController.java**:
- `list`, `add`, `edit`, `submit` → `@PreAuthorize("@ss.hasPermi('efficiency:report:submit')")`
- `pending`, `approve` → `@PreAuthorize("@ss.hasPermi('efficiency:report:approve')")`

### Step 3: 执行 SQL 并编译

```bash
mysql -u root -p123456 kml-pms < sql/eff_permission_simplify.sql
cd kml-pms-v2-server && export JAVA_HOME=/opt/homebrew/opt/openjdk@11 && mvn compile -DskipTests -pl application
```

### Step 4: 提交

```bash
cd kml-pms-v2-server && git add -A && git commit -m "refactor: simplify permissions from 30+ to 5 core permissions"
```

---

## Task 4: 文档审批自动触发任务生成串联验证

**Files:**
- Modify: `kml-pms-v2-server/application/src/main/java/com/app/pms/efficiency/listener/DocumentApprovalListener.java`
- Modify: `kml-pms-v2-server/application/src/main/java/com/app/pms/efficiency/service/impl/EffTaskGenerationServiceImpl.java`
- Modify: `kml-pms-v2-server/application/src/main/java/com/app/pms/efficiency/service/impl/EffDocumentServiceImpl.java`
- Modify: `kml-pms-v2-vue/src/views/pms/efficiency/project/document/index.vue`

### Step 1: 改进 DocumentApprovalListener

替换 `DocumentApprovalListener.java` 中的 `onApplicationEvent` 方法:

```java
@Override
public void onApplicationEvent(DocumentApprovedEvent event) {
    Long documentId = event.getDocumentId();
    Long projectId = event.getProjectId();
    String docType = event.getDocType();

    logger.info("文档审批事件触发: documentId={}, projectId={}, docType={}", documentId, projectId, docType);

    try {
        // 1. 检查是否有匹配的任务生成规则
        List<EffTaskGenerationRule> rules = effTaskGenerationRuleMapper.selectByProjectAndTrigger(projectId, "DOC_APPROVED");
        if (rules == null || rules.isEmpty()) {
            logger.info("项目 {} 无 DOC_APPROVED 触发规则，跳过任务生成", projectId);
            return;
        }

        for (EffTaskGenerationRule rule : rules) {
            // 2. 检查规则是否匹配当前文档类型
            if (StringUtils.isNotEmpty(rule.getDocTypeFilter()) && !rule.getDocTypeFilter().contains(docType)) {
                continue;
            }

            // 3. 根据 autoGenerate 标志决定行为
            if (rule.getAutoGenerate() != null && rule.getAutoGenerate() == 1) {
                // 自动生成：直接创建任务
                effTaskGenerationService.autoGenerateTasksFromDocument(documentId, rule);
                logger.info("自动生成任务完成: ruleId={}", rule.getId());
            } else {
                // 手动审核：创建预览
                effTaskGenerationService.handleDesignDocumentApproved(documentId, projectId);
                logger.info("任务预览已创建: ruleId={}", rule.getId());
            }
        }
    } catch (Exception e) {
        logger.error("文档审批事件处理失败: documentId={}, error={}", documentId, e.getMessage(), e);
    }
}
```

需要添加 `import org.slf4j.Logger; import org.slf4j.LoggerFactory;` 和 logger 字段，以及注入 `EffTaskGenerationRuleMapper`。

### Step 2: 在 EffTaskGenerationRuleMapper 添加查询

`EffTaskGenerationRuleMapper.java`:

```java
List<EffTaskGenerationRule> selectByProjectAndTrigger(@Param("projectId") Long projectId, @Param("triggerCondition") String triggerCondition);
```

`EffTaskGenerationRuleMapper.xml`:

```xml
<select id="selectByProjectAndTrigger" resultMap="EffTaskGenerationRuleResult">
    SELECT * FROM eff_task_generation_rule
    WHERE project_id = #{projectId} AND trigger_condition = #{triggerCondition} AND del_flag = '0'
</select>
```

### Step 3: 给 EffTaskGenerationRule 添加 docTypeFilter 字段

如果 `eff_task_generation_rule` 表缺少 `doc_type_filter` 字段:

```sql
ALTER TABLE eff_task_generation_rule ADD COLUMN doc_type_filter VARCHAR(200) DEFAULT NULL COMMENT '触发文档类型过滤(逗号分隔)';
```

Domain 类添加对应字段和 getter/setter。

### Step 4: 改进 parseDesignDocument 方法

将 `EffTaskGenerationServiceImpl.java` 中的硬编码 stub 替换为基于文档名称的解析:

```java
private List<Map<String, Object>> parseDesignDocument(EffDocument document) {
    List<Map<String, Object>> features = new ArrayList<>();
    // 基于文档名称和类型生成基础任务
    String docName = document.getDocName();
    String docType = document.getDocType();

    if ("REQUIREMENT".equals(docType)) {
        Map<String, Object> task = new HashMap<>();
        task.put("name", "需求评审: " + docName);
        task.put("taskType", "DAILY");
        task.put("estimatedHours", 4);
        task.put("description", "基于需求文档 " + docName + " 进行评审");
        features.add(task);
    } else if ("DESIGN".equals(docType)) {
        // 设计文档：生成前后端开发任务
        Map<String, Object> feTask = new HashMap<>();
        feTask.put("name", "前端开发: " + docName);
        feTask.put("taskType", "DAILY");
        feTask.put("estimatedHours", 16);
        feTask.put("description", "基于设计文档实现前端页面");
        features.add(feTask);

        Map<String, Object> beTask = new HashMap<>();
        beTask.put("name", "后端开发: " + docName);
        beTask.put("taskType", "DAILY");
        beTask.put("estimatedHours", 16);
        beTask.put("description", "基于设计文档实现后端接口");
        features.add(beTask);

        Map<String, Object> testTask = new HashMap<>();
        testTask.put("name", "测试验证: " + docName);
        testTask.put("taskType", "DAILY");
        testTask.put("estimatedHours", 8);
        testTask.put("description", "测试验证功能是否符合设计");
        features.add(testTask);
    }

    return features;
}
```

### Step 5: 前端文档审批后显示提示

在 `document/index.vue` 的 `approveDocument` 方法的成功回调中添加:

```javascript
approveDocument(row.id).then(() => {
  this.$message.success('文档已批准')
  this.$notify({ title: '任务生成', message: '文档审批通过后，系统将自动检查任务生成规则', type: 'info', duration: 5000 })
  this.getList()
})
```

### Step 6: 编译验证

```bash
cd kml-pms-v2-server && export JAVA_HOME=/opt/homebrew/opt/openjdk@11 && mvn compile -DskipTests -pl application
```

### Step 7: 提交

```bash
cd kml-pms-v2-vue && git add -A && git commit -m "feat: improve document approval to task generation chain"
cd ../kml-pms-v2-server && git add -A && git commit -m "feat: improve document approval listener and task generation chain"
```

---

## Task 5: 日报必须关联任务的强制校验

**Files:**
- Modify: `kml-pms-v2-server/application/src/main/java/com/app/pms/efficiency/service/impl/EffDailyReportServiceImpl.java`
- Modify: `kml-pms-v2-server/application/src/main/java/com/app/pms/efficiency/controller/EffDailyReportController.java`
- Modify: `kml-pms-v2-vue/src/views/pms/efficiency/daily-report/index.vue`

### Step 1: 后端添加日报任务校验

在 `EffDailyReportServiceImpl.java` 的 `insertEffDailyReport` 方法开头添加:

```java
@Override
public int insertEffDailyReport(EffDailyReport report) {
    // 强制校验：日报必须关联至少一个任务
    if (report.getTaskReports() == null || report.getTaskReports().isEmpty()) {
        throw new ServiceException("日报必须关联至少一个任务，请添加任务工时记录");
    }
    // 校验每个任务关联的有效性
    for (EffTaskReport tr : report.getTaskReports()) {
        if (tr.getTaskId() == null) {
            throw new ServiceException("任务工时记录中的任务ID不能为空");
        }
        EffTask task = effTaskMapper.selectEffTaskById(tr.getTaskId());
        if (task == null) {
            throw new ServiceException("关联的任务(ID=" + tr.getTaskId() + ")不存在");
        }
        if (tr.getActualHours() == null || tr.getActualHours() <= 0) {
            throw new ServiceException("任务 '" + task.getName() + "' 的实际工时必须大于0");
        }
    }
    // ... 原有逻辑继续
```

### Step 2: 后端 Controller 层也增加基础校验

在 `EffDailyReportController.java` 的 `add` 方法中:

```java
@PostMapping
public AjaxResult add(@RequestBody EffDailyReport report) {
    if (report.getReportDate() == null) {
        return AjaxResult.error("报告日期不能为空");
    }
    if (StringUtils.isEmpty(report.getSummary())) {
        return AjaxResult.error("工作总结不能为空");
    }
    return toAjax(effDailyReportService.insertEffDailyReport(report));
}
```

### Step 3: 前端表单添加任务校验

在 `daily-report/index.vue` 的提交方法中添加前端校验:

找到日报提交按钮的 click handler（通常是 `submitForm` 或类似方法），在表单校验通过后、API 调用前添加:

```javascript
// 校验任务关联
if (!this.form.taskReports || this.form.taskReports.length === 0) {
  this.$message.warning('请至少添加一条任务工时记录')
  return
}
for (let i = 0; i < this.form.taskReports.length; i++) {
  const tr = this.form.taskReports[i]
  if (!tr.taskId) {
    this.$message.warning(`第${i + 1}条工时记录未选择任务`)
    return
  }
  if (!tr.actualHours || tr.actualHours <= 0) {
    this.$message.warning(`第${i + 1}条工时记录的实际工时必须大于0`)
    return
  }
}
```

### Step 4: 前端增加空状态提示

在日报表单的任务列表区域，当没有任务时显示提示:

```html
<el-alert v-if="!form.taskReports || form.taskReports.length === 0"
  title="请添加至少一条任务工时记录" type="warning" :closable="false" style="margin-bottom: 10px">
</el-alert>
```

### Step 5: 编译验证

```bash
cd kml-pms-v2-server && export JAVA_HOME=/opt/homebrew/opt/openjdk@11 && mvn compile -DskipTests -pl application
```

### Step 6: 提交

```bash
cd kml-pms-v2-vue && git add -A && git commit -m "feat: add mandatory task association validation for daily reports"
cd ../kml-pms-v2-server && git add -A && git commit -m "feat: add mandatory task association validation for daily reports"
```

---

## 验证清单

完成所有 5 个 Task 后，执行以下验证:

1. **后端编译**: `cd kml-pms-v2-server && mvn compile -DskipTests` → BUILD SUCCESS
2. **里程碑阻塞**: 尝试完成一个缺少必要文档的阶段 → 应被拒绝
3. **Excel 导入**: 下载模板 → 填写 → 上传 → 预览列表出现
4. **权限**: 员工账号登录 → 只能看到日报提交相关功能
5. **文档串联**: 审批一个设计文档 → 检查是否生成任务预览
6. **日报校验**: 提交空任务日报 → 应被拒绝
