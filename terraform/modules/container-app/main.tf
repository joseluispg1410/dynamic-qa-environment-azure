# Container App module configuration
# Creates a container app environment and deploys a sample app

# Container App Environment
resource "azurerm_container_app_environment" "env" {
  name                = "cae-${var.env_name}" # Unique name for the environment
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Sample Container App
resource "azurerm_container_app" "app" {
  name                         = "app-${var.env_name}" # Unique app name
  resource_group_name          = var.resource_group_name
  container_app_environment_id = azurerm_container_app_environment.env.id
  revision_mode                = "Single"

  template {
    container {
      name   = "sample-app"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"

      resources {
        cpu    = 0.25
        memory = "0.5Gi"
      }
    }
  }

  # Configure ingress to make the app publicly accessible
  ingress {
    external_enabled = true
    target_port      = 80
    transport        = "auto"
  }
}