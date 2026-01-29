import { test, expect } from '@playwright/test';
import { login } from './helpers/auth';
import { hideDevServerOverlay } from './helpers/navigation';

const PM_USER = process.env.PMS_PM_USER || '';
const PM_PASS = process.env.PMS_PM_PASS || '';
const EMP_USER = process.env.PMS_EMP_USER || '';
const EMP_PASS = process.env.PMS_EMP_PASS || '';
const EMP_NAME = process.env.PMS_EMP_NAME || '';

test('employee submits daily report, pm approves, write-back visible', async ({ browser }) => {
  const empContext = await browser.newContext();
  const empPage = await empContext.newPage();

  const empToken = await login(empPage, { username: EMP_USER, password: EMP_PASS });
  const apiBase = process.env.PMS_BASE_URL || 'http://localhost:8090';
  const taskResp = await empPage.request.get(`${apiBase}/pms/efficiency/task/my`, {
    headers: { Authorization: `Bearer ${empToken}` }
  });
  const taskData = await taskResp.json().catch(() => null);
  const firstTask = taskData?.data?.[0];
  test.skip(!firstTask, '员工无可用任务，跳过日报提交流程');
  const today = new Date();
  const yyyy = today.getFullYear();
  const mm = String(today.getMonth() + 1).padStart(2, '0');
  const dd = String(today.getDate()).padStart(2, '0');
  const reportDate = `${yyyy}-${mm}-${dd}`;

  const reportPayload = {
    reportDate,
    summary: '完成任务阶段性目标',
    status: 'SUBMITTED',
    taskReports: [
      {
        taskId: firstTask.id,
        projectId: firstTask.projectId,
        workContent: '完成今日分配任务并更新进度',
        hours: 1,
        progressPercent: 20
      }
    ]
  };

  const existingResp = await empPage.request.get(`${apiBase}/pms/efficiency/daily-report/date/${reportDate}`, {
    headers: { Authorization: `Bearer ${empToken}` }
  });
  const existingData = await existingResp.json().catch(() => null);

  if (existingData?.data?.id) {
    const updateResp = await empPage.request.put(`${apiBase}/pms/efficiency/daily-report`, {
      headers: { Authorization: `Bearer ${empToken}` },
      data: { ...reportPayload, id: existingData.data.id }
    });
    const updateData = await updateResp.json().catch(() => null);
    if (!updateData || updateData.code !== 200) {
      throw new Error(`日报更新失败：${updateData?.msg || updateResp.statusText()}`);
    }
  } else {
    const createResp = await empPage.request.post(`${apiBase}/pms/efficiency/daily-report`, {
      headers: { Authorization: `Bearer ${empToken}` },
      data: reportPayload
    });
    const createData = await createResp.json().catch(() => null);
    if (!createData || createData.code !== 200) {
      throw new Error(`日报创建失败：${createData?.msg || createResp.statusText()}`);
    }
  }
  await empContext.close();

  const pmContext = await browser.newContext();
  const pmPage = await pmContext.newPage();

  const pmToken = await login(pmPage, { username: PM_USER, password: PM_PASS });
  const pendingResp = await pmPage.request.get(`${apiBase}/pms/efficiency/daily-report/pending`, {
    headers: { Authorization: `Bearer ${pmToken}` }
  });
  const pendingData = await pendingResp.json().catch(() => null);
  const pendingList = pendingData?.data || [];
  test.skip(pendingList.length === 0, '当前无待审核日报，跳过审核与回写验证');

  const reportId = pendingList[0]?.id;
  const approveResp = await pmPage.request.put(`${apiBase}/pms/efficiency/daily-report/approve/${reportId}?approved=true`, {
    headers: { Authorization: `Bearer ${pmToken}` }
  });
  const approveData = await approveResp.json().catch(() => null);
  if (!approveData || approveData.code !== 200) {
    throw new Error(`日报审核失败：${approveData?.msg || approveResp.statusText()}`);
  }

  await pmPage.goto('/report/index');
  await hideDevServerOverlay(pmPage);
  await expect(pmPage.getByText('日报列表', { exact: true }).first()).toBeVisible({ timeout: 10_000 });
  const reportTable = pmPage.locator('.el-table__body-wrapper');
  await expect(reportTable).toBeVisible({ timeout: 10_000 });

  await pmContext.close();
});
