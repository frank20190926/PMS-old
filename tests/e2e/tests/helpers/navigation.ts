import { expect, Page } from '@playwright/test';

export async function gotoEfficiencyHome(page: Page) {
  await page.goto('/pms/efficiency');
  await expect(page.getByText('人效中心')).toBeVisible({ timeout: 10_000 });
}

export async function gotoPathAndAssertHeader(page: Page, path: string, headerText: string) {
  await page.goto(path);
  await expect(page.getByText(headerText).first()).toBeVisible({ timeout: 10_000 });
}

export async function selectFirstOption(page: Page) {
  await hideDevServerOverlay(page);
  const dropdown = page.locator('.el-select-dropdown:visible');
  await dropdown.waitFor({ timeout: 5_000 }).catch(() => {});

  const option = dropdown.locator('.el-select-dropdown__item').first();
  const empty = dropdown.locator('.el-select-dropdown__empty');

  if ((await option.count()) === 0) {
    if ((await empty.count()) > 0) {
      return false;
    }
    return false;
  }

  await option.waitFor({ timeout: 5_000 });
  await option.click({ force: true });
  return true;
}

export async function confirmDialog(page: Page, buttonText = '确定') {
  const dialog = page.locator('.el-message-box:visible');
  if ((await dialog.count()) === 0) {
    return;
  }
  await dialog.getByRole('button', { name: buttonText }).click();
}

export async function hideDevServerOverlay(page: Page) {
  await page.addStyleTag({
    content: '#webpack-dev-server-client-overlay{display:none !important;}'
  });
  await page.evaluate(() => {
    const overlay = document.getElementById('webpack-dev-server-client-overlay');
    if (overlay) overlay.remove();
  });
}
