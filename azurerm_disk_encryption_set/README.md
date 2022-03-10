
Disk Encryption Set requires Purge Protection to be enabled on KeyVault

```t
resource "azurerm_role_assignment" "kv_role" {
  depends_on = [module.disk_encryption_set]
  count      = length(var.des_names)

  scope                = module.keyvault.id
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = module.disk_encryption_set[count.index].principal_id
}
```