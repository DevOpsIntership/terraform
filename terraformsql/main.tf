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
variable "SqlServerName" {
  type = string
}

variable "SqlDbName" {
  type = string
}
variable "sku" {
  type = string
} 

variable "FirewallRules" {
  type = list(object({
    name = string
    start_ip_address = string
    end_ip_address = string
  }))
}

variable "monthly_retention" {
  type = string
}
variable "weekly_retention" {
      type = string
}
variable "yearly_retention" {
  type = string
}

variable "week_of_year" {
  type = number 
}

variable "retention_days" {
  type = number
}


data "azurerm_resource_group" "Myrg" {
  name = var.rg
}

resource "azurerm_mssql_server" "mySqlServer" {
  name                         = var.SqlServerName
  resource_group_name          = data.azurerm_resource_group.Myrg.name
  location                     = data.azurerm_resource_group.Myrg.location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
}


resource "azurerm_mssql_database" "SqlDatabase" {
  name                = var.SqlDbName
  server_id           = resource.azurerm_mssql_server.mySqlServer.id
  sku_name            = var.sku 

  long_term_retention_policy {
    monthly_retention = var.monthly_retention
    week_of_year = var.week_of_year
    weekly_retention = var.weekly_retention
    yearly_retention = var.yearly_retention
  }

  short_term_retention_policy {
    retention_days = var.retention_days
  }
}
 

 resource "azurerm_mssql_firewall_rule" "rule" {

    server_id = resource.azurerm_mssql_server.mySqlServer.id
    for_each = { for index, rule in var.FirewallRules: rule.name=> rule
    }
  
        name =each.value.name
        start_ip_address = each.value.start_ip_address
        end_ip_address = each.value.end_ip_address

 }