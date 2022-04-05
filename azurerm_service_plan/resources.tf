# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/service_plan
resource "azurerm_service_plan" "sp" {
  depends_on = [data.azurerm_resource_group.rg]

  name                         = var.name
  resource_group_name          = data.azurerm_resource_group.rg.name
  location                     = data.azurerm_resource_group.rg.location
  os_type                      = var.os_type
  sku_name                     = var.sku_name
  kind                         = var.kind # TODO: 
  worker_count                 = var.worker_count
  per_site_scaling_enabled     = var.per_site_scaling_enabled
  reserved                     = local.reserved
  app_service_environment_id   = local.app_service_environment_id
  maximum_elastic_worker_count = local.maximum_elastic_worker_count
  tags                         = var.tags

  lifecycle {
    ignore_changes        = [tags, location]
    create_before_destroy = true
  }
}
