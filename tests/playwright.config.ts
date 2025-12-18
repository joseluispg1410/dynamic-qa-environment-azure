import { defineConfig } from '@playwright/test';

export default defineConfig({
  // Base URL will be injected from GitHub Actions via env variable
  use: {
    baseURL: process.env.BASE_URL,
    trace: 'on-first-retry', // Capture trace for flaky tests
    screenshot: 'only-on-failure', // Screenshots only if test fails
  },
  // Reporters for GitHub Actions and human-readable output
  reporter: [
    ['html'], 
    ['junit', { outputFile: 'results.xml' }]
  ],
});
