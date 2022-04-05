# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension
resource "azurerm_virtual_machine_extension" "vme" {
  count = length(var.vm_ids)

  name                       = var.name
  virtual_machine_id         = var.vm_ids[count.index]
  publisher                  = var.publisher
  type                       = var.type
  type_handler_version       = var.type_handler_version
  auto_upgrade_minor_version = var.auto_upgrade_minor_version
  automatic_upgrade_enabled  = var.automatic_upgrade_enabled
  settings                   = jsonencode(var.settings_map)
  protected_settings         = var.protected_settings_map == null ? null : jsonencode(var.protected_settings_map)
  tags                       = var.tags

  lifecycle {
    ignore_changes = [tags, virtual_machine_id]
  }
}