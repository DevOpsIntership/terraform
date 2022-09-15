provider "azurerm" {
  features {}
}

variable "rgn" {
  type = string
  default = "automation"
}
data "azurerm_resource_group" "rg" {
  name = var.rgn
}
data "azurerm_linux_web_app" "idweb" {
  resource_group_name = "automation"
  name = "adkwolek"
}
resource "azurerm_virtual_network" "vnet" {
  name                = "MyVnet"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = "automation"
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = "automation"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  enforce_private_link_service_network_policies = true
}

resource "azurerm_private_endpoint" "endpoint" {
  name                = "example-endpoint"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.subnet.id

   private_service_connection {
    name = "coneciotn"
    private_connection_resource_id = data.azurerm_linux_web_app.idweb.id
    subresource_names = ["sites"]
    is_manual_connection = false
  }

}