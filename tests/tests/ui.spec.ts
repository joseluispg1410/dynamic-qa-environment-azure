import { test, expect } from '@playwright/test';

// Simple smoke test for homepage
test('Homepage loads', async ({ page }) => {
  await page.goto('/'); // baseURL injected via env
  await expect(page).toHaveTitle(/Sample App/);
});
