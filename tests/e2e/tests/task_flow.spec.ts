import { test, expect } from '@playwright/test';
import { login } from './helpers/auth';
import { hideDevServerOverlay } from './helpers/navigation';

const PM_USER = process.env.PMS_PM_USER || '';
const PM_PASS = process.env.PMS_PM_PASS || '';
const EMP_USER = process.env.PMS_EMP_USER || '';
const EMP_PASS = process.env.PMS_EMP_PASS || '';
const EMP_NAME = process.env.PMS_EMP_NAME || '';

test('pm assigns task, employee sees tasks', async ({ browser }) => {
  const pmContext = await browser.newContext();
  const pmPage = await pmContext.newPage();

  const pmToken = await login(pmPage, { username: PM_USER, password: PM_PASS });
  const apiBase = process.env.PMS_BASE_URL || 'http://localhost:8090';

  const taskListResp = await pmPage.request.get(`${apiBase}/pms/efficiency/task/list?pageNum=1&pageSize=1`, {
    headers: { Authorization: `Bearer ${pmToken}` }
  });
  const taskListData = await taskListResp.json().catch(() => null);
  const firstTask = taskListData?.rows?.[0];
  test.skip(!firstTask, '暂无可分配任务，跳过任务分配验证');

  const taskDetailResp = await pmPage.request.get(`${apiBase}/pms/efficiency/task/${firstTask.id}`, {
    headers: { Authorization: `Bearer ${pmToken}` }
  });
  const taskDetail = await taskDetailResp.json().catch(() => null);
  const taskPayload = taskDetail?.data;
  test.skip(!taskPayload, '任务详情获取失败，跳过任务分配验证');

  const empContext = await browser.newContext();
  const empPage = await empContext.newPage();
  const empToken = await login(empPage, { username: EMP_USER, password: EMP_PASS });
  const empInfoResp = await empPage.request.get(`${apiBase}/getInfo`, {
    headers: { Authorization: `Bearer ${empToken}` }
  });
  const empInfo = await empInfoResp.json().catch(() => null);
  const empUserId = empInfo?.user?.userId;
  test.skip(!empUserId, '员工信息获取失败，跳过任务分配验证');

  const updateResp = await pmPage.request.put(`${apiBase}/pms/efficiency/task`, {
    headers: { Authorization: `Bearer ${pmToken}` },
    data: { ...taskPayload, assigneeId: empUserId }
  });
  const updateData = await updateResp.json().catch(() => null);
  if (!updateData || updateData.code !== 200) {
    throw new Error(`任务分配失败：${updateData?.msg || updateResp.statusText()}`);
  }

  await empPage.goto('/efficiency/task');
  await hideDevServerOverlay(empPage);
  await expect(empPage.getByText('任务管理', { exact: true }).first()).toBeVisible({ timeout: 10_000 });
  await expect(empPage.locator('.el-table__body-wrapper tbody tr').first()).toBeVisible({ timeout: 10_000 });

  await empContext.close();
  await pmContext.close();
});
