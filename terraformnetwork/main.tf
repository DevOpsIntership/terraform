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

variable "security_rule" {
  type = map
}
  




variable "subnet"{
    type = map
} 

variable "Vnet" {
  type = string
}

variable "Vm" {
  type = map
}



    
resource "azurerm_virtual_network" "MyVnet" {
  name                = var.Vnet
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.Myrg.location
  resource_group_name = data.azurerm_resource_group.Myrg.name
}





resource "azurerm_network_security_group" "nsg" {
for_each =var.subnet
  name                = each.value.nsg
  location            = data.azurerm_resource_group.Myrg.location
  resource_group_name = data.azurerm_resource_group.Myrg.name
  
}

resource "azurerm_network_security_rule" "myrule" {
for_each = var.security_rule

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = data.azurerm_resource_group.Myrg.name
  network_security_group_name  = each.value.network_security_group_name
   depends_on = [
     azurerm_network_security_group.nsg
   ]
}

resource "azurerm_subnet" "mysubnet" {
for_each = var.subnet
  name                    = each.value.name
  resource_group_name     = data.azurerm_resource_group.Myrg.name
  virtual_network_name    = var.Vnet
  address_prefixes        = each.value.cidr
  
  depends_on = [azurerm_virtual_network.MyVnet]
}

resource "azurerm_subnet_network_security_group_association" "association" {
  for_each                  = var.subnet
  subnet_id                 = azurerm_subnet.mysubnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
  depends_on = [
    azurerm_subnet.mysubnet  ]
}


