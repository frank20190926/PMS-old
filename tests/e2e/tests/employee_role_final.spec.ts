import { test, expect, Page } from '@playwright/test';
import * as path from 'path';
import * as fs from 'fs';

/**
 * 员工角色功能完整测试
 * 测试账号: mengqiang / admin123
 */

const BASE_URL = 'http://localhost:1024';
const TEST_USER = {
  username: 'mengqiang',
  password: 'admin123',
  userId: 4,
  name: '孟强'
};

const SCREENSHOT_DIR = path.join(__dirname, '../test-results/employee-final');
const REPORT_FILE = path.join(__dirname, '../test-results/employee-test-report.md');

async function saveScreenshot(page: Page, name: string) {
  if (!fs.existsSync(SCREENSHOT_DIR)) {
    fs.mkdirSync(SCREENSHOT_DIR, { recursive: true });
  }
  const screenshotPath = path.join(SCREENSHOT_DIR, `${name}.png`);
  await page.screenshot({ path: screenshotPath, fullPage: true });
  console.log(`📸 ${screenshotPath}`);
  return screenshotPath;
}

async function login(page: Page): Promise<boolean> {
  console.log(`\n🔐 登录: ${TEST_USER.username}`);

  await page.goto(BASE_URL);
  await page.waitForLoadState('networkidle');
  await page.waitForTimeout(1000);

  await page.fill('input[placeholder="账号"]', TEST_USER.username);
  await page.fill('input[placeholder="密码"]', TEST_USER.password);

  const captchaVisible = await page.locator('input[placeholder="验证码"]').isVisible().catch(() => false);
  if (captchaVisible) {
    await page.fill('input[placeholder="验证码"]', '1234');
  }

  await saveScreenshot(page, '01-before-login');
  await page.click('button:has-text("登 录")');
  await page.waitForTimeout(3000);

  const currentUrl = page.url();
  const success = currentUrl.includes('/index') || !currentUrl.includes('/login');

  if (success) {
    console.log('✅ 登录成功');
    await saveScreenshot(page, '02-login-success');
  } else {
    console.log('❌ 登录失败');
    await saveScreenshot(page, '02-login-failed');
  }

  return success;
}

