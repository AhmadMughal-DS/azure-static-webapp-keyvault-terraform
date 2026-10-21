data "azurerm_client_config" "current" {}

resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "this" {
  name     = "${var.name_prefix}-rg"
  location = var.location
}

resource "azurerm_static_web_app" "this" {
  name                = "${var.name_prefix}-site"
  resource_group_name = azurerm_resource_group.this.name
  location            = var.swa_location
  sku_tier            = "Free"
  sku_size            = "Free"
}

resource "azurerm_key_vault" "this" {
  name                       = "${replace(var.name_prefix, "-", "")}kv${random_string.suffix.result}"
  resource_group_name        = azurerm_resource_group.this.name
  location                   = var.location
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  enable_rbac_authorization  = true
  purge_protection_enabled   = var.environment == "prod"
  soft_delete_retention_days = 7
}

resource "azurerm_role_assignment" "kv_officer" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "random_password" "api_key" {
  length  = 24
  special = true
}

resource "azurerm_key_vault_secret" "api_key" {
  name         = "app-api-key"
  value        = random_password.api_key.result
  key_vault_id = azurerm_key_vault.this.id
  depends_on   = [azurerm_role_assignment.kv_officer]
}
