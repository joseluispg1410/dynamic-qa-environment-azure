import { test, expect } from '@playwright/test';

test('Homepage contain subtext', async ({ page }) => {
  console.log('URL actual:', page.url());
  const elemento = page.locator('#subText');
  await expect(elemento).toContainText('To Learn more, follow our docs');
});