test.describe('员工角色功能测试', () => {
  test.setTimeout(90000);

  test('完整功能测试', async ({ page }) => {
    const results: Array<{step: string, status: string, details: string}> = [];
    const screenshots: string[] = [];

    // Step 1: Login
    console.log('\n' + '='.repeat(60));
    console.log('Step 1: 登录系统');
    console.log('='.repeat(60));

    const loginSuccess = await login(page);

    if (!loginSuccess) {
      results.push({
        step: '登录系统',
        status: '❌ 失败',
        details: '登录失败，可能是验证码问题'
      });

      await generateReport(results, screenshots);
      expect(loginSuccess).toBeTruthy();
      return;
    }

    results.push({
      step: '登录系统',
      status: '✅ 成功',
      details: `使用账号 ${TEST_USER.username} 登录成功`
    });

    await page.waitForTimeout(2000);

    // Step 2: Verify user info
    console.log('\n' + '='.repeat(60));
    console.log('Step 2: 验证用户信息');
    console.log('='.repeat(60));

    const pageContent = await page.content();
    const hasUserInfo = pageContent.includes(TEST_USER.name) || pageContent.includes(TEST_USER.username);

    if (hasUserInfo) {
      console.log(`✓ 页面包含用户信息: ${TEST_USER.name}`);
      results.push({
        step: '验证用户信息',
        status: '✅ 成功',
        details: `页面正确显示用户名称: ${TEST_USER.name}`
      });
    } else {
      console.log('⚠️  未找到用户信息');
      results.push({
        step: '验证用户信息',
        status: '⚠️  警告',
        details: '页面未显示用户名称'
      });
    }

    // Step 3: Check sidebar menu
    console.log('\n' + '='.repeat(60));
    console.log('Step 3: 检查侧边栏菜单');
    console.log('='.repeat(60));

    await saveScreenshot(page, '03-sidebar-menu');
    screenshots.push('03-sidebar-menu.png');

    // Check if efficiency center menu exists
    const menuItems = await page.locator('.el-menu-item, .el-submenu').allTextContents();
    console.log(`找到 ${menuItems.length} 个菜单项`);

    const hasEfficiencyMenu = menuItems.some(item => item.includes('人效') || item.includes('效率'));

    if (hasEfficiencyMenu) {
      console.log('✓ 找到人效中心菜单');
      results.push({
        step: '检查侧边栏菜单',
        status: '✅ 成功',
        details: '侧边栏包含人效中心相关菜单'
      });
    } else {
      console.log('⚠️  未找到人效中心菜单，尝试直接访问');
      results.push({
        step: '检查侧边栏菜单',
        status: '⚠️  警告',
        details: '侧边栏未找到人效中心菜单，将尝试直接访问URL'
      });
    }

    // Step 4: Access efficiency center dashboard
    console.log('\n' + '='.repeat(60));
    console.log('Step 4: 访问人效中心工作台');
    console.log('='.repeat(60));

    try {
      await page.goto(`${BASE_URL}/#/efficiency/dashboard`, { timeout: 10000 });
      await page.waitForTimeout(2000);
      await saveScreenshot(page, '04-efficiency-dashboard');
      screenshots.push('04-efficiency-dashboard.png');

      const dashboardContent = await page.content();
      const hasDashboard = dashboardContent.includes('工作台') ||
                          dashboardContent.includes('任务') ||
                          dashboardContent.includes('dashboard');

      if (hasDashboard) {
        console.log('✓ 工作台页面加载成功');
        results.push({
          step: '访问人效中心工作台',
          status: '✅ 成功',
          details: '工作台页面正常显示'
        });
      } else {
        console.log('⚠️  工作台页面可能未正确加载');
        results.push({
          step: '访问人效中心工作台',
          status: '⚠️  警告',
          details: '页面已加载但未找到预期内容'
        });
      }
    } catch (error) {
      console.log(`❌ 访问工作台失败: ${error}`);
      results.push({
        step: '访问人效中心工作台',
        status: '❌ 失败',
        details: `无法访问工作台页面: ${error}`
      });
    }

    // Step 5: Access my tasks
    console.log('\n' + '='.repeat(60));
    console.log('Step 5: 访问我的任务');
    console.log('='.repeat(60));

    try {
      await page.goto(`${BASE_URL}/#/efficiency/task`, { timeout: 10000 });
      await page.waitForTimeout(2000);
      await saveScreenshot(page, '05-my-tasks');
      screenshots.push('05-my-tasks.png');

      const taskTableExists = await page.locator('.el-table').isVisible().catch(() => false);

      if (taskTableExists) {
        const taskCount = await page.locator('.el-table__row').count();
        console.log(`✓ 任务列表加载成功，共 ${taskCount} 条任务`);
        results.push({
          step: '访问我的任务',
          status: '✅ 成功',
          details: `任务列表正常显示，共 ${taskCount} 条任务`
        });
      } else {
        console.log('⚠️  任务列表未找到');
        results.push({
          step: '访问我的任务',
          status: '⚠️  警告',
          details: '页面已加载但未找到任务列表'
        });
      }
    } catch (error) {
      console.log(`❌ 访问任务列表失败: ${error}`);
      results.push({
        step: '访问我的任务',
        status: '❌ 失败',
        details: `无法访问任务列表: ${error}`
      });
    }

    // Step 6: Access daily reports
    console.log('\n' + '='.repeat(60));
    console.log('Step 6: 访问日报管理');
    console.log('='.repeat(60));

    try {
      await page.goto(`${BASE_URL}/#/efficiency/daily-report`, { timeout: 10000 });
      await page.waitForTimeout(2000);
      await saveScreenshot(page, '06-daily-reports');
      screenshots.push('06-daily-reports.png');

      const reportPageContent = await page.content();
      const hasReportPage = reportPageContent.includes('日报');

      if (hasReportPage) {
        const reportCount = await page.locator('.el-table__row').count();
        console.log(`✓ 日报页面加载成功，共 ${reportCount} 条记录`);
        results.push({
          step: '访问日报管理',
          status: '✅ 成功',
          details: `日报页面正常显示，共 ${reportCount} 条记录`
        });
      } else {
        console.log('⚠️  日报页面未找到');
        results.push({
          step: '访问日报管理',
          status: '⚠️  警告',
          details: '页面已加载但未找到日报内容'
        });
      }
    } catch (error) {
      console.log(`❌ 访问日报页面失败: ${error}`);
      results.push({
        step: '访问日报管理',
        status: '❌ 失败',
        details: `无法访问日报页面: ${error}`
      });
    }

    // Step 7: Access weekly reports
    console.log('\n' + '='.repeat(60));
    console.log('Step 7: 访问周报管理');
    console.log('='.repeat(60));

    try {
      await page.goto(`${BASE_URL}/#/efficiency/weekly-report`, { timeout: 10000 });
      await page.waitForTimeout(2000);
      await saveScreenshot(page, '07-weekly-reports');
      screenshots.push('07-weekly-reports.png');

      const weeklyContent = await page.content();
      const hasWeeklyPage = weeklyContent.includes('周报');

      if (hasWeeklyPage) {
        const weeklyCount = await page.locator('.el-table__row').count();
        console.log(`✓ 周报页面加载成功，共 ${weeklyCount} 条记录`);
        results.push({
          step: '访问周报管理',
          status: '✅ 成功',
          details: `周报页面正常显示，共 ${weeklyCount} 条记录`
        });
      } else {
        console.log('⚠️  周报页面未找到');
        results.push({
          step: '访问周报管理',
          status: '⚠️  警告',
          details: '页面已加载但未找到周报内容'
        });
      }
    } catch (error) {
      console.log(`❌ 访问周报页面失败: ${error}`);
      results.push({
        step: '访问周报管理',
        status: '❌ 失败',
        details: `无法访问周报页面: ${error}`
      });
    }

    // Step 8: Check permissions
    console.log('\n' + '='.repeat(60));
    console.log('Step 8: 验证权限控制');
    console.log('='.repeat(60));

    await page.goto(`${BASE_URL}/#/index`, { timeout: 10000 });
    await page.waitForTimeout(2000);
    await saveScreenshot(page, '08-permission-check');
    screenshots.push('08-permission-check.png');

    const pageContent2 = await page.content();
    const adminMenus = ['日报审核', '周报审核', '系统管理', '用户管理', '角色管理'];
    const visibleAdminMenus = adminMenus.filter(menu => pageContent2.includes(menu));

    if (visibleAdminMenus.length === 0) {
      console.log('✓ 权限控制正确，未显示管理员菜单');
      results.push({
        step: '验证权限控制',
        status: '✅ 成功',
        details: '员工账号正确隐藏了管理员功能菜单'
      });
    } else {
      console.log(`⚠️  发现管理员菜单: ${visibleAdminMenus.join(', ')}`);
      results.push({
        step: '验证权限控制',
        status: '⚠️  警告',
        details: `员工账号可以看到管理员菜单: ${visibleAdminMenus.join(', ')}`
      });
    }

    // Generate report
    await generateReport(results, screenshots);

    // Print summary
    console.log('\n' + '='.repeat(60));
    console.log('测试完成');
    console.log('='.repeat(60));
    results.forEach(r => {
      console.log(`${r.status} ${r.step}: ${r.details}`);
    });
    console.log(`\n📊 测试报告: ${REPORT_FILE}`);
    console.log(`📸 截图目录: ${SCREENSHOT_DIR}`);
    console.log('='.repeat(60));
  });
});

