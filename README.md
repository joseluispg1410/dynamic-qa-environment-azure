# Dynamic QA Environment on Azure

This project demonstrates how to design and implement a **dynamic QA environment** in Azure using Infrastructure as Code, CI/CD pipelines, and automated testing.  
It is fully **containerized**, **cross-platform**, and reusable for any Azure project.

---

## 🚀 Goals

- Provision QA environments on demand with **Terraform**
- Deploy a **sample application** dynamically
- Execute **automated UI and API tests** with **Playwright**
- Destroy all resources automatically (**cleanup**) after tests
- Ensure **cross-platform compatibility** (Mac / Windows / Linux)
- Showcase **DevOps + QA automation skills**

---

## 🧱 Tech Stack

- **Cloud:** Azure  
- **IaC:** Terraform (with modules)  
- **CI/CD:** GitHub Actions  
- **QA Automation:** Playwright (UI + API tests)  
- **Containerization:** Docker  
- **Secrets management:** Azure Key Vault (optional)

---

## 🏗️ Project Structure

dynamic-qa-environment-azure/
├── terraform/ # Infrastructure as Code
│ ├── main.tf
│ ├── variables.tf
│ ├── outputs.tf
│ └── modules/
│   └── container-app/ # Container App module
│     ├── main.tf
│     ├── variables.tf
│     ├── outputs.tf
├── tests/ # Playwright tests and Dockerfile
│ ├── Dockerfile
│ ├── package.json
│ ├── playwright.config.ts
│ └── tests/
│   ├── ui.spec.ts
│   └── api.spec.ts
├── .github/workflows/ # GitHub Actions CI/CD
│ └── dynamic-qa.yml
└── README.md


---

## ⚡ How it Works

1. **GitHub Actions pipeline** is triggered manually or on pull request.  
2. **Terraform** provisions a new Azure Resource Group and Container App environment.  
3. **Sample app** is deployed in the newly created environment.  
4. **Playwright tests** run inside a Docker container against the deployed app.  
5. **Terraform destroy** cleans up all resources automatically, even if tests fail.  

This ensures:
- **Dynamic QA environments**  
- **Automated testing**  
- **Cost-efficient ephemeral infrastructure**  
- **Full reproducibility across operating systems**

---

## 🛠️ Running Locally

### Requirements
- Docker
- Terraform
- Azure CLI (optional, for testing locally)

### Steps
1. Build and run the Playwright test container:
#```bash
docker build -t playwright-tests ./tests
docker run -e BASE_URL=https://your-app-url playwright-tests

2. Initialize Terraform (optional local testing):
cd terraform
terraform init
terraform apply -auto-approve
# Run tests
terraform destroy -auto-approve


## 📈 CI/CD
The workflow dynamic-qa.yml provisions infrastructure, runs tests, and destroys resources automatically.
Reports are generated in HTML and JUnit format.
Fully containerized, ensuring consistent results across Mac, Windows, and Linux.


## 🏗️ Architecture Diagram
This diagram shows the **end-to-end flow** of the dynamic QA environment:

   GitHub Actions Pipeline
   ┌───────────────────────┐
   │   workflow_dispatch   │
   │      or PR trigger    │
   └─────────┬─────────────┘
             │
             ▼
   ┌────────────────────────┐
   │  Terraform Apply       │
   │  - Resource Group      │
   │  - Container App Env   │
   │  - Sample App          │
   └─────────┬──────────────┘
             │
             ▼
   ┌────────────────────────┐
   │  Docker Run Playwright │
   │  - UI Tests            │
   │  - API Tests           │
   │  - HTML + JUnit report │
   └─────────┬──────────────┘
             │
             ▼
   ┌────────────────────────┐
   │  Terraform Destroy     │
   │  - Cleanup Resources   │
   │  - Cost-efficient      │
   └────────────────────────┘

### Flow Summary:
1. **Trigger pipeline** (manual or PR)  
2. **Provision infrastructure** with Terraform  
3. **Deploy sample app** dynamically  
4. **Run Playwright tests** in container  
5. **Destroy infrastructure** automatically  