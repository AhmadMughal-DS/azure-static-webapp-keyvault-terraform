output "static_web_app_url" {
  description = "Default hostname of the Static Web App"
  value       = "https://${azurerm_static_web_app.this.default_host_name}"
}

output "static_web_app_api_key" {
  description = "Deployment token for the Static Web App"
  value       = azurerm_static_web_app.this.api_key
  sensitive   = true
}

output "key_vault_uri" {
  description = "Key Vault URI"
  value       = azurerm_key_vault.this.vault_uri
}
