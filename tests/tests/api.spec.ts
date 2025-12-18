import { test, expect, request } from '@playwright/test';

// Simple API health check
test('Health endpoint is OK', async () => {
  const context = await request.newContext({
    baseURL: process.env.BASE_URL
  });

  const response = await context.get('/health');
  expect(response.status()).toBe(200);
});
