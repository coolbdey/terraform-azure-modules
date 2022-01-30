data "azuread_client_config" "current" {}
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_cosmosdb_account" "cdba" {
  depends_on = [data.azurerm_resource_group.rg]

  name                = var.cdba_name
  resource_group_name = var.rg_name
}