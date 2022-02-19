resource "azurerm_network_watcher_flow_log" "nwfl" {
  depends_on = [data.azurerm_resource_group.rg]

  name                      = var.name
  resource_group_name       = data.azurerm_resource_group.rg.name
  network_watcher_name      = var.nw_name
  network_security_group_id = var.nsg_id
  storage_account_id        = var.sa_id
  enabled                   = var.enabled
  version                   = var.version
  tags                      = var.tags

  retention_policy {
    enabled = var.retention_policy.enabled
    days    = var.retention_policy.days
  }

  traffic_analytics {
    enabled               = var.traffic_analytics.enabled
    workspace_id          = var.traffic_analytics.workspace_id
    workspace_region      = var.traffic_analytics.workspace_region
    workspace_resource_id = var.traffic_analytics.workspace_resource_id
    interval_in_minutes   = var.traffic_analytics.interval_in_minutes
  }
}