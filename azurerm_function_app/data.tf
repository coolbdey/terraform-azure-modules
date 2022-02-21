data "azuread_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

data "azurerm_app_service_plan" "asp" {
  name                = var.asp_name
  resource_group_name = var.rg_name
}

data "azurerm_storage_account" "sa" {
  name                = var.sa_name
  resource_group_name = var.rg_name
}

data "azurerm_function_app" "fa" {
  name                = var.name
  resource_group_name = var.rg_name

  depends_on = [azurerm_function_app.fa]
}
