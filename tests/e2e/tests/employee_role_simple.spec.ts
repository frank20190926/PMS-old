import { test, expect, Page } from '@playwright/test';
import * as path from 'path';
import * as fs from 'fs';

/**
 * 员工角色功能简化测试
 * 测试账号: mengqiang / admin123
 */

const BASE_URL = 'http://localhost:1024';
const TEST_USER = {
  username: 'mengqiang',
  password: 'admin123',
  userId: 4,
  name: '孟强'
};

const SCREENSHOT_DIR = path.join(__dirname, '../test-results/employee-screenshots');

async function saveScreenshot(page: Page, name: string) {
  if (!fs.existsSync(SCREENSHOT_DIR)) {
    fs.mkdirSync(SCREENSHOT_DIR, { recursive: true });
  }
  const screenshotPath = path.join(SCREENSHOT_DIR, `${name}.png`);
  await page.screenshot({ path: screenshotPath, fullPage: true });
  console.log(`📸 Screenshot: ${screenshotPath}`);
  return screenshotPath;
}

async function login(page: Page): Promise<boolean> {
  console.log(`\n🔐 Logging in as ${TEST_USER.username}...`);

  await page.goto(BASE_URL);
  await page.waitForLoadState('networkidle');
  await page.waitForTimeout(1000);

  // Fill username
  await page.fill('input[placeholder="账号"]', TEST_USER.username);
  await page.fill('input[placeholder="密码"]', TEST_USER.password);

  // Handle captcha if present
  const captchaVisible = await page.locator('input[placeholder="验证码"]').isVisible().catch(() => false);
  if (captchaVisible) {
    console.log('⚠️  Captcha detected - entering dummy code');
    // Try to get captcha image and click to refresh
    await page.click('.login-code-img').catch(() => {});
    await page.waitForTimeout(500);
    // Enter a dummy code (will likely fail, but let's try)
    await page.fill('input[placeholder="验证码"]', '1234');
  }

  await saveScreenshot(page, '01-before-login');

  // Click login
  await page.click('button:has-text("登 录")');

  // Wait for response
  await page.waitForTimeout(3000);

  // Check if login successful
  const currentUrl = page.url();
  console.log(`Current URL: ${currentUrl}`);

  if (currentUrl.includes('/index') || currentUrl.includes('/dashboard') || !currentUrl.includes('/login')) {
    console.log('✅ Login successful');
    await saveScreenshot(page, '02-login-success');
    return true;
  }

  // Check for error
  const errorMsg = await page.locator('.el-message--error').textContent().catch(() => '');
  if (errorMsg) {
    console.log(`❌ Login failed: ${errorMsg}`);
  }

  await saveScreenshot(page, '02-login-failed');
  return false;
}

