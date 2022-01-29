resource "azurerm_key_vault_secret" "admin_user" {
  depends_on = [data.azurerm_key_vault.kv]

  name         = "vm-${var.name}-lin-admin-user"
  value        = var.admin_user
  content_type = "Azure Virtual Machine administrator user"
  key_vault_id = data.azurerm_key_vault.kv.id

  lifecycle {
    ignore_changes = [key_vault_id]
  }
}

resource "azurerm_key_vault_secret" "admin_pass" {
  depends_on = [data.azurerm_key_vault.kv]

  name         = "vm-${var.name}-lin-admin-pass"
  value        = var.admin_pass
  content_type = "Azure Virtual Machine administrator password"
  key_vault_id = data.azurerm_key_vault.kv.id

  lifecycle {
    ignore_changes = [key_vault_id]
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine
resource "azurerm_linux_virtual_machine" "vm" {
  depends_on = [
    data.azurerm_resource_group.rg,
    azurerm_key_vault_secret.admin_user,
    azurerm_key_vault_secret.admin_pass
  ]

  name                             = var.name
  resource_group_name              = data.azurerm_resource_group.rg.name
  location                         = data.azurerm_resource_group.rg.location
  network_interface_ids            = [data.azurerm_network_interface.nic.id]
  computer_name                    = var.computer_name
  vm_size                          = var.vm_size
  disable_password_authentication  = false
  delete_os_disk_on_termination    = true # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_data_disks_on_termination = true # Uncomment this line to delete the data disks automatically when deleting the VM
  tags                             = var.tags

  identity {
    type = "SystemAssigned"
  }

  source_image_reference {
    publisher = local.publisher
    offer     = local.offer
    sku       = local.sku
    version   = "latest"
  }
  os_disk {
    #name    = "myosdisk1"
    caching = "ReadWrite"
    #create_option        = "FromImage" # Empty
    storage_account_type = "Standard_LRS"
  }
  admin_ssh_key {
    username   = var.admin_user
    public_key = file("~/.ssh/id_rsa.pub")
  }

  lifecycle {
    ignore_changes = [tags["updated_date"], location]
  }
}
