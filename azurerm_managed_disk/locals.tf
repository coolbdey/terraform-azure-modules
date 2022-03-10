locals {
  hyper_v_generation  = can(regex("Import|Copy", var.create_option)) ? var.hyper_v_generation : null
  image_reference_id  = var.create_option == "FromImage" ? var.image_reference_id : null
  logical_sector_size = var.storage_account_type != "UltraSSD_LRS" ? null : var.logical_sector_size
  os_type             = can(regex("Import|Copy", var.create_option)) ? var.os_type : null
  source_resource_id  = can(regex("Copy|Restore", var.create_option)) ? var.source_resource_id : null
  source_uri          = var.create_option == "Import" ? var.source_uri : null
  storage_account_id  = var.create_option == "Import" ? var.storage_account_id : null
  tier                = can(regex("SSD", var.storage_account_type)) ? var.tier : null
  disk_access_id      = var.network_access_policy == "AllowPrivate" ? var.disk_access_id : null
  
  

}