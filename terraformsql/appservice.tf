
variable "AppServiePlanName" {
type = string
}

variable "tier" {
  type = string
}

variable "AppServiceName" {
  type = string
}

variable "worker" {
  type = number
}
variable "dockerimage" { 
 type = string 
}


resource "azurerm_service_plan" "AppServiePlan" {
  name = var.AppServiePlanName
  resource_group_name                   = data.azurerm_resource_group.Myrg.name
  location                              = data.azurerm_resource_group.Myrg.location
  os_type                               = "Linux"
  sku_name                              = var.tier
  worker_count                          = var.worker



}

resource "azurerm_linux_web_app"  "AppService" {
  name                = var.AppServiceName
  location            = data.azurerm_resource_group.Myrg.location
  resource_group_name = data.azurerm_resource_group.Myrg.name
  service_plan_id     = resource.azurerm_service_plan.AppServiePlan.id

    site_config {
    always_on        = "true"

    application_stack {
      docker_image     = var.dockerimage
      docker_image_tag = "latest"
    }


}
}


   
