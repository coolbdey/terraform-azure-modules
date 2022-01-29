data "azuread_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

data "azurerm_app_service_plan" "asp" {
  name                = var.name
  resource_group_name = var.rg_name

  depends_on = [azurerm_app_service_plan.asp]
}