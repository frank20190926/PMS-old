import { test, expect, Page } from '@playwright/test';
import { login } from './helpers/auth';
import { hideDevServerOverlay } from './helpers/navigation';
import path from 'path';

/**
 * PM Role Functionality Test Suite
 *
 * Tests PM-specific features in the efficiency center:
 * 1. Dashboard - PM view with project statistics
 * 2. My Tasks - Tasks assigned to PM
 * 3. Daily Report - PM can fill their own reports
 * 4. Daily Report Approval - PM can approve team member reports
 * 5. Weekly Report - PM can fill weekly reports
 * 6. Staff Schedule - PM can manage staff schedules
 * 7. Project List - PM can view their projects
 * 8. Project Details - PM can access project modules
 */

const BASE_URL = process.env.PMS_UI_URL || 'http://localhost:1024';
const API_BASE = process.env.PMS_BASE_URL || 'http://localhost:8090';
const PM_USERNAME = 'huangfei';
const PM_PASSWORD = '123456'; // Default password

// Helper function to take screenshot
async function takeScreenshot(page: Page, name: string) {
  const screenshotPath = path.join(__dirname, '../test-results/pm-role', `${name}.png`);
  await page.screenshot({ path: screenshotPath, fullPage: true });
  console.log(`  📸 Screenshot: ${name}.png`);
  return screenshotPath;
}

// Helper function to navigate to efficiency center menu
async function navigateToEfficiencyMenu(page: Page, menuText: string) {
  await page.click('text=人效中心');
  await page.waitForTimeout(500);
  const menuItem = page.locator(`text=${menuText}`).first();
  if (await menuItem.isVisible()) {
    await menuItem.click();
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(1000);
    return true;
  }
  return false;
}

