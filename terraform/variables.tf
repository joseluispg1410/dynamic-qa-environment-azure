# Global variables used in the project

# Name of the QA environment (e.g., qa-run-123)
variable "env_name" {
  description = "Environment name (e.g. qa-run-123)"
  type        = string
}

# Azure region to deploy resources
variable "location" {
  description = "Azure region"
  type        = string
  default     = "westeurope"
}