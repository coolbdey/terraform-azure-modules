data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

data "azurerm_app_service_plan" "asp" {
  name                = var.asp_name
  resource_group_name = var.rg_name
}

data "azurerm_app_service" "wa" {
  depends_on = [azurerm_app_service.wa]

  name                = var.name
  resource_group_name = var.rg_name
}
