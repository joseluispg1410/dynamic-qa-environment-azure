import { test, expect } from '@playwright/test';

// Simple smoke test for homepage
test('Homepage loads', async ({ page }) => {
  console.log('URL actual:', page.url());
  const elemento = page.locator('#titleText');
  await expect(elemento).toHaveText('Your Azure Container Apps app is live');
});
