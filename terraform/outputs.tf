# Outputs from the root module
# Outputs will be used in CI/CD pipelines to access deployed app

# Public URL of the deployed container app
output "app_url" {
  description = "Public URL of the sample app"
  value       = module.app.app_url
}