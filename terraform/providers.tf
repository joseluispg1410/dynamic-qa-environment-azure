# Terraform configuration for Azure provider
# Specifies Terraform version and required providers
# Sets up the Azure Resource Manager provider (azurerm)
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }
}

# Azure provider configuration
provider "azurerm" {
  features {}
}