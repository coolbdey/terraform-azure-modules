data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

data "azurerm_resource_group" "ddospp_rg" {
  count = var.ddospp_rg_name != null ? 1 : 0
  name = var.ddospp_rg_name
}

data "azurerm_network_ddos_protection_plan" "ddospp" {
  depends_on = [data.azurerm_resource_group.ddospp_rg]
  count = var.ddospp_name != null ? 1 : 0

  name                = var.ddospp_name
  resource_group_name = var.ddospp_rg_name
}

