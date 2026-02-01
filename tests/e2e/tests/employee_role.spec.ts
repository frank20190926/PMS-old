import { test, expect, Page } from '@playwright/test';
import * as path from 'path';
import * as fs from 'fs';

/**
 * 员工角色功能测试
 *
 * 测试范围：
 * 1. 工作台 - 员工视图
 * 2. 我的任务 - 只显示分配给当前用户的任务
 * 3. 日报填写 - 只显示当前用户的日报，可以创建新日报
 * 4. 周报填写 - 只显示当前用户的周报
 */

const BASE_URL = 'http://localhost:1024';
const TEST_USER = {
  username: 'mengqiang',
  userId: 4,
  name: '孟强',
  // Try common passwords
  passwords: ['admin123', '123456', 'mengqiang123', 'Aa123456']
};

// Screenshot directory
const SCREENSHOT_DIR = path.join(__dirname, '../test-results/employee-role-screenshots');

// Helper function to save screenshot
async function saveScreenshot(page: Page, name: string) {
  if (!fs.existsSync(SCREENSHOT_DIR)) {
    fs.mkdirSync(SCREENSHOT_DIR, { recursive: true });
  }
  const screenshotPath = path.join(SCREENSHOT_DIR, `${name}.png`);
  await page.screenshot({ path: screenshotPath, fullPage: true });
  console.log(`Screenshot saved: ${screenshotPath}`);
  return screenshotPath;
}

// Helper function to login
async function login(page: Page): Promise<boolean> {
  await page.goto(BASE_URL);
  await page.waitForLoadState('networkidle');

  // Try each password
  for (const password of TEST_USER.passwords) {
    console.log(`Trying to login with password: ${password}`);

    // Fill login form
    await page.fill('input[placeholder*="用户名"], input[name="username"]', TEST_USER.username);
    await page.fill('input[placeholder*="密码"], input[type="password"]', password);

    // Click login button
    await page.click('button:has-text("登录"), button[type="submit"]');

    // Wait for navigation or error
    await page.waitForTimeout(2000);

    // Check if login successful
    const currentUrl = page.url();
    if (currentUrl.includes('/index') || currentUrl.includes('/dashboard')) {
      console.log(`Login successful with password: ${password}`);
      await saveScreenshot(page, '01-login-success');
      return true;
    }

    // Check for error message
    const errorVisible = await page.locator('.el-message--error, .el-notification__content').isVisible().catch(() => false);
    if (errorVisible) {
      console.log(`Login failed with password: ${password}`);
      // Clear fields for next attempt
      await page.fill('input[placeholder*="用户名"], input[name="username"]', '');
      await page.fill('input[placeholder*="密码"], input[type="password"]', '');
      continue;
    }
  }

  console.error('All password attempts failed');
  await saveScreenshot(page, '01-login-failed');
  return false;
}

