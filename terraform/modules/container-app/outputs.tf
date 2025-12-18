# Outputs for the container-app module
# This will be consumed by the root module or CI/CD pipeline

# Public URL of the deployed container app
output "app_url" {
  description = "FQDN of the deployed container app"
  value       = azurerm_container_app.app.latest_revision_fqdn
}