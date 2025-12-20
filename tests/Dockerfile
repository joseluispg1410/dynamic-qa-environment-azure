# Base image with Playwright installed (browsers included)
FROM mcr.microsoft.com/playwright:v1.57.0-jammy

# Set working directory inside the container
WORKDIR /tests

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm ci

# Copy all test files
COPY . .

# Default command: run all Playwright tests
CMD ["npx", "playwright", "test"]
