import { test, expect } from '@playwright/test';
import fs from 'fs';
import path from 'path';
import { login } from './helpers/auth';
import { hideDevServerOverlay } from './helpers/navigation';

const PM_USER = process.env.PMS_PM_USER || '';
const PM_PASS = process.env.PMS_PM_PASS || '';

test('upload document attachment and verify list', async ({ page }, testInfo) => {
  await login(page, { username: PM_USER, password: PM_PASS });

  const token = await login(page, { username: PM_USER, password: PM_PASS });
  const apiBase = process.env.PMS_BASE_URL || 'http://localhost:8090';
  const myProjectsResp = await page.request.get(`${apiBase}/pms/efficiency/project/common/my-projects`, {
    headers: { Authorization: `Bearer ${token}` }
  });
  const myProjectsData = await myProjectsResp.json().catch(() => null);
  const projects = myProjectsData?.data || [];
  test.skip(!projects.length, '项目列表为空，无法执行附件上传流程');
  const projectId = projects[0].projectId;

  const fileName = `e2e-attachment-${Date.now()}.pdf`;
  const filePath = testInfo.outputPath(fileName);
  fs.writeFileSync(filePath, '%PDF-1.4\n%测试附件\n1 0 obj\n<<>>\nendobj\n');

  const uploadResp = await page.request.post(`${apiBase}/pms/efficiency/project/document/upload`, {
    headers: { Authorization: `Bearer ${token}` },
    multipart: {
      projectId: String(projectId),
      phaseId: '',
      docType: 'OTHER',
      file: {
        name: fileName,
        mimeType: 'application/pdf',
        buffer: fs.readFileSync(filePath)
      }
    }
  });
  const uploadData = await uploadResp.json().catch(() => null);
  if (!uploadData || uploadData.code !== 200) {
    throw new Error(`附件上传失败：${uploadData?.msg || uploadResp.statusText()}`);
  }

  await page.goto(`/efficiency/project/document?projectId=${projectId}`);
  await hideDevServerOverlay(page);
  await expect(page.getByText('项目文档管理')).toBeVisible({ timeout: 10_000 });
  await expect(page.getByText(fileName).first()).toBeVisible({ timeout: 15_000 });

  if (fs.existsSync(filePath)) {
    fs.unlinkSync(filePath);
  }
});