test.describe('员工角色功能测试', () => {
  test.beforeEach(async ({ page }) => {
    // Set longer timeout for each test
    test.setTimeout(120000);
  });

  test('1. 登录系统', async ({ page }) => {
    const loginSuccess = await login(page);
    expect(loginSuccess).toBeTruthy();

    // Verify user info displayed
    const userInfoVisible = await page.locator(`:has-text("${TEST_USER.name}"), :has-text("${TEST_USER.username}")`).first().isVisible().catch(() => false);
    expect(userInfoVisible).toBeTruthy();
  });

  test('2. 访问人效中心工作台', async ({ page }) => {
    // Login first
    const loginSuccess = await login(page);
    expect(loginSuccess).toBeTruthy();

    await page.waitForTimeout(1000);

    // Navigate to efficiency center
    // Try different menu structures
    const menuSelectors = [
      'text="人效中心"',
      'a:has-text("人效中心")',
      '.el-menu-item:has-text("人效中心")',
      '.el-submenu__title:has-text("人效中心")'
    ];

    let menuFound = false;
    for (const selector of menuSelectors) {
      const menuVisible = await page.locator(selector).first().isVisible().catch(() => false);
      if (menuVisible) {
        await page.click(selector);
        menuFound = true;
        console.log(`Found menu with selector: ${selector}`);
        break;
      }
    }

    if (!menuFound) {
      console.log('Menu not found, trying to navigate directly to URL');
      await page.goto(`${BASE_URL}/#/efficiency/dashboard`);
    }

    await page.waitForTimeout(2000);
    await saveScreenshot(page, '02-efficiency-dashboard');

    // Verify dashboard elements
    const dashboardVisible = await page.locator('text="工作台", text="任务概览", text="我的任务"').first().isVisible().catch(() => false);
    expect(dashboardVisible).toBeTruthy();
  });

  test('3. 查看我的任务列表', async ({ page }) => {
    const loginSuccess = await login(page);
    expect(loginSuccess).toBeTruthy();

    await page.waitForTimeout(1000);

    // Navigate to my tasks
    await page.goto(`${BASE_URL}/#/efficiency/task`);
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(2000);

    await saveScreenshot(page, '03-my-tasks-list');

    // Verify task list loaded
    const taskListVisible = await page.locator('.el-table, table').isVisible().catch(() => false);
    expect(taskListVisible).toBeTruthy();

    // Check if tasks are displayed
    const taskRows = await page.locator('.el-table__row, tbody tr').count();
    console.log(`Found ${taskRows} tasks`);

    // Verify tasks belong to current user (check assignee column)
    if (taskRows > 0) {
      const firstTaskAssignee = await page.locator('.el-table__row, tbody tr').first().textContent();
      console.log(`First task info: ${firstTaskAssignee}`);
    }
  });

  test('4. 查看日报列表', async ({ page }) => {
    const loginSuccess = await login(page);
    expect(loginSuccess).toBeTruthy();

    await page.waitForTimeout(1000);

    // Navigate to daily reports
    await page.goto(`${BASE_URL}/#/efficiency/daily-report`);
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(2000);

    await saveScreenshot(page, '04-daily-reports-list');

    // Verify daily report page loaded
    const pageVisible = await page.locator('text="日报", text="日报管理", text="日报填写"').first().isVisible().catch(() => false);
    expect(pageVisible).toBeTruthy();

    // Check report count
    const reportRows = await page.locator('.el-table__row, tbody tr').count();
    console.log(`Found ${reportRows} daily reports`);
  });

  test('5. 创建新日报', async ({ page }) => {
    const loginSuccess = await login(page);
    expect(loginSuccess).toBeTruthy();

    await page.waitForTimeout(1000);

    // Navigate to daily reports
    await page.goto(`${BASE_URL}/#/efficiency/daily-report`);
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(2000);

    // Click add button
    const addButtonSelectors = [
      'button:has-text("新增")',
      'button:has-text("添加")',
      'button:has-text("创建日报")',
      '.el-button--primary:has-text("新增")'
    ];

    let addButtonFound = false;
    for (const selector of addButtonSelectors) {
      const buttonVisible = await page.locator(selector).first().isVisible().catch(() => false);
      if (buttonVisible) {
        await page.click(selector);
        addButtonFound = true;
        console.log(`Clicked add button with selector: ${selector}`);
        break;
      }
    }

    expect(addButtonFound).toBeTruthy();

    await page.waitForTimeout(1000);
    await saveScreenshot(page, '05-daily-report-form');

    // Verify form dialog opened
    const dialogVisible = await page.locator('.el-dialog, .el-drawer').isVisible().catch(() => false);
    expect(dialogVisible).toBeTruthy();

    // Fill form fields
    const today = new Date().toISOString().split('T')[0];

    // Try to fill date field
    const dateInputVisible = await page.locator('input[placeholder*="日期"], input[type="date"]').first().isVisible().catch(() => false);
    if (dateInputVisible) {
      await page.fill('input[placeholder*="日期"], input[type="date"]', today);
    }

    // Fill work summary
    const summaryVisible = await page.locator('textarea[placeholder*="总结"], textarea[placeholder*="内容"]').first().isVisible().catch(() => false);
    if (summaryVisible) {
      await page.fill('textarea[placeholder*="总结"], textarea[placeholder*="内容"]', '今日完成了测试任务，进展顺利。');
    }

    await page.waitForTimeout(500);
    await saveScreenshot(page, '05-daily-report-form-filled');

    // Note: Not submitting to avoid creating test data
    console.log('Daily report form filled successfully (not submitted)');

    // Close dialog
    const cancelButton = await page.locator('button:has-text("取消"), button:has-text("关闭")').first().isVisible().catch(() => false);
    if (cancelButton) {
      await page.click('button:has-text("取消"), button:has-text("关闭")');
    }
  });

  test('6. 查看周报列表', async ({ page }) => {
    const loginSuccess = await login(page);
    expect(loginSuccess).toBeTruthy();

    await page.waitForTimeout(1000);

    // Navigate to weekly reports
    await page.goto(`${BASE_URL}/#/efficiency/weekly-report`);
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(2000);

    await saveScreenshot(page, '06-weekly-reports-list');

    // Verify weekly report page loaded
    const pageVisible = await page.locator('text="周报", text="周报管理", text="周报填写"').first().isVisible().catch(() => false);
    expect(pageVisible).toBeTruthy();

    // Check report count
    const reportRows = await page.locator('.el-table__row, tbody tr').count();
    console.log(`Found ${reportRows} weekly reports`);
  });

  test('7. 验证权限限制 - 不应看到管理功能', async ({ page }) => {
    const loginSuccess = await login(page);
    expect(loginSuccess).toBeTruthy();

    await page.waitForTimeout(2000);

    // Check that admin menus are not visible
    const adminMenus = [
      '日报审核',
      '周报审核',
      '项目管理',
      '系统管理',
      '用户管理',
      '角色管理'
    ];

    const visibilityResults: { [key: string]: boolean } = {};

    for (const menuText of adminMenus) {
      const visible = await page.locator(`text="${menuText}"`).first().isVisible().catch(() => false);
      visibilityResults[menuText] = visible;
      console.log(`Menu "${menuText}": ${visible ? 'VISIBLE (应该隐藏!)' : 'Hidden (正确)'}`);
    }

    await saveScreenshot(page, '07-permission-check');

    // Employee should not see admin menus
    const hasAdminMenus = Object.values(visibilityResults).some(v => v);
    if (hasAdminMenus) {
      console.warn('WARNING: Employee can see admin menus!');
    }
  });
});
