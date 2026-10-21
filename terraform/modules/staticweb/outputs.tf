output "static_web_app_url" {
  value = "https://${azurerm_static_web_app.this.default_host_name}"
}
output "static_web_app_api_key" {
  value     = azurerm_static_web_app.this.api_key
  sensitive = true
}
output "key_vault_uri" {
  value = azurerm_key_vault.this.vault_uri
}
