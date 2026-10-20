data "azurerm_client_config" "current" {}

locals {
  name = var.project_name
  tags = {
    Project   = var.project_name
    ManagedBy = "Terraform"
    Owner     = "Muhammad Ahmad"
  }
}

resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "this" {
  name     = "${local.name}-rg"
  location = var.location
  tags     = local.tags
}

############################
# Static Web App
############################
resource "azurerm_static_web_app" "this" {
  name                = "${local.name}-site"
  resource_group_name = azurerm_resource_group.this.name
  location            = var.swa_location
  sku_tier            = "Free"
  sku_size            = "Free"
  tags                = local.tags
}

############################
# Key Vault + secret
############################
resource "azurerm_key_vault" "this" {
  name                      = "${replace(var.project_name, "-", "")}kv${random_string.suffix.result}"
  resource_group_name       = azurerm_resource_group.this.name
  location                  = var.location
  tenant_id                 = data.azurerm_client_config.current.tenant_id
  sku_name                  = "standard"
  enable_rbac_authorization = true
  purge_protection_enabled  = false
  tags                      = local.tags
}

resource "random_password" "api_key" {
  length  = 24
  special = true
}

resource "azurerm_key_vault_secret" "api_key" {
  name         = "app-api-key"
  value        = random_password.api_key.result
  key_vault_id = azurerm_key_vault.this.id
}
