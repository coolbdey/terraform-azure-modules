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

#---------------------------------------------------------------
# Generates SSH2 key Pair for Linux VM's (Dev Environment only)
#---------------------------------------------------------------
resource "tls_private_key" "rsa" {
  count     = var.generate_admin_ssh_key ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine
resource "azurerm_linux_virtual_machine" "vm" {
  depends_on = [
    data.azurerm_resource_group.rg,
    azurerm_key_vault_secret.admin_user,
    azurerm_key_vault_secret.admin_pass,
    tls_private_key.rsa
  ]

  name                            = var.name
  resource_group_name             = data.azurerm_resource_group.rg.name
  location                        = data.azurerm_resource_group.rg.location
  computer_name                   = var.computer_name
  size                            = var.size
  admin_username                  = var.admin_user
  admin_password                  = var.admin_pass
  network_interface_ids           = var.nic_ids
  availability_set_id             = var.vmss_id == null ? null : var.as_id
  disable_password_authentication = local.disable_password_authentication
  license_type                    = var.license_type
  allow_extension_operations      = var.allow_extension_operations
  patch_mode                      = var.patch_mode
  priority                        = var.priority
  proximity_placement_group_id    = var.ppg_id
  encryption_at_host_enabled      = var.disk_encryption_enabled
  eviction_policy                 = var.priority == "Spot" ? "Deallocate" : null #  (Optional) Specifies what should happen when the Virtual Machine is evicted for price reasons when using a Spot instance. At this time the only supported value is Deallocate. Changing this forces a new resource to be created.
  provision_vm_agent              = var.provision_vm_agent
  virtual_machine_scale_set_id    = var.vmss_id
  source_image_id                 = var.source_image_id
  tags                            = var.tags

  # TODO: custom_data - (Optional) The Base64-Encoded Custom Data which should be used for this Virtual Machine. Changing this forces a new resource to be created.
  # TODO: dedicated_host_id - (Optional) The ID of a Dedicated Host where this machine should be run on. Conflicts with dedicated_host_group_id.
  # TODO: dedicated_host_group_id - (Optional) The ID of a Dedicated Host Group that this Linux Virtual Machine should be run within. Conflicts with dedicated_host_id.
  # TODO: extensions_time_budget - (Optional) Specifies the duration allocated for all extensions to start. The time duration should be between 15 minutes and 120 minutes (inclusive) and should be specified in ISO 8601 format. Defaults to 90 minutes (PT1H30M).
  # TODO: max_bid_price = var.priority == "Spot" ? var.max_bid_price : null (Optional) The maximum price you're willing to pay for this Virtual Machine, in US Dollars; which must be greater than the current spot price. If this bid price falls below the current spot price the Virtual Machine will be evicted using the eviction_policy. Defaults to -1, which means that the Virtual Machine should not be evicted for price reasons.
  # TODO: platform_fault_domain - (Optional) Specifies the Platform Fault Domain in which this Linux Virtual Machine should be created. Defaults to -1, which means this will be automatically assigned to a fault domain that best maintains balance across the available fault domains. Changing this forces a new Linux Virtual Machine to be created.
  # TODO: plan - (Optional) A plan block as defined below. Changing this forces a new resource to be created.
  # TODO: secure_boot_enabled - (Optional) Specifies whether secure boot should be enabled on the virtual machine. Changing this forces a new resource to be created.
  # TODO: user_data - (Optional) The Base64-Encoded User Data which should be used for this Virtual Machine.
  # TODO: zone - (Optional) The Zone in which this Virtual Machine should be created. Changing this forces a new resource to be created.

  dynamic "boot_diagnostics" {
    for_each = var.sa_blob_endpoint != null ? [1] : []
    content {
      storage_account_uri = var.sa_blob_endpoint
    }
  }

  dynamic "admin_ssh_key" {
    for_each = var.disable_password_authentication && var.public_key_file != null ? [1] : []
    content {
      username   = var.admin_user
      public_key = var.public_key_file == null ? tls_private_key.rsa[0].public_key_openssh : file(var.public_key_file)
    }
  }

  additional_capabilities {
    ultra_ssd_enabled = local.ultra_ssd_enabled
  }

  dynamic "identity" {
    for_each = var.managed_identity_type != null ? [1] : []
    content {
      type         = var.managed_identity_type
      identity_ids = local.identity_ids
    }
  }

  dynamic "source_image_reference" {
    for_each = var.source_image_id == null ? [1] : []

    content {
      publisher = local.source_image[var.source_image].publisher
      offer     = local.source_image[var.source_image].offer
      sku       = local.source_image[var.source_image].sku
      version   = local.source_image[var.source_image].version
    }
  }

  os_disk {
    name                      = local.os_disk_name
    storage_account_type      = var.os_disk.storage_account_type
    caching                   = local.os_disk_caching
    disk_encryption_set_id    = var.os_disk.disk_encryption_set_id
    write_accelerator_enabled = local.write_accelerator_enabled

    dynamic "diff_disk_settings" {
      for_each = var.ephemeral_disk_support ? [1] : []
      content {
        option = "Local" # (Required) Specifies the Ephemeral Disk Settings for the OS Disk. At this time the only possible value is Local. Changing this forces a new resource to be created.
      }
    }
  }

  secret {
    # (Required) The ID of the Key Vault from which all Secrets should be sourced.
    key_vault_id = data.azurerm_key_vault.kv.id
    certificate {
      #  (Required) The Secret URL of a Key Vault Certificate. This can be sourced from the secret_id field within the azurerm_key_vault_certificate Resource.
      url = data.azurerm_key_vault_certificate.kv_cert.secret_id
    }
  }

  lifecycle {
    ignore_changes = [tags["updated_date"], location]
  }
}