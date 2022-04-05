data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

data "azurerm_service_plan" "sp" {
  name                = var.sp_name
  resource_group_name = var.rg_name
}

data "azurerm_windows_web_app" "wwa" {
  depends_on = [azurerm_windows_web_app.wwa]

  name                = var.name
  resource_group_name = var.rg_name
}
