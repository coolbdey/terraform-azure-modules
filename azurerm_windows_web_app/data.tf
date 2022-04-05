data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

data "azurerm_service_plan" "sp" {
  name                = var.sp_name
  resource_group_name = var.rg_name
}

data "azurerm_windows_web_app" "wa" {
  name                = var.name
  resource_group_name = var.rg_name

  depends_on = [azurerm_windows_web_app.fa]
}