async function generateReport(
  results: Array<{step: string, status: string, details: string}>,
  screenshots: string[]
) {
  const timestamp = new Date().toISOString().replace('T', ' ').substring(0, 19);

  let report = `# 员工角色功能测试报告\n\n`;
  report += `**测试时间**: ${timestamp}\n\n`;
  report += `**测试账号**: ${TEST_USER.username} (${TEST_USER.name})\n\n`;
  report += `**测试环境**:\n`;
  report += `- 前端地址: ${BASE_URL}\n`;
  report += `- 后端地址: http://localhost:8090\n\n`;

  report += `## 测试结果汇总\n\n`;

  const successCount = results.filter(r => r.status.includes('✅')).length;
  const warningCount = results.filter(r => r.status.includes('⚠️')).length;
  const failCount = results.filter(r => r.status.includes('❌')).length;

  report += `| 状态 | 数量 |\n`;
  report += `|------|------|\n`;
  report += `| ✅ 成功 | ${successCount} |\n`;
  report += `| ⚠️  警告 | ${warningCount} |\n`;
  report += `| ❌ 失败 | ${failCount} |\n`;
  report += `| **总计** | **${results.length}** |\n\n`;

  report += `## 详细测试步骤\n\n`;

  results.forEach((r, index) => {
    report += `### ${index + 1}. ${r.step}\n\n`;
    report += `**状态**: ${r.status}\n\n`;
    report += `**详情**: ${r.details}\n\n`;

    if (screenshots[index]) {
      report += `**截图**: \`${screenshots[index]}\`\n\n`;
    }

    report += `---\n\n`;
  });

  report += `## 测试结论\n\n`;

  if (failCount === 0 && warningCount === 0) {
    report += `✅ **所有测试通过**，员工角色功能正常。\n\n`;
  } else if (failCount === 0) {
    report += `⚠️  **测试基本通过**，但存在 ${warningCount} 个警告项，建议检查。\n\n`;
  } else {
    report += `❌ **测试未通过**，存在 ${failCount} 个失败项和 ${warningCount} 个警告项，需要修复。\n\n`;
  }

  report += `## 发现的问题\n\n`;

  const issues = results.filter(r => !r.status.includes('✅'));
  if (issues.length === 0) {
    report += `无问题发现。\n\n`;
  } else {
    issues.forEach((issue, index) => {
      report += `${index + 1}. **${issue.step}**: ${issue.details}\n`;
    });
    report += `\n`;
  }

  report += `## 截图列表\n\n`;
  screenshots.forEach((screenshot, index) => {
    report += `${index + 1}. \`${screenshot}\`\n`;
  });

  report += `\n所有截图保存在: \`${SCREENSHOT_DIR}\`\n`;

  fs.writeFileSync(REPORT_FILE, report, 'utf-8');
  console.log(`\n📊 测试报告已生成: ${REPORT_FILE}`);
}
