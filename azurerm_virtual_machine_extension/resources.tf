# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension
resource "azurerm_virtual_machine_extension" "vme" {
  depends_on = [data.azurerm_resource_group.rg]

  name                       = var.name
  virtual_machine_id         = var.vm_id
  publisher                  = var.publisher
  type                       = var.type
  type_handler_version       = var.type_handler_version
  auto_upgrade_minor_version = var.auto_upgrade_minor_version
  automatic_upgrade_enabled  = var.automatic_upgrade_enabled
  settings                   = jsonencode(var.settings_json)
  tags                       = var.tags
}