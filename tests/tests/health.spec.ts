import { test, expect } from '@playwright/test';

test('Docker container is working', async ({ page }) => {
  await page.goto('https://example.com');
  await expect(page).toHaveTitle(/Example/);
});