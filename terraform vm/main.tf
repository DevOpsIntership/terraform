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

variable "Vmnetworking" {
  type = map
}
variable "Vmlinux" {
  
}
variable "Vmwindows" {
  type = map
}

data "azurerm_subnet" "subnet_id" {
  for_each =  var.Vmnetworking
  name                 = each.value.subnetname
  virtual_network_name = "Vnet"
  resource_group_name  = "automation"
} 

resource "azurerm_public_ip" "my_terraform_public_ip" {
  for_each = var.Vmnetworking
  name                = each.value.Ipname
  location            = data.azurerm_resource_group.Myrg.location
  resource_group_name = data.azurerm_resource_group.Myrg.name
  allocation_method   = each.value.allocation
}

resource "azurerm_network_interface" "nic" {
  for_each = var.Vmnetworking
  name                = each.value.nicname
  location            = data.azurerm_resource_group.Myrg.location
  resource_group_name = data.azurerm_resource_group.Myrg.name

  ip_configuration {
    name                          = "ifconfig"
    subnet_id                     = data.azurerm_subnet.subnet_id[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.my_terraform_public_ip[each.key].id
  }
}


resource "azurerm_virtual_machine" "my_terraform_vm" {
 
  for_each = var.Vmlinux
  name                  = each.value.name
  location              = data.azurerm_resource_group.Myrg.location
  resource_group_name   = data.azurerm_resource_group.Myrg.name
  network_interface_ids = [azurerm_network_interface.nic[each.key].id]
  vm_size               = each.value.Vmsize

  storage_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = "latest"
  }

  storage_os_disk {
    name                 =  each.value.diskname
    caching              = "ReadWrite"
    create_option        = "FromImage"
    managed_disk_type    = each.value.disksku
  }


  os_profile {
  
    computer_name                   = "myvm"
    admin_username                  = "azureuser"
    admin_password                  = "Xzh7VZ75!" 
    
  }
  os_profile_linux_config {
    disable_password_authentication = false
  } 

}


resource "azurerm_virtual_machine" "my_terraform_vmwindows" {
 
  for_each = var.Vmwindows
  name                  = each.value.name
  location              = data.azurerm_resource_group.Myrg.location
  resource_group_name   = data.azurerm_resource_group.Myrg.name
  network_interface_ids = [azurerm_network_interface.nic[each.key].id]
  vm_size               = each.value.Vmsize

  storage_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = "latest"
  }

  storage_os_disk {
    name                 =  each.value.diskname
    caching              = "ReadWrite"
    create_option        = "FromImage"
    managed_disk_type    = each.value.disksku
  }


  os_profile {
  
    computer_name                   = "myvm"
    admin_username                  = "azureuser"
    admin_password                  = "Xzh7VZ75!" 
    
  }
  os_profile_windows_config {
     provision_vm_agent = true
  } 

}

   
