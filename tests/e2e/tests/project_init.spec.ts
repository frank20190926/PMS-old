import { test, expect } from '@playwright/test';

test('project init placeholder', async ({ page }) => {
  await page.goto(process.env.PMS_UI_URL || 'http://localhost:1025');
  await expect(page).toHaveTitle(/PMS/i);
});