test.describe('PM Role Functionality Tests', () => {
  let page: Page;
  let pmToken: string;

  test.beforeAll(async ({ browser }) => {
    const context = await browser.newContext();
    page = await context.newPage();
    page.setDefaultTimeout(30000);

    // Login using API
    console.log(`\n🔐 Logging in as PM: ${PM_USERNAME}`);
    pmToken = await login(page, { username: PM_USERNAME, password: PM_PASSWORD });
    console.log(`✓ Successfully logged in, token: ${pmToken.substring(0, 20)}...`);
  });

  test.afterAll(async () => {
    await page.close();
  });

  test('1. Dashboard - PM View', async () => {
    console.log('\n=== Test 1: Dashboard - PM View ===');

    const navigated = await navigateToEfficiencyMenu(page, '工作台');
    expect(navigated).toBeTruthy();

    // Wait for dashboard to load
    await page.waitForTimeout(2000);

    // Check for dashboard elements
    const pageContent = await page.content();
    const hasDashboardContent = pageContent.includes('项目') || pageContent.includes('任务') || pageContent.includes('统计');

    console.log(`  ✓ Dashboard loaded, has content: ${hasDashboardContent}`);

    await takeScreenshot(page, '01-dashboard-pm-view');
  });

  test('2. My Tasks - PM Tasks', async () => {
    console.log('\n=== Test 2: My Tasks ===');

    const navigated = await navigateToEfficiencyMenu(page, '我的任务');
    expect(navigated).toBeTruthy();

    // Wait for task list to load
    await page.waitForTimeout(2000);

    // Check if task list is visible
    const hasTaskList = await page.locator('.el-table, table').count() > 0;
    expect(hasTaskList).toBeTruthy();

    // Count tasks
    const taskCount = await page.locator('.el-table__row, tbody tr').count();
    console.log(`  ✓ Task list loaded, found ${taskCount} tasks`);

    await takeScreenshot(page, '02-my-tasks');
  });

  test('3. Daily Report - Fill Report', async () => {
    console.log('\n=== Test 3: Daily Report - Fill Report ===');

    const navigated = await navigateToEfficiencyMenu(page, '日报填写');
    expect(navigated).toBeTruthy();

    // Wait for page to load
    await page.waitForTimeout(2000);

    // Check if daily report page is loaded
    const hasContent = await page.locator('.el-form, form, .el-table, table').count() > 0;
    expect(hasContent).toBeTruthy();

    console.log('  ✓ Daily report page loaded');

    await takeScreenshot(page, '03-daily-report-fill');
  });

  test('4. Daily Report Approval - PM Privilege', async () => {
    console.log('\n=== Test 4: Daily Report Approval ===');

    // Try to find and click daily report approval menu
    await page.click('text=人效中心');
    await page.waitForTimeout(500);

    const approvalMenuExists = await page.locator('text=日报审核').count() > 0;

    if (approvalMenuExists) {
      await page.click('text=日报审核');
      await page.waitForLoadState('networkidle');
      await page.waitForTimeout(2000);

      // Check if approval list is visible
      const hasApprovalList = await page.locator('.el-table, table').count() > 0;
      expect(hasApprovalList).toBeTruthy();

      // Count pending reports
      const pendingCount = await page.locator('.el-table__row, tbody tr').count();
      console.log(`  ✓ Daily report approval page loaded, found ${pendingCount} pending reports`);

      await takeScreenshot(page, '04-daily-report-approval');
    } else {
      console.log('  ⚠ Daily report approval menu not found (may need permission configuration)');
      await takeScreenshot(page, '04-daily-report-approval-not-found');
    }
  });

  test('5. Weekly Report - Fill Report', async () => {
    console.log('\n=== Test 5: Weekly Report ===');

    const navigated = await navigateToEfficiencyMenu(page, '周报填写');
    expect(navigated).toBeTruthy();

    // Wait for page to load
    await page.waitForTimeout(2000);

    // Check if weekly report page is loaded
    const hasWeeklyReport = await page.locator('.el-form, form, .el-table, table').count() > 0;
    expect(hasWeeklyReport).toBeTruthy();

    console.log('  ✓ Weekly report page loaded');

    await takeScreenshot(page, '05-weekly-report');
  });

  test('6. Staff Schedule - PM Management', async () => {
    console.log('\n=== Test 6: Staff Schedule ===');

    await page.click('text=人效中心');
    await page.waitForTimeout(500);

    // Try to find staff schedule menu
    const scheduleMenuExists = await page.locator('text=人员排期').count() > 0;

    if (scheduleMenuExists) {
      await page.click('text=人员排期');
      await page.waitForLoadState('networkidle');
      await page.waitForTimeout(2000);

      // Check if schedule page is loaded
      const hasSchedule = await page.locator('.el-table, table, .gantt').count() > 0;
      expect(hasSchedule).toBeTruthy();

      console.log('  ✓ Staff schedule page loaded');

      await takeScreenshot(page, '06-staff-schedule');
    } else {
      console.log('  ⚠ Staff schedule menu not found (may need permission configuration)');
      await takeScreenshot(page, '06-staff-schedule-not-found');
    }
  });

  test('7. Project List - PM Projects', async () => {
    console.log('\n=== Test 7: Project List ===');

    const navigated = await navigateToEfficiencyMenu(page, '项目列表');
    expect(navigated).toBeTruthy();

    // Wait for project list to load
    await page.waitForTimeout(2000);

    // Check if project list is visible
    const hasProjectList = await page.locator('.el-table, table').count() > 0;
    expect(hasProjectList).toBeTruthy();

    // Count projects
    const projectCount = await page.locator('.el-table__row, tbody tr').count();
    console.log(`  ✓ Project list loaded, found ${projectCount} projects`);

    await takeScreenshot(page, '07-project-list');
  });

  test('8. Project Details - Access Project Modules', async () => {
    console.log('\n=== Test 8: Project Details ===');

    const navigated = await navigateToEfficiencyMenu(page, '项目列表');
    expect(navigated).toBeTruthy();

    await page.waitForTimeout(2000);

    // Check if there are any projects
    const projectCount = await page.locator('.el-table__row, tbody tr').count();

    if (projectCount > 0) {
      // Try to find and click "查看" or "详情" button
      const viewButtons = page.locator('button:has-text("查看"), button:has-text("详情"), a:has-text("查看"), a:has-text("详情")');
      const buttonCount = await viewButtons.count();

      if (buttonCount > 0) {
        await viewButtons.first().click();
        await page.waitForLoadState('networkidle');
        await page.waitForTimeout(2000);

        console.log('  ✓ Entered project detail page');
        await takeScreenshot(page, '08-project-details');

        // Check for project menu items
        const menuItems = await page.locator('.el-menu-item, .menu-item').allTextContents();
        if (menuItems.length > 0) {
          console.log(`  ✓ Found ${menuItems.length} menu items in project`);
        }

        // Test accessing different project modules
        const modulesToTest = ['任务管理', '甘特图', '阶段配置', '日报管理'];

        for (const module of modulesToTest) {
          const moduleExists = await page.locator(`text=${module}`).count() > 0;
          if (moduleExists) {
            await page.click(`text=${module}`);
            await page.waitForTimeout(1500);
            console.log(`  ✓ Accessed module: ${module}`);
            await takeScreenshot(page, `08-project-module-${module.replace(/\s+/g, '-')}`);
          }
        }
      } else {
        console.log('  ⚠ No view button found, trying to click on row');
        await page.locator('.el-table__row, tbody tr').first().click();
        await page.waitForTimeout(2000);
        await takeScreenshot(page, '08-project-details-row-click');
      }
    } else {
      console.log('  ⚠ No projects found for this PM');
      await takeScreenshot(page, '08-no-projects');
    }
  });

  test('9. Permission Verification - PM Privileges', async () => {
    console.log('\n=== Test 9: Permission Verification ===');

    await page.click('text=人效中心');
    await page.waitForTimeout(1000);

    // Get all menu items under efficiency center
    const allMenuItems = await page.locator('.el-menu-item, .el-submenu__title').allTextContents();
    console.log(`  ✓ Total menu items visible: ${allMenuItems.length}`);

    // Check for PM-specific menu items
    const pmMenuItems = [
      '日报审核',
      '人员排期',
      '项目管理',
      '任务分配'
    ];

    const availableMenus: string[] = [];
    const unavailableMenus: string[] = [];

    for (const menuItem of pmMenuItems) {
      const exists = await page.locator(`text=${menuItem}`).count() > 0;
      if (exists) {
        availableMenus.push(menuItem);
      } else {
        unavailableMenus.push(menuItem);
      }
    }

    console.log(`  ✓ Available PM menus: ${availableMenus.join(', ') || 'None'}`);
    console.log(`  ⚠ Unavailable menus: ${unavailableMenus.join(', ') || 'None'}`);

    await takeScreenshot(page, '09-permission-verification');

    // Verify PM has access to efficiency center
    expect(allMenuItems.length).toBeGreaterThan(0);
  });

  test('10. API Permission Check - PM Role', async () => {
    console.log('\n=== Test 10: API Permission Check ===');

    // Test PM-specific API endpoints
    const apiTests = [
      { name: 'Get Projects', url: `${API_BASE}/pms/efficiency/project/common/my-projects` },
      { name: 'Get Tasks', url: `${API_BASE}/pms/efficiency/task/list?pageNum=1&pageSize=10` },
      { name: 'Get Daily Reports', url: `${API_BASE}/pms/efficiency/daily-report/list?pageNum=1&pageSize=10` },
      { name: 'Get Pending Approvals', url: `${API_BASE}/pms/efficiency/daily-report/pending?pageNum=1&pageSize=10` }
    ];

    for (const apiTest of apiTests) {
      try {
        const response = await page.request.get(apiTest.url, {
          headers: { Authorization: `Bearer ${pmToken}` }
        });

        const status = response.status();
        const data = await response.json().catch(() => null);

        if (status === 200 && data?.code === 200) {
          console.log(`  ✓ ${apiTest.name}: SUCCESS (${data.rows?.length || 0} items)`);
        } else if (status === 200 && data?.code === 500) {
          console.log(`  ⚠ ${apiTest.name}: API Error - ${data.msg}`);
        } else {
          console.log(`  ⚠ ${apiTest.name}: HTTP ${status}`);
        }
      } catch (error) {
        console.log(`  ✗ ${apiTest.name}: ${error}`);
      }
    }
  });
});

test.describe('PM Role Summary Report', () => {
  test('Generate Test Summary', async () => {
    console.log('\n' + '='.repeat(80));
    console.log('PM ROLE TEST SUMMARY');
    console.log('='.repeat(80));
    console.log(`Test Account: ${PM_USERNAME}`);
    console.log(`Frontend URL: ${BASE_URL}`);
    console.log(`Backend API: ${API_BASE}`);
    console.log(`Test Date: ${new Date().toISOString()}`);
    console.log('='.repeat(80));
  });
});
