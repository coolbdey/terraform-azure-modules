data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_key_vault" "kv" {
  depends_on = [data.azurerm_resource_group.rg]

  name                = var.kv_name
  resource_group_name = var.rg_name
}
data "azurerm_key_vault_certificate" "kv_cert" {
  depends_on = [data.azurerm_key_vault.kv]

  name         = var.kv_cert_name
  key_vault_id = data.azurerm_key_vault.kv.id
}