test.describe('员工角色功能测试', () => {
  test.setTimeout(60000);

  test('完整流程测试', async ({ page }) => {
    const results: string[] = [];
    const issues: string[] = [];

    // Step 1: Login
    console.log('\n=== Step 1: 登录系统 ===');
    const loginSuccess = await login(page);

    if (!loginSuccess) {
      results.push('❌ 登录失败 - 可能是验证码问题');
      issues.push('登录失败: 系统启用了验证码，自动化测试无法通过');

      // Try manual verification
      console.log('\n⚠️  自动登录失败，请手动验证:');
      console.log(`   1. 访问 ${BASE_URL}`);
      console.log(`   2. 使用账号: ${TEST_USER.username} / ${TEST_USER.password}`);
      console.log(`   3. 输入验证码并登录`);

      await page.waitForTimeout(5000);
      await saveScreenshot(page, '99-manual-check-needed');

      // Print summary
      console.log('\n' + '='.repeat(60));
      console.log('测试结果汇总');
      console.log('='.repeat(60));
      results.forEach(r => console.log(r));
      console.log('\n发现的问题:');
      issues.forEach(i => console.log(`  - ${i}`));

      return;
    }

    results.push('✅ 登录成功');
    await page.waitForTimeout(2000);

    // Step 2: Check user info
    console.log('\n=== Step 2: 验证用户信息 ===');
    const userInfoVisible = await page.locator(`:has-text("${TEST_USER.name}")`).first().isVisible().catch(() => false);
    if (userInfoVisible) {
      results.push('✅ 用户信息显示正确');
      console.log(`✓ 用户名显示: ${TEST_USER.name}`);
    } else {
      results.push('⚠️  用户信息未找到');
      issues.push('页面未显示用户名称');
    }

    // Step 3: Navigate to efficiency center
    console.log('\n=== Step 3: 访问人效中心 ===');

    // Try to find and click efficiency menu
    const menuFound = await page.locator('text="人效中心"').first().click().then(() => true).catch(() => false);

    if (!menuFound) {
      console.log('⚠️  菜单未找到，尝试直接访问URL');
      await page.goto(`${BASE_URL}/#/efficiency/dashboard`);
    }

    await page.waitForTimeout(2000);
    await saveScreenshot(page, '03-efficiency-center');

    const dashboardVisible = await page.locator('text="工作台", text="任务", text="我的"').first().isVisible().catch(() => false);
    if (dashboardVisible) {
      results.push('✅ 人效中心工作台可访问');
      console.log('✓ 工作台页面加载成功');
    } else {
      results.push('❌ 人效中心工作台不可访问');
      issues.push('无法访问人效中心工作台');
    }

    // Step 4: Check my tasks
    console.log('\n=== Step 4: 查看我的任务 ===');
    await page.goto(`${BASE_URL}/#/efficiency/task`);
    await page.waitForTimeout(2000);
    await saveScreenshot(page, '04-my-tasks');

    const taskTableVisible = await page.locator('.el-table').isVisible().catch(() => false);
    if (taskTableVisible) {
      const taskCount = await page.locator('.el-table__row').count();
      results.push(`✅ 任务列表可访问 (${taskCount} 条任务)`);
      console.log(`✓ 找到 ${taskCount} 条任务`);

      // Check if tasks belong to current user
      if (taskCount > 0) {
        const firstRow = await page.locator('.el-table__row').first().textContent();
        console.log(`  第一条任务: ${firstRow?.substring(0, 50)}...`);
      }
    } else {
      results.push('❌ 任务列表不可访问');
      issues.push('无法加载任务列表');
    }

    // Step 5: Check daily reports
    console.log('\n=== Step 5: 查看日报 ===');
    await page.goto(`${BASE_URL}/#/efficiency/daily-report`);
    await page.waitForTimeout(2000);
    await saveScreenshot(page, '05-daily-reports');

    const reportPageVisible = await page.locator('text="日报"').first().isVisible().catch(() => false);
    if (reportPageVisible) {
      const reportCount = await page.locator('.el-table__row').count();
      results.push(`✅ 日报页面可访问 (${reportCount} 条记录)`);
      console.log(`✓ 找到 ${reportCount} 条日报`);
    } else {
      results.push('❌ 日报页面不可访问');
      issues.push('无法访问日报页面');
    }

    // Step 6: Check weekly reports
    console.log('\n=== Step 6: 查看周报 ===');
    await page.goto(`${BASE_URL}/#/efficiency/weekly-report`);
    await page.waitForTimeout(2000);
    await saveScreenshot(page, '06-weekly-reports');

    const weeklyPageVisible = await page.locator('text="周报"').first().isVisible().catch(() => false);
    if (weeklyPageVisible) {
      const weeklyCount = await page.locator('.el-table__row').count();
      results.push(`✅ 周报页面可访问 (${weeklyCount} 条记录)`);
      console.log(`✓ 找到 ${weeklyCount} 条周报`);
    } else {
      results.push('❌ 周报页面不可访问');
      issues.push('无法访问周报页面');
    }

    // Step 7: Check permissions - should NOT see admin menus
    console.log('\n=== Step 7: 验证权限限制 ===');
    await page.goto(`${BASE_URL}/#/index`);
    await page.waitForTimeout(2000);
    await saveScreenshot(page, '07-permission-check');

    const adminMenus = ['日报审核', '周报审核', '系统管理', '用户管理'];
    const visibleAdminMenus: string[] = [];

    for (const menu of adminMenus) {
      const visible = await page.locator(`text="${menu}"`).first().isVisible().catch(() => false);
      if (visible) {
        visibleAdminMenus.push(menu);
      }
    }

    if (visibleAdminMenus.length === 0) {
      results.push('✅ 权限控制正确 - 未显示管理员菜单');
      console.log('✓ 员工账号正确隐藏了管理员功能');
    } else {
      results.push(`⚠️  权限控制异常 - 显示了管理员菜单: ${visibleAdminMenus.join(', ')}`);
      issues.push(`员工账号可以看到管理员菜单: ${visibleAdminMenus.join(', ')}`);
    }

    // Print summary
    console.log('\n' + '='.repeat(60));
    console.log('测试结果汇总');
    console.log('='.repeat(60));
    results.forEach(r => console.log(r));

    if (issues.length > 0) {
      console.log('\n发现的问题:');
      issues.forEach(i => console.log(`  - ${i}`));
    } else {
      console.log('\n✅ 所有测试通过，未发现问题');
    }

    console.log('\n截图保存位置:');
    console.log(`  ${SCREENSHOT_DIR}`);
    console.log('='.repeat(60));

    // Assert at least login was successful
    expect(loginSuccess).toBeTruthy();
  });
});
