data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

data "azurerm_resource_group" "law_rg" {
  provider = azurerm.secure

  name = var.law_rg_name
}
data "azurerm_log_analytics_workspace" "law" {
  depends_on = [data.azurerm_resource_group.law_rg]
  provider   = azurerm.secure

  name                = var.law_name
  resource_group_name = var.law_rg_name
}

# Use this data source to access information about the Monitor Diagnostics Categories supported by an existing Resource.
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories
data "azurerm_monitor_diagnostic_categories" "mdc" {
  count = length(var.target_resource_ids)

  resource_id = var.target_resource_ids[count.index]
}
