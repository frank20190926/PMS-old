import { defineConfig } from '@playwright/test';

export default defineConfig({
  testDir: './tests',
  fullyParallel: false,
  workers: 1,
  retries: 0,
  timeout: 120_000,
  use: {
    baseURL: process.env.PMS_UI_URL || 'http://localhost:1024',
    headless: true,
    viewport: { width: 1366, height: 900 }
  }
});
