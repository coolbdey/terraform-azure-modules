locals {
  source_image = {
    "W2019" = {
      sku     = "2019-Datacenter"
      version = "latest"
    }
    "W2016" = {
      sku     = "2016-Datacenter"
      version = "latest"
    }
    "W2012R2" = {
      sku     = "2012-R2-Datacenter"
      version = "latest"
    }
    "W2012" = {
      sku     = "2012-Datacenter"
      version = "latest"
    }
    "W2008R2" = {
      sku     = "2008-R2-SP1"
      version = "latest"
    }
  }
  write_accelerator_enabled = var.os_disk.storage_account_type == "Premium_LRS" && var.os_disk.caching == "None" ? var.os_disk.write_accelerator_enabled : false
  os_disk_name = var.os_disk.name == "Default" ? "${var.name}-dsk" : var.os_disk.name
}