variable "Storage" {
  type = string
}
variable "account_tier" {
  type = string
}

variable "account_replication_type" {
  type = string
}

variable "container_name" {
  type = string
}

resource "azurerm_storage_account" "Storage" {
  name                     = var.Storage
  resource_group_name      = data.azurerm_resource_group.Myrg.name
  location                 = data.azurerm_resource_group.Myrg.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type


}

resource "azurerm_storage_container" "container" {
  name                  = var.container_name
  storage_account_name  = resource.azurerm_storage_account.Storage.name
  container_access_type = "private"
}