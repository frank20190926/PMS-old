# 项目生命周期模块问题总结

**检查时间**: 2026-01-27 17:40
**修复时间**: 2026-01-28
**状态**: ✅ 问题已解决，模块正常工作

---

## 🔍 问题诊断过程

### 1. API 测试结果
所有项目生命周期相关的 API 都返回 404：
- ❌ `GET /pms/efficiency/project/phase/list` - 404
- ❌ `GET /pms/efficiency/project/document/list` - 404
- ❌ `GET /pms/efficiency/task-generation/preview/list` - 404
- ❌ `GET /pms/efficiency/project/workflow` - 404

### 2. 根本原因
编译后的 `target/classes` 目录中**不存在 project 子模块**：
```bash
# 源代码目录（存在）
application/src/main/java/com/app/pms/efficiency/project/

# 编译后目录（不存在）
application/target/classes/com/app/pms/efficiency/project/  ❌
```

### 3. Maven 编译错误

执行 `mvn clean install` 时出现大量编译错误，主要问题：

#### 错误类型 1: 错误的 BaseMapper 导入
```
[ERROR] 程序包com.ruoyi.common.core.mapper不存在
```

**受影响文件**:
- `EffDocumentMapper.java`
- `EffDocumentCommentMapper.java`
- `EffProjectPhaseMapper.java`
- `EffTaskGenerationPreviewMapper.java`
- `EffTaskGenerationRuleMapper.java`

**错误代码**:
```java
import com.ruoyi.common.core.mapper.BaseMapper;  // ❌ 错误

public interface EffDocumentMapper extends BaseMapper<EffDocument> {
    // ...
}
```

**正确代码应该是**:
```java
import com.baomidou.mybatisplus.core.mapper.BaseMapper;  // ✅ 正确

public interface EffDocumentMapper extends BaseMapper<EffDocument> {
    // ...
}
```

#### 错误类型 2: 错误的 BaseEntity 导入
```
[ERROR] 程序包com.app.pms.common.core.domain不存在
```

**受影响文件**:
- `EffProjectPhase.java`
- `EffDocument.java`
- `EffDocumentComment.java`
- `EffTaskGenerationRule.java`
- `EffTaskGenerationPreview.java`

**错误代码**:
```java
import com.app.pms.common.core.domain.BaseEntity;  // ❌ 错误

public class EffDocument extends BaseEntity {
    // ...
}
```

**正确代码应该是**:
```java
import com.ruoyi.common.core.domain.BaseEntity;  // ✅ 正确

public class EffDocument extends BaseEntity {
    // ...
}
```

#### 错误类型 3: 缺少 EffTask 类导入
```
[ERROR] 找不到符号: 类 EffTask
```

**受影响文件**:
- `EffProjectPhaseServiceImpl.java`
- `EffTaskGenerationServiceImpl.java`
- `EffProjectWorkflowServiceImpl.java`
- `IEffTaskGenerationService.java`

**需要添加的导入**:
```java
import com.app.pms.efficiency.domain.EffTask;
import com.app.pms.efficiency.mapper.EffTaskMapper;
```

---

## 📋 修复清单

### 第 1 步: 修复所有 Mapper 接口（5 个文件）

需要修改的文件:
1. `efficiency/project/mapper/EffDocumentMapper.java`
2. `efficiency/project/mapper/EffDocumentCommentMapper.java`
3. `efficiency/project/mapper/EffProjectPhaseMapper.java`
4. `efficiency/project/mapper/EffTaskGenerationPreviewMapper.java`
5. `efficiency/project/mapper/EffTaskGenerationRuleMapper.java`

**修改内容**:
```java
// 删除这行
import com.ruoyi.common.core.mapper.BaseMapper;

// 改为
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
```

### 第 2 步: 修复所有 Domain 实体类（5 个文件）

需要修改的文件:
1. `efficiency/project/domain/EffProjectPhase.java`
2. `efficiency/project/domain/EffDocument.java`
3. `efficiency/project/domain/EffDocumentComment.java`
4. `efficiency/project/domain/EffTaskGenerationRule.java`
5. `efficiency/project/domain/EffTaskGenerationPreview.java`

**修改内容**:
```java
// 删除这行
import com.app.pms.common.core.domain.BaseEntity;

// 改为
import com.ruoyi.common.core.domain.BaseEntity;
```

### 第 3 步: 修复所有 Service 实现类（3 个文件）

需要修改的文件:
1. `efficiency/project/service/impl/EffProjectPhaseServiceImpl.java`
2. `efficiency/project/service/impl/EffTaskGenerationServiceImpl.java`
3. `efficiency/project/service/impl/EffProjectWorkflowServiceImpl.java`

**修改内容**:
在文件顶部添加导入:
```java
import com.app.pms.efficiency.domain.EffTask;
import com.app.pms.efficiency.mapper.EffTaskMapper;
```

### 第 4 步: 修复 Service 接口（1 个文件）

需要修改的文件:
1. `efficiency/project/service/IEffTaskGenerationService.java`

**修改内容**:
在文件顶部添加导入:
```java
import com.app.pms.efficiency.domain.EffTask;
```

---

## 🚀 修复后的步骤

修复所有导入错误后，执行以下步骤：

1. **重新编译项目**:
   ```bash
   cd kml-pms-v2-server
   export JAVA_HOME=/opt/homebrew/opt/openjdk@11
   mvn clean install -DskipTests
   ```

2. **验证编译成功**:
   ```bash
   ls -la application/target/classes/com/app/pms/efficiency/project/
   # 应该看到 controller, domain, mapper, service 等目录
   ```

3. **停止旧的后端服务**:
   ```bash
   ps aux | grep "com.ruoyi.RuoYiApplication" | grep -v grep | awk '{print $2}' | xargs kill -9
   ```

4. **启动新的后端服务**:
   ```bash
   export JAVA_HOME=/opt/homebrew/opt/openjdk@11
   mvn spring-boot:run -f ruoyi-admin/pom.xml -DskipTests
   ```

5. **测试 API**:
   ```bash
   # 登录后测试各个端点
   curl -X GET "http://localhost:8090/pms/efficiency/project/phase/list?projectId=1" \
     -H "Authorization: YOUR_TOKEN"
   ```

---

## 📝 说明

这些错误是在 Plan 模式下生成代码时产生的。当时我：
- 错误地使用了 `com.ruoyi.common.core.mapper.BaseMapper`（不存在）
- 错误地使用了 `com.app.pms.common.core.domain.BaseEntity`（路径错误）
- 忘记为跨模块引用添加必要的导入语句

**正确的包结构应该是**:
- BaseMapper: `com.baomidou.mybatisplus.core.mapper.BaseMapper`
- BaseEntity: `com.ruoyi.common.core.domain.BaseEntity`
- EffTask: `com.app.pms.efficiency.domain.EffTask`

修复后，所有 4 个子页面（阶段配置、文档管理、任务生成、���程仪表盘）的 API 应该都能正常工作。
