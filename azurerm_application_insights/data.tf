data "azurerm_client_config" "current" {}
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_application_insights" "appi" {
  depends_on = [azurerm_application_insights.appi]

  name                = var.name
  resource_group_name = var.rg_name
}

