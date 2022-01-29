data "azurerm_client_config" "current" {}
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_private_dns_zone" "dns" {
  depends_on = [azurerm_private_dns_zone.dns]

  name                = var.dns_name
  resource_group_name = var.rg_name
}
