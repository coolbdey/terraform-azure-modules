data "azuread_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

data "azurerm_service_plan" "sp" {
  name                = var.sp_name
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
