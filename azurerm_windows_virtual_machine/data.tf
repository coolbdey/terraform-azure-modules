data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_key_vault" "kv" {
  depends_on = [data.azurerm_resource_group.rg]

  name                = var.kv_name
  resource_group_name = var.rg_name
}
data "azurerm_network_interface" "nic" {
  name                = var.nic_name
  resource_group_name = var.rg_name
}
data "azurerm_key_vault_certificate" "kv_cert" {
  depends_on = [data.azurerm_key_vault.kv]

  name         = var.cert_name
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_virtual_machine_scale_set" "vmss" {
  depends_on = [data.azurerm_resource_group.rg]
  count      = var.vmss_name == null ? 0 : 1

  name                = var.vmss_name
  resource_group_name = var.rg_name
}

data "azurerm_proximity_placement_group" "ppg" {
  depends_on = [data.azurerm_resource_group.rg]
  count      = var.ppg_name == null ? 0 : 1

  name                = var.ppg_name
  resource_group_name = var.rg_name
}
