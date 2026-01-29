import { test, expect } from '@playwright/test';
import { login } from './helpers/auth';
import { confirmDialog, hideDevServerOverlay, selectFirstOption } from './helpers/navigation';

const PM_USER = process.env.PMS_PM_USER || '';
const PM_PASS = process.env.PMS_PM_PASS || '';

async function gotoPhaseSetup(page) {
  await page.goto('/efficiency/project/phase');
  await page.waitForLoadState('networkidle').catch(() => {});
  await page.waitForTimeout(1000);
  const header = page.getByText('项目阶段配置').first();
  if (await header.isVisible().catch(() => false)) {
    return;
  }

  await page.goto('/');
  await hideDevServerOverlay(page);

  const sidebar = page.locator('.sidebar-container');
  const hasSidebar = await sidebar.count();

  if (hasSidebar) {
    await sidebar.getByText('人效中心', { exact: true }).click({ force: true });
    await sidebar.getByText('项目生命周期', { exact: true }).click({ force: true });
    const phaseMenu = sidebar.getByText('阶段配置', { exact: true });
    await phaseMenu.waitFor({ state: 'visible', timeout: 5_000 }).catch(() => {});
    await phaseMenu.click({ force: true });
    if (await header.isVisible().catch(() => false)) {
      return;
    }
  }

  throw new Error('无法打开“项目阶段配置”页面，请检查菜单路由/组件配置');
}

test('project init and milestone generation', async ({ page }) => {
  await login(page, { username: PM_USER, password: PM_PASS });

  await gotoPhaseSetup(page);
  await expect(page.getByText('项目阶段配置')).toBeVisible();

  await hideDevServerOverlay(page);
  await page.getByPlaceholder('请选择项目').click({ force: true });
  const selected = await selectFirstOption(page);
  test.skip(!selected, '阶段配置项目列表为空或接口不可用，无法执行项目初始化流程');

  await page.getByRole('button', { name: '保存阶段配置' }).click();
  await confirmDialog(page);
  await expect(page.getByText('阶段配置保存成功')).toBeVisible({ timeout: 10_000 });

  await page.getByRole('button', { name: '生成阶段任务' }).click();
  await confirmDialog(page);
  await expect(page.getByText('任务生成成功')).toBeVisible({ timeout: 10_000 });
});
