data "azuread_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
