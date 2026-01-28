import { defineConfig } from '@playwright/test';

export default defineConfig({
  use: {
    baseURL: process.env.PMS_UI_URL || 'http://localhost:1025',
    headless: true
  }
});
