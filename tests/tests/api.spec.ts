import { test, expect } from '@playwright/test';

test('Desde la home puedo ir a /health', async ({ page }) => {
  const response = await page.goto('/health');

  expect(response).not.toBeNull();
  expect(response!.status()).toBe(200);
});