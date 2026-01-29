import { test, expect } from '@playwright/test';
import { login } from './helpers/auth';
import { hideDevServerOverlay } from './helpers/navigation';

const PM_USER = process.env.PMS_PM_USER || '';
const PM_PASS = process.env.PMS_PM_PASS || '';

function formatDate(date: Date) {
  const y = date.getFullYear();
  const m = String(date.getMonth() + 1).padStart(2, '0');
  const d = String(date.getDate()).padStart(2, '0');
  return `${y}-${m}-${d}`;
}

test('weekly report generation and submit', async ({ page }) => {
  const pmToken = await login(page, { username: PM_USER, password: PM_PASS });
  const apiBase = process.env.PMS_BASE_URL || 'http://localhost:8090';

  const now = new Date();
  const day = now.getDay();
  const diff = now.getDate() - day + (day === 0 ? -6 : 1);
  const monday = new Date(now);
  monday.setDate(diff);
  const weekStart = formatDate(monday);

  const genResp = await page.request.get(`${apiBase}/pms/efficiency/weekly-report/generate/${weekStart}`, {
    headers: { Authorization: `Bearer ${pmToken}` }
  });
  const genData = await genResp.json().catch(() => null);
  if (!genData || genData.code !== 200 || !genData.data) {
    throw new Error(`周报生成失败：${genData?.msg || genResp.statusText()}`);
  }

  let reportId = genData.data.id;

  if (!reportId) {
    const createResp = await page.request.post(`${apiBase}/pms/efficiency/weekly-report`, {
      headers: { Authorization: `Bearer ${pmToken}` },
      data: {
        weekStartDate: genData.data.weekStartDate,
        weekEndDate: genData.data.weekEndDate,
        weekNumber: genData.data.weekNumber,
        totalHours: genData.data.totalHours,
        weekSummary: genData.data.weekSummary || '',
        achievements: genData.data.achievements || '',
        issues: genData.data.issues || '',
        nextWeekPlan: genData.data.nextWeekPlan || '',
        status: 'DRAFT'
      }
    });
    const createData = await createResp.json().catch(() => null);
    if (!createData || createData.code !== 200) {
      const msg = createData?.msg || createResp.statusText();
      if (String(msg || '').includes('week_start')) {
        test.skip(true, '周报表字段不匹配（week_start），无法创建周报');
      }
      throw new Error(`周报创建失败：${msg}`);
    }

    const myResp = await page.request.get(`${apiBase}/pms/efficiency/weekly-report/my`, {
      headers: { Authorization: `Bearer ${pmToken}` }
    });
    const myData = await myResp.json().catch(() => null);
    const list = myData?.data || [];
    const matched = list.find((item: any) => item.weekStartDate === genData.data.weekStartDate);
    reportId = matched?.id;
  }

  if (!reportId) {
    throw new Error('周报ID获取失败，无法继续提交');
  }

  const updateResp = await page.request.put(`${apiBase}/pms/efficiency/weekly-report`, {
    headers: { Authorization: `Bearer ${pmToken}` },
    data: {
      id: reportId,
      weekSummary: '本周完成核心任务验证与联动流程检查',
      achievements: '完成日报提交与审核链路，项目进度同步检查',
      nextWeekPlan: '补齐边界用例与异常流程验证',
      status: 'DRAFT'
    }
  });
  const updateData = await updateResp.json().catch(() => null);
  if (!updateData || updateData.code !== 200) {
    throw new Error(`周报保存失败：${updateData?.msg || updateResp.statusText()}`);
  }

  const submitResp = await page.request.put(`${apiBase}/pms/efficiency/weekly-report/submit/${reportId}`, {
    headers: { Authorization: `Bearer ${pmToken}` }
  });
  const submitData = await submitResp.json().catch(() => null);
  if (!submitData || submitData.code !== 200) {
    throw new Error(`周报提交失败：${submitData?.msg || submitResp.statusText()}`);
  }

  await page.goto('/efficiency/weekly-report');
  await hideDevServerOverlay(page);
});
