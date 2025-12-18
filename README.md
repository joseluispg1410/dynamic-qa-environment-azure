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

## Prerequisites

Before running this demo, make sure you have the following installed:

### **Manual (one-time setup per machine)**

- **Docker Desktop**  
  - Needed to run Playwright tests in a container.  
  - Download: [https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/)

- **Azure CLI**  
  - Required for Terraform to provision and destroy Azure resources.  
  - Install guide: [https://learn.microsoft.com/en-us/cli/azure/install-azure-cli](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)  
  - Login before using Terraform:

  ```bash
  az login
  These steps are required only once per machine.

- **Terraform**
  - Terraform is required to provision and destroy Azure infrastructure.
   #### Windows
    1. Download Terraform from the official website:  
    https://developer.hashicorp.com/terraform/downloads
    2. Extract the binary and add it to your `PATH`.
    3. Verify installation:
    #```bash
    terraform -version
  
  #### MacOs
    brew tap hashicorp/tap
    brew install hashicorp/tap/terraform
    terraform -version

  #### Linux
    sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
    wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt-get update && sudo apt-get install terraform
    terraform -version

> In CI/CD pipelines, Terraform is executed directly by GitHub Actions runners, so no local installation is required when using the pipeline.


### Automated (handled inside Docker)

- **Node.js and Playwright**  
  Already included in the Docker image, no local installation needed.

- **Test dependencies**  
  All npm packages are installed automatically when building the Docker image.

---

## 🛠️ Running Locally
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