data "azuread_client_config" "current" {}
data "azurerm_client_config" "current" {}
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_key_vault" "kv" {
  name                = var.name
  resource_group_name = var.rg_name

  depends_on = [azurerm_key_vault.kv]
}
