data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_api_management" "apim" {
  depends_on = [data.azurerm_resource_group.rg]

  name                = var.apim_name
  resource_group_name = var.rg_name
}
data "azurerm_key_vault" "kv" {
  depends_on = [data.azurerm_resource_group.rg]

  name                = var.kv_name
  resource_group_name = var.rg_name
}
