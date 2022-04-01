resource "azurerm_app_service_plan" "sp" {
  depends_on = [data.azurerm_resource_group.rg]

  name                          = var.name
  resource_group_name           = data.azurerm_resource_group.rg.name
  location                      = data.azurerm_resource_group.rg.location
  os_type                       = var.os_type
  sku_name                      = var.sku_name
  worker_count                  = var.worker_count
  app_service_environment_id    = local.app_service_environment_id
  app_service_environment_id_v3 = local.app_service_environment_id_v3
  maximum_elastic_worker_count  = local.maximum_elastic_worker_count
  tags                          = var.tags

  lifecycle {
    ignore_changes        = [tags["updated_date"], location]
    create_before_destroy = true
  }
}
