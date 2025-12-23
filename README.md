## 🎥 Demo en vídeo
https://github.com/joseluispg1410/dynamic-qa-environment-azure/releases/download/v1.0/Demo.video.mov

# Dynamic QA Environment on Azure
This repository demonstrates a reproducible, ephemeral QA environment on Azure using Terraform, GitHub Actions and Playwright tests running in Docker. It is designed to provision a temporary test environment, run UI/API tests, and tear down all resources automatically.
---

## Non-Technical Summary (for non IT)

This project provides a simple, repeatable way for any company to create temporary Quality Assurance (QA) environments in the cloud. It automatically provisions an isolated test environment, deploys a sample application, runs automated user-interface and API tests, and then destroys everything so there are no ongoing costs. For non-technical stakeholders: this means engineering can validate features in a safe, consistent environment without affecting production, save cloud costs by using short-lived resources, and produce concrete test reports that HR or managers can review. The workflow integrates with standard CI tools (GitHub Actions) so tests run automatically on demand or on pull requests. No deep technical knowledge is required to understand the outcome — you get pass/fail test reports and an HTML report that shows what was checked.

## 🚀 Goals
- Provision QA environments on demand with **Terraform**
- Deploy a **sample application** dynamically for testing
- Execute **Playwright** UI and API tests in a container
- Automatically destroy resources after tests to save cost
- Provide a cross-platform, CI-friendly workflow
---
## 🧱 Tech Stack
- **Cloud:** Azure
- **IaC:** Terraform (module: container-app)
- **CI/CD:** GitHub Actions (/.github/workflows/dynamic-qa.yml)
- **QA Automation:** Playwright (tests in `tests/tests`)
- **Containerization:** Docker
---
## 🏗️ Project Structure
dynamic-qa-environment-azure/
- terraform/                 # Infrastructure (main.tf, providers, modules)
- tests/                     # Playwright tests and Dockerfile
    - Dockerfile
    - package.json
    - playwright.config.ts
    - tests/
    - ui.spec.ts
    - check_subtext.test.ts
- .github/workflows/
    - dynamic-qa.yml           # CI workflow that runs terraform + tests + destroy
- README.md
---
## ⚡ How it Works
1. GitHub Actions triggers the workflow (manual or PR).
2. Terraform provisions a temporary Azure environment and deploys the sample app.
3. Playwright tests run inside a Docker container against the deployed app.
4. Terraform destroys all resources (always runs, even on test failure).
Benefits: reproducible ephemeral environments, cost control, consistent CI results.
## Recommended test method (GitHub Actions)

The repository workflow is named **Dynamic QA Environment**. Important: external contributors (users without repository collaborator permissions) cannot use the **Run workflow** button to start a manual run. Instead, to test this project from an external fork or by external reviewers, follow one of these approaches:

- Create a Pull Request against the repository's default branch (e.g., `main`). The workflow is configured to run on pull request events and will start automatically.
- Repository collaborators with permission can still run the workflow manually from the **Actions** tab by selecting **Dynamic QA Environment** and clicking **Run workflow**.

To view results:

- Open the repository on GitHub and go to the **Actions** tab.
- Select the **Dynamic QA Environment** and then **qa** workflow and open the latest run to see logs, job steps and any published artifacts (HTML report, JUnit results).

If you prefer to run tests locally instead of using GitHub Actions, follow the **Prerequisites** and local steps below.

## Prerequisites
Before running the demo locally you should have the following installed (CI runners already provide most tools):
### Manual prerequisites (one-time per machine)
- Docker Desktop — required to run Playwright tests in a container: https://www.docker.com/products/docker-desktop/
- Azure CLI — required to authenticate and inspect resources locally: https://learn.microsoft.com/cli/azure/install-azure-cli
Login locally before provisioning:
```bash
az login
```
These steps are required once per machine.
### Terraform (optional locally)
Terraform is used by the CI workflow. Installing locally is optional but useful for development:
#### Windows
1. Download from https://developer.hashicorp.com/terraform/downloads
2. Add the binary to your `PATH`
```bash
terraform -version
```
#### macOS
```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
terraform -version
```
#### Linux (Debian/Ubuntu)
```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update && sudo apt-get install terraform
terraform -version
```
### Azure authentication for CI (GitHub Actions)
Create an Azure Service Principal (one-time) locally or in Cloud Shell:
```bash
az ad sp create-for-rbac --name "github-actions-terraform" --role Contributor --scopes /subscriptions/<SUBSCRIPTION_ID> --sdk-auth
```
Save the JSON output and add the following repository secrets in GitHub under Settings → Secrets and variables → Actions:
- `AZURE_CLIENT_ID`
- `AZURE_CLIENT_SECRET`
- `AZURE_SUBSCRIPTION_ID`
- `AZURE_TENANT_ID`
The GitHub Actions workflow maps these to `ARM_*` environment variables so Terraform can authenticate.
#### Provider registration (new subscriptions)
If you get an error like `MissingSubscriptionRegistration: The subscription is not registered to use namespace 'Microsoft.App'`, register the provider once:
```bash
az provider register --namespace Microsoft.App
az provider show --namespace Microsoft.App --query registrationState
```
---
### Automated prerequisites (handled inside Docker)
- Node.js and Playwright are included in the test Docker image; dependencies are installed at build time.
---
## 🛠️ Running locally
1. Build and run the Playwright test container (set `BASE_URL` to the app URL):
```bash
docker build -t playwright-tests ./tests
docker run -e BASE_URL=https://your-app-url playwright-tests
```
2. (Optional) Initialize and run Terraform locally for testing:
```bash
cd terraform
terraform init
terraform apply -auto-approve
# run tests against the deployed app
terraform destroy -auto-approve
```
## 📈 CI/CD
The workflow `.github/workflows/dynamic-qa.yml` provisions infrastructure, runs tests, publishes reports (HTML + JUnit), and destroys resources. Secrets from the Azure Service Principal are injected as repository secrets.
## 🏗️ Architecture (summary)
GitHub Actions → Terraform Apply (Azure) → Run Playwright tests (Docker) → Terraform Destroy
---
