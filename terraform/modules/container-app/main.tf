# Container App Environment
resource "azurerm_container_app_environment" "env" {
  name                = "cae-${var.env_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Sample Container App
resource "azurerm_container_app" "app" {
  name                         = "app-${var.env_name}"
  resource_group_name          = var.resource_group_name
  container_app_environment_id = azurerm_container_app_environment.env.id
  revision_mode                = "Single"

  template {
    container {
      name   = "sample-app"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"

      cpu    = 0.25
      memory = "0.5Gi"
    }
  }

  ingress {
    external_enabled = true
    target_port      = 80
    transport        = "auto"

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
}
