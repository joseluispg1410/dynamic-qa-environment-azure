import { test, expect } from '@playwright/test';

// Simple smoke test for homepage
test('Homepage loads', async ({ page }) => {
  await page.goto('/'); // baseURL injected via env in CI
  console.log('URL actual:', page.url());
  const elemento = page.locator('#titleText');
  await expect(elemento).toHaveText('Your Azure Container Apps app is live');
});

// Simple smoke test for homepage
test('Homepage loads with code 200', async ({ page }) => {
  const response = await page.goto('/'); // uses baseURL from config
  // check the status of the response
  expect(response?.status()).toBe(200);
});
