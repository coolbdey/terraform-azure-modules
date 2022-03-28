locals {
  source_image = {
    "centos" = {
      offer     = "CentOS"
      publisher = "OpenLogic"
      version   = "latest"
      sku       = "7.5"
    }
    "opensuse" = {
      offer     = "openSUSE-Leap"
      publisher = "SUSE"
      version   = "latest"
      sku       = "42.3"
    }
    "sles" = {
      offer     = "SLES"
      publisher = "SUSE"
      version   = "latest"
      sku       = "15"
    }
    "debian" = {
      offer     = "debian-10"
      publisher = "Debian"
      version   = "latest"
      sku       = "10"
    }
    "redhat" = {
      offer     = "RHEL"
      publisher = "RedHat"
      version   = "latest"
      sku       = "7-LVM"
    }
    "ubuntu" = {
      offer     = "UbuntuServer"
      publisher = "Canonical"
      version   = "latest"
      sku       = "18.04-LTS"
    }
  }
  disable_password_authentication = var.admin_pass != null ? false : var.disable_password_authentication
  write_accelerator_enabled       = var.os_disk.storage_account_type == "Premium_LRS" && var.os_disk.caching == "None" ? var.os_disk.write_accelerator_enabled : false
  ultra_ssd_enabled               = can(regex("SSD", var.os_disk.storage_account_type)) ? var.ultra_ssd_enabled : false
  os_disk_caching           = var.ephemeral_disk_support ? "ReadOnly" : var.os_disk.caching
}
