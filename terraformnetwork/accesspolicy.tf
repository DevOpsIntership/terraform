terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
}
provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}
data "azurerm_key_vault" "key" {
  name                = "adkwolekkye"
  resource_group_name = "automation"
}

data "azurerm_linux_web_app" "app" {
  name                = "adkwolek"
  resource_group_name = "automation"
}

resource "azurerm_key_vault_access_policy" "myapp" {
  key_vault_id = data.azurerm_key_vault.key.id
  tenant_id    = data.azurerm_client_config.current.tenant_id

  object_id = data.azurerm_linux_web_app.app.identity.0.principal_id

  secret_permissions = [
    "Get", "List"
  ]
}