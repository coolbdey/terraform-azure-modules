# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan
resource "azurerm_service_plan" "sp" {
  depends_on = [data.azurerm_resource_group.rg]

  name                         = var.name
  resource_group_name          = data.azurerm_resource_group.rg.name
  location                     = data.azurerm_resource_group.rg.location
  os_type                      = var.os_type
  sku_name                     = var.sku_name
  worker_count                 = var.worker_count
  per_site_scaling_enabled     = var.per_site_scaling_enabled
  app_service_environment_id   = local.app_service_environment_id
  maximum_elastic_worker_count = local.maximum_elastic_worker_count
  #reserved                     = local.reserved #  Can't configure a value for "reserved": its value will be decided automatically based on the result of applying this configuration.
  zone_balancing_enabled       = var.zone_balancing_enabled
  tags                         = var.tags

  lifecycle {
    ignore_changes        = [tags, location]
    create_before_destroy = true
  }
}
