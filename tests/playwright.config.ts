import { defineConfig } from '@playwright/test';

export default defineConfig({
  use: {
    baseURL: process.env.BASE_URL,
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
  },
  reporter: [
    ['html'],
    ['junit', { outputFile: 'results.xml' }],
    ['allure-playwright'],
  ],
});