locals {
  source_image = {
    "W2019" = {
      offer     = "WindowsServer"
      publisher = "MicrosoftWindowsServer"
      sku       = "2019-Datacenter"
      version   = "latest"
    }
    "W2016" = {
      offer     = "WindowsServer"
      publisher = "MicrosoftWindowsServer"
      sku       = "2016-Datacenter"
      version   = "latest"
    }
    "W2012R2" = {
      offer     = "WindowsServer"
      publisher = "MicrosoftWindowsServer"
      sku       = "2012-R2-Datacenter"
      version   = "latest"
    }
    "W2012" = {
      offer     = "WindowsServer"
      publisher = "MicrosoftWindowsServer"
      sku       = "2012-Datacenter"
      version   = "latest"
    }
    "W2008R2" = {
      offer     = "WindowsServer"
      publisher = "MicrosoftWindowsServer"
      sku       = "2008-R2-SP1"
      version   = "latest"
    }
  }
  write_accelerator_enabled = var.os_disk.storage_account_type == "Premium_LRS" && var.os_disk.caching == "None" ? var.os_disk.write_accelerator_enabled : false
  os_disk_caching           = var.ephemeral_disk_support ? "ReadOnly" : var.os_disk.caching
  identity_ids              = var.managed_identity_type == "UserAssigned" || var.managed_identity_type == "SystemAssigned, UserAssigned" ? toset(var.managed_identity_ids) : null
}