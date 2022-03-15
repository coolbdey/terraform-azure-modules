data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_storage_account" "sa" {
  depends_on = [data.azurerm_resource_group.rg]
  count      = var.sa_name == null ? 0 : 1

  name                = var.sa_name
  resource_group_name = var.rg_name
}

data "azurerm_log_analytics_workspace" "law" {
  depends_on = [azurerm_log_analytics_workspace.law]

  name                = azurerm_log_analytics_workspace.law.name
  resource_group_name = var.rg_name
}
