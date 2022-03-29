# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_scale_set_extension
resource "azurerm_virtual_machine_scale_set_extension" "vmsse" {
  name                         = var.name
  virtual_machine_scale_set_id = var.vmss_id
  publisher                    = var.publisher
  type                         = var.type
  type_handler_version         = var.type_handler_version
  auto_upgrade_minor_version   = var.auto_upgrade_minor_version
  automatic_upgrade_enabled    = var.automatic_upgrade_enabled
  provision_after_extensions   = sort(var.provision_after_extensions)
  settings                     = jsonencode(var.settings_map)
  protected_settings           = var.protected_settings_map == null ? null : jsonencode(var.protected_settings_map)
  
  # TODO: force_update_tag #  (Optional) A value which, when different to the previous value can be used to force-run the Extension even if the Extension Configuration hasn't changed.
}