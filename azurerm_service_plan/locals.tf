locals {
  location                     = data.azurerm_resource_group.rg.location
  is_elastic                   = can(regex("EP1|EP2|EP3", var.sku_name)) # Used for Function Apps
  is_consumtion_plan           = can(regex("Y1", var.sku_name))          # Used for Function Apps
  maximum_elastic_worker_count = local.is_elastic ? var.maximum_elastic_worker_count : null
  #worker_count =   
  is_isolated                = can(regex("I1|I2|I3|I1v2|I2v2|I3v3", var.sku_name))
  is_zone_redundant          = can(regex("^P[1-3]|^EP[1-3]", var.sku_name)) && !can(regex("norway|sweden", local.location))
  app_service_environment_id = local.is_isolated && can(regex("I[1-3]", var.app_service_environment_id)) ? var.app_service_environment_id : null
  zone_balancing_enabled     = local.is_zone_redundant ? var.zone_balancing_enabled : false
}