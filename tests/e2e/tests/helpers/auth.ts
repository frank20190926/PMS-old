import { expect, Page } from '@playwright/test';
import { hideDevServerOverlay } from './navigation';

type LoginParams = {
  username: string;
  password: string;
};

export async function login(page: Page, { username, password }: LoginParams) {
  if (!username || !password) {
    throw new Error('缺少登录账号或密码，请设置 PMS_PM_USER/PMS_PM_PASS 或 PMS_EMP_USER/PMS_EMP_PASS');
  }

  const apiBase = process.env.PMS_BASE_URL || 'http://localhost:8090';
  const loginResponse = await page.request.post(`${apiBase}/login`, {
    data: { username, password, code: '', uuid: '' }
  });
  const loginData = await loginResponse.json().catch(() => null);

  if (!loginResponse.ok() || !loginData || loginData.code !== 200 || !loginData.token) {
    const message = loginData?.msg || loginData?.message || loginResponse.statusText();
    throw new Error(`API 登录失败：${message || '未知错误'}`);
  }

  const baseUrl = process.env.PMS_UI_URL || 'http://localhost:1024';
  await page.context().addCookies([
    {
      name: 'Admin-Token',
      value: loginData.token,
      url: baseUrl
    }
  ]);

  await page.goto('/');
  await hideDevServerOverlay(page);
  await Promise.all([
    page.waitForResponse(resp => resp.url().includes('/getInfo') && resp.status() === 200, { timeout: 15_000 }).catch(() => {}),
    page.waitForResponse(resp => resp.url().includes('/getRouters') && resp.status() === 200, { timeout: 15_000 }).catch(() => {})
  ]);
  await expect(page.getByText('人效中心').first()).toBeVisible({ timeout: 15_000 });
  return loginData.token as string;
}
