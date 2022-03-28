# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set
resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  depends_on = [data.azurerm_resource_group.rg]

  name                            = var.name
  resource_group_name             = data.azurerm_resource_group.rg.name
  location                        = data.azurerm_resource_group.rg.location
  sku                             = var.sku
  instances                       = var.instances
  admin_username                  = var.admin_user
  admin_password                  = var.admin_pass
  disable_password_authentication = local.disable_password_authentication
  computer_name_prefix            = var.computer_name_prefix
  proximity_placement_group_id    = var.ppg_id
  encryption_at_host_enabled      = var.disk_encryption_enabled

  # TODO: plan - (Optional) A plan block as defined below. Changing this forces a new resource to be created.

  boot_diagnostics {
    storage_account_uri = var.sa_blob_endpoint
  }

  dynamic "admin_ssh_key" {
    for_each = var.public_key_file != null ? [1] : []
    iterator = each

    content {
      username   = var.admin_user
      public_key = file(var.public_key_file)
    }
  }

  # az vm image list --output table
  source_image_reference {
    publisher = local.source_image[var.source_image].publisher
    offer     = local.source_image[var.source_image].offer
    sku       = local.source_image[var.source_image].sku
    version   = local.source_image[var.source_image].version
  }

  additional_capabilities {
    ultra_ssd_enabled = local.ultra_ssd_enabled
  }

  os_disk {
    caching = var.os_disk.caching
    diff_disk_settings {
      option = "Local" # (Required) Specifies the Ephemeral Disk Settings for the OS Disk. At this time the only possible value is Local. Changing this forces a new resource to be created.
    }
    disk_encryption_set_id    = var.os_disk.disk_encryption_set_id
    disk_size_gb              = var.os_disk.disk_size_gb
    storage_account_type      = var.os_disk.storage_account_type
    write_accelerator_enabled = local.write_accelerator_enabled
  }

  dynamic "data_disk" {
    for_each = length(var.data_disks) > 0 ? var.data_disks : []
    iterator = each

    content {
      caching                   = each.value.caching
      create_option             = each.value.create_option
      disk_size_gb              = each.value.disk_size_gb
      disk_encryption_set_id    = each.value.disk_encryption_set_id
      lun                       = each.value.lun
      storage_account_type      = each.value.storage_account_type
      write_accelerator_enabled = each.value.write_accelerator_enabled
    }
  }

  dynamic "network_interface" {
    for_each = length(var.network_interfaces) > 0 ? var.network_interfaces : []
    iterator = each

    content {
      dns_servers                   = each.value.dns_servers
      enable_accelerated_networking = each.value.enable_accelerated_networking # (Optional) Does this Network Interface support Accelerated Networking? Defaults to false
      enable_ip_forwarding          = each.value.enable_ip_forwarding          # (Optional) Does this Network Interface support IP Forwarding? Defaults to false.

      dynamic "ip_configuration" {
        for_each = length(each.value.ip_configuration) > 0 ? each.value.ip_configuration : []
        iterator = eachsub

        content {
          application_gateway_backend_address_pool_ids = eachsub.value.agw_backend_address_pool_ids
          application_security_group_ids               = eachsub.value.asg_ids
          load_balancer_backend_address_pool_ids       = eachsub.value.lb_backend_ids
          load_balancer_inbound_nat_rules_ids          = eachsub.value.lb_onbound_nat_rules_ids
          name                                         = eachsub.value.name
          primary                                      = eachsub.value.primary
          public_ip_address = {
            name                    = eachsub.value.public_ip_address.name
            domain_name_label       = eachsub.value.public_ip_address.domain_name_label
            idle_timeout_in_minutes = eachsub.value.public_ip_address.idle_timeout_in_minutes
            # TODO: ip_tag
          }
          subnet_id = eachsub.value.subnet_id # subnet_id is required if version is set to IPv4
          version   = eachsub.value.version
        }
      }

      name                      = each.value.name
      network_security_group_id = each.value.network_security_group_id
      primary                   = each.value.primary
    }
  }

  dynamic "automatic_os_upgrade_policy" {
    for_each = var.upgrade_mode == "Automatic" ? [var.automatic_os_upgrade_policy] : []
    iterator = each
    content {
      disable_automatic_rollback  = each.value.disable_automatic_rollback
      enable_automatic_os_upgrade = each.value.enable_automatic_os_upgrade
    }
  }

  dynamic "automatic_instance_repair" {
    for_each = var.health_probe_id != null ? [var.automatic_instance_repair] : []
    iterator = each
    content {
      enabled      = each.value.enabled
      grace_period = each.value.grace_period
    }
  }

  dynamic "automatic_os_upgrade_policy" {
    for_each = var.upgrade_mode == "Automatic" ? [var.automatic_os_upgrade_policy] : []
    iterator = each
    content {
      disable_automatic_rollback  = each.value.disable_automatic_rollback
      enable_automatic_os_upgrade = each.value.enable_automatic_os_upgrade
    }
  }

  automatic_instance_repair {
    enabled      = var.automatic_instance_repair.enabled
    grace_period = var.automatic_instance_repair.grace_period
  }
}