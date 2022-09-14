terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "rg" {
  type = string
}

data "azurerm_resource_group" "Myrg" {
  name = var.rg
}

resource "azurerm_container_registry" "acr" {
  name                = "adkwolekcontainer"
  resource_group_name = data.azurerm_resource_group.Myrg.name
  location            = data.azurerm_resource_group.Myrg.location
  sku                 = "Standard"
}