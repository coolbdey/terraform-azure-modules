resource "azurerm_managed_disk" "md" {
  depends_on = [data.azurerm_resource_group.rg]
  
  name                 = var.name
  location             = data.azurerm_resource_group.main.location
  resource_group_name  = data.azurerm_resource_group.main.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment
resource "azurerm_virtual_machine_data_disk_attachment" "vmdda" {
    depends_on = [azurerm_managed_disk.md]

  managed_disk_id    = azurerm_managed_disk.md.id
  virtual_machine_id = var.virtual_machine_id
  lun                = var.lun # "10"
  caching            = var.caching # "ReadWrite"
}