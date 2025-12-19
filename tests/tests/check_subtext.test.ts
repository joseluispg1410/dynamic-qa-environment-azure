import { test, expect } from '@playwright/test';

test('Homepage contain subtext', async ({ page }) => {
  const elemento = page.locator('#subText');
  await expect(elemento).toContainText('To Learn more, follow our docs');
});