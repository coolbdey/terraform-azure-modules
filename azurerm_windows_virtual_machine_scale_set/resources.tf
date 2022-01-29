resource "azurerm_key_vault_secret" "admin_user" {
  depends_on = [data.azurerm_key_vault.kv]

  name         = "vm-${var.name}-admin-user"
  value        = var.admin_user
  content_type = "Windows Virtual Machine Scale Set administrator user for ${var.name}"
  key_vault_id = data.azurerm_key_vault.kv.id
  lifecycle {
    ignore_changes = [key_vault_id]
  }
}

resource "azurerm_key_vault_secret" "admin_pass" {
  depends_on = [data.azurerm_key_vault.kv]

  name         = "vm-${var.name}-admin-pass"
  value        = var.admin_pass
  content_type = "Windows Virtual Machine Scale Set administrator password for ${var.name}"
  key_vault_id = data.azurerm_key_vault.kv.id

  lifecycle {
    ignore_changes = [key_vault_id]
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine_scale_set
resource "azurerm_windows_virtual_machine_scale_set" "vmss" {
  depends_on = [
    data.azurerm_resource_group.rg,
    azurerm_key_vault_secret.admin_user,
    azurerm_key_vault_secret.admin_pass
  ]

  name                     = var.name
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  sku                      = var.sku
  instances                = var.instances
  admin_password           = var.admin_pass
  admin_username           = var.admin_user
  computer_name_prefix     = var.computer_name_prefix
  timezone                 = var.timezone
  enable_automatic_updates = true
  upgrade_mode             = "Manual" # (Optional) Specifies how Upgrades (e.g. changing the Image/SKU) should be performed to Virtual Machine Instances. Possible values are Automatic, Manual and Rolling. Defaults to Manual.
  zone_balance             = var.zone_balance
  zones                    = var.zones

  identity {
    type = "SystemAssigned"
  }
  license_type = "Windows_Server" #  (Optional) Specifies the type of on-premise license (also known as Azure Hybrid Use Benefit) which should be used for this Virtual Machine Scale Set. Possible values are None, Windows_Client and Windows_Server.

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = var.image_sku
    version   = var.image_version
  }

  os_disk {
    name                 = var.disk_name
    caching              = "ReadWrite"
    storage_account_type = var.sa_type
  }

  network_interface {
    name    = var.nic_name
    primary = true

    dynamic "ip_configuration" {
      for_each = length(var.nic_ip_configurations) > 0 ? var.nic_ip_configurations : []
      iterator = each

      content {
        name                                         = each.value.name
        primary                                      = each.value.primary
        subnet_id                                    = each.value.subnet_id # subnet_id is required if version is set to IPv4
        application_gateway_backend_address_pool_ids = each.value.agw_backend_address_pool_ids
        application_security_group_ids               = each.value.asg_ids
        load_balancer_backend_address_pool_ids       = each.value.lb_backend_ids
        load_balancer_inbound_nat_rules_ids          = each.value.lb_onbound_nat_rules_ids
        version                                      = "IPv4"
      }
    }
    dns_servers                   = var.nic_dns_servers
    enable_accelerated_networking = false                        # (Optional) Does this Network Interface support Accelerated Networking? Defaults to false
    enable_ip_forwarding          = var.nic_enable_ip_forwarding #  (Optional) Does this Network Interface support IP Forwarding? Defaults to false.
    network_security_group_id     = ""
  }
  automatic_os_upgrade_policy {
    disable_automatic_rollback  = false
    enable_automatic_os_upgrade = false
  }
  automatic_instance_repair {
    enabled = true
    #grace_period =  # (Optional) Amount of time (in minutes, between 30 and 90, defaults to 30 minutes) for which automatic repairs will be delayed. The grace period starts right after the VM is found unhealthy. The time duration should be specified in ISO 8601 format.
  }

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
  data_disk {
    caching              = "ReadWrite"
    create_option        = "Empty"
    disk_size_gb         = 20
    storage_account_type = var.sa_type
  }

  lifecycle {
    ignore_changes = [tags["updated_date"], location]
  }
}
