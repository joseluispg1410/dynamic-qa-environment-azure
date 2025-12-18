# Variables for the container-app module
# These are provided by the root module

variable "env_name" {
  description = "QA environment name"
  type        = string
}

variable "location" {
  description = "Azure region for deployment"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group where the app will be deployed"
  type        = string
}