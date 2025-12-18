# Root Terraform configuration
# Creates the Azure Resource Group and calls the container app module

# Create a resource group for the QA environment
resource "azurerm_resource_group" "qa" {
  name     = "rg-${var.env_name}"
  location = var.location
}

# Call container app module
module "app" {
  source              = "./modules/container-app"
  env_name            = var.env_name
  location            = var.location
  resource_group_name = azurerm_resource_group.qa.name
}