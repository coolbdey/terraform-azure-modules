resource "azurerm_key_vault_secret" "admin_user" {
  depends_on = [data.azurerm_key_vault.kv]

  name         = "vm-${var.name}-admin-user"
  value        = var.admin_user
  content_type = "Windows Virtual Machine administrator user for ${var.name}"
  key_vault_id = data.azurerm_key_vault.kv.id
  lifecycle {
    ignore_changes = [key_vault_id]
  }
}

resource "azurerm_key_vault_secret" "admin_pass" {
  depends_on = [data.azurerm_key_vault.kv]

  name         = "vm-${var.name}-admin-pass"
  value        = var.admin_pass
  content_type = "Windows Virtual Machine administrator password for ${var.name}"
  key_vault_id = data.azurerm_key_vault.kv.id

  lifecycle {
    ignore_changes = [key_vault_id]
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine
resource "azurerm_windows_virtual_machine" "wvm" {
  depends_on = [
    data.azurerm_resource_group.rg,
    azurerm_key_vault_secret.admin_user,
    azurerm_key_vault_secret.admin_pass
  ]

  name                = var.name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  computer_name       = var.computer_name
  size                = var.vm_size
  admin_username      = var.admin_user
  admin_password      = var.admin_pass
  network_interface_ids = [ #  (Required). A list of Network Interface ID's which should be attached to this Virtual Machine. The first Network Interface ID in this list will be the Primary Network Interface on the Virtual Machine.
    data.azurerm_network_interface.nic.id,
  ]
  #availability_set_id          = var.vmss_name == null ? null : data.azurerm_virtual_machine_scale_set.vmss[0].id
  enable_automatic_updates     = false           #  (Optional) Specifies if Automatic Updates are Enabled for the Windows Virtual Machine. Changing this forces a new resource to be created.
  patch_mode                   = "AutomaticByOS" # - (Optional) Specifies the mode of in-guest patching to this Windows Virtual Machine. Possible values are Manual, AutomaticByOS and AutomaticByPlatform. Defaults to AutomaticByOS.
  priority                     = "Regular"       # (Optional) Specifies the priority of this Virtual Machine. Possible values are Regular and Spot. Defaults to Regular. Changing this forces a new resource to be created.
  proximity_placement_group_id = var.ppg_name == null ? null : data.azurerm_proximity_placement_group.ppg[0].id
  timezone                     = var.timezone
  virtual_machine_scale_set_id = var.vmss_name == null ? null : data.azurerm_virtual_machine_scale_set.vmss[0].id

  os_disk {
    name                 = var.disk_name
    caching              = "ReadWrite"
    storage_account_type = var.sa_type
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = var.image_sku
    version   = var.image_version
  }

  identity {
    type = "SystemAssigned"
  }

  /*
  additional_unattend_content {
    content = 
    setting = 
  }
  */

  secret {
    key_vault_id = data.azurerm_key_vault.kv.id
    certificate {
      #  (Required) The ID of the Key Vault Secret. Stored secret is the Base64 encoding of a JSON Object that which is encoded in UTF-8 of which the contents need to be:
      url   = data.azurerm_key_vault_certificate.kv_cert.secret_id
      store = "My" # (Required, on windows machines) Specifies the certificate store on the Virtual Machine where the certificate should be added to, such as My
    }
  }

  winrm_listener {
    protocol        = "https"
    certificate_url = data.azurerm_key_vault_certificate.kv_cert.secret_id
  }

  lifecycle {
    ignore_changes = [tags["updated_date"], location]
  }
}

resource "azurerm_management_lock" "vm_lock" {
  depends_on = [azurerm_windows_virtual_machine.wvm]
  count      = var.lock_resource ? 1 : 0

  name       = "CanNotDelete"
  scope      = azurerm_windows_virtual_machine.wvm.id
  lock_level = "CanNotDelete"
  notes      = "Terraform: This prevents accidental deletion on this resource"
}

