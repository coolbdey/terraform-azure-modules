# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk
resource "azurerm_managed_disk" "md" {
  depends_on = [data.azurerm_resource_group.rg]

  name                   = var.name
  location               = data.azurerm_resource_group.rg.location
  resource_group_name    = data.azurerm_resource_group.rg.name
  storage_account_type   = var.storage_account_type
  create_option          = var.create_option
  disk_size_gb           = var.disk_size_gb
  disk_encryption_set_id = var.disk_encryption_set_id
  disk_access_id         = local.disk_access_id
  hyper_v_generation     = local.hyper_v_generation
  image_reference_id     = local.image_reference_id
  logical_sector_size    = local.logical_sector_size
  network_access_policy  = var.network_access_policy
  os_type                = local.os_type
  source_resource_id     = local.source_resource_id
  source_uri             = local.source_uri
  storage_account_id     = local.storage_account_id
  tier                   = local.tier
  max_shares             = var.max_shares
  edge_zone              = var.edge_zone
  zone                   = var.zone
  tags                   = var.tags


  # TODO: disk_iops_read_write - (Optional) The number of IOPS allowed for this disk; only settable for UltraSSD disks. One operation can transfer between 4k and 256k bytes.
  # TODO: disk_mbps_read_write - (Optional) The bandwidth allowed for this disk; only settable for UltraSSD disks. MBps means millions of bytes per seconds
  # TODO: disk_iops_read_only - (Optional) The number of IOPS allowed across all VMs mounting the shared disk as read-only; only settable for UltraSSD disks with shared disk enabled. One operation can transfer between 4k and 256k bytes.
  # TODO: disk_mbps_read_only - (Optional) The bandwidth allowed across all VMs mounting the shared disk as read-only; only settable for UltraSSD disks with shared disk enabled. MBps means millions of bytes per second.
  # TODO: gallery_image_reference_id - (Optional) ID of a Gallery Image Version to copy when create_option is FromImage. This field cannot be specified if image_reference_id is specified.
  # TODO: trusted_launch_enabled (Optional) Specifies if Trusted Launch is enabled for the Managed Disk. Defaults to false. when create_option is FromImage or Import
  # TODO: on_demand_bursting_enabled (Optional) Specifies if On-Demand Bursting is enabled for the Managed Disk. Defaults to false. Enabled by default on all eligible disks


  dynamic "encryption_settings" {
    for_each = var.encryption_settings.enabled ? [1] : []
    iterator = each
    content {
      enabled = var.encryption_settings.enabled
      disk_encryption_key {
        secret_url      = var.encryption_settingssecret_url
        source_vault_id = var.encryption_settings.source_vault_id
      }
      key_encryption_key {
        key_url         = var.encryption_settings.key_url
        source_vault_id = var.encryption_settings.source_vault_id
      }
    }
  }

  lifecycle {
    ignore_changes = [location]
  }

}

