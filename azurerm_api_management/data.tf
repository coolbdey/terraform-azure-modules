data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_api_management" "apim" {
  depends_on          = [azurerm_api_management.apim]
  name                = var.name
  resource_group_name = var.rg_name
}
data "azurerm_resource_group" "appi_rg" {
  name = var.appi_rg_name
}
data "azurerm_application_insights" "appi" {
  depends_on = [data.azurerm_resource_group.appi_rg]

  name                = var.appi_name
  resource_group_name = var.rg_name
}

data "azurerm_api_management_api" "api" {
  depends_on = [data.azurerm_api_management.apim]
  count      = var.import_policy_all ? length(var.apis) : 0

  name                = var.apis[count.index].name
  api_management_name = var.name
  resource_group_name = var.rg_name
  revision            = var.apis[count.index].revision
}

