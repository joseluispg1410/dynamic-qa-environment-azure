import { test, expect } from '@playwright/test';

// Simple smoke test for homepage
test('Homepage loads', async ({ page }) => {
  const elemento = page.locator('#titleText');
  await expect(elemento).toHaveText('Your Azure Container Apps app is live');
});
