data "azuread_client_config" "current" {}
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_cdn_profile" "cdnp" {
  name                = var.cdnp_name
  resource_group_name = var.rg_name
}
