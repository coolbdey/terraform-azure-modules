
resource "null_resource" "kv_recover" {
  depends_on = [data.azurerm_resource_group.rg]
  count      = var.recover_keyvault ? 1 : 0

  triggers = {
    // always execute
    uuid_trigger = "${uuid()}"
  }
  provisioner "local-exec" {
    when        = create
    command     = <<EOF
      "az keyvault recover --name ${var.name} --resource-group ${var.rg_name}"
    EOF
    interpreter = local.interpreter
    working_dir = path.module
    on_failure  = continue
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault
resource "azurerm_key_vault" "kv" {
  depends_on = [null_resource.kv_recover]

  name                            = var.name
  resource_group_name             = data.azurerm_resource_group.rg.name
  location                        = data.azurerm_resource_group.rg.location
  enabled_for_disk_encryption     = true
  tenant_id                       = var.tenant_id
  soft_delete_retention_days      = var.soft_delete_retention_days
  purge_protection_enabled        = false # DO NOT CHANGE THIS, CAUSES PROBLEMS IN TERRAFORM!! Once Purge Protection is enabled, this option cannot be disabled"
  enabled_for_deployment          = true
  enabled_for_template_deployment = true
  enable_rbac_authorization       = var.enable_rbac_authorization
  sku_name                        = var.sku_name
  tags                            = var.tags

  network_acls {
    default_action             = var.network_acls.default_action
    bypass                     = var.network_acls.bypass
    ip_rules                   = var.network_acls.ip_rules
    virtual_network_subnet_ids = var.network_acls.virtual_network_subnet_ids
  }

  lifecycle {
    ignore_changes = [tags["updated_date"], location, soft_delete_retention_days] # Must have this or else the resource will be replaced
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault
resource "azurerm_key_vault_access_policy" "change" {
  depends_on = [azurerm_key_vault.kv]
  count      = var.enable_rbac_authorization ? 0 : length(var.object_ids)

  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = var.tenant_id
  object_id    = var.object_ids[count.index] #data.azuread_client_config.current.object_id

  key_permissions = [
    "create",
    "get",
    "purge",
    "recover",
    "list",
    "delete",
    "update",
    "backup",
    "restore"
  ]

  secret_permissions = [
    "get",
    "list",
    "set",
    "delete",
    "purge",
    "recover",
    "backup",
    "restore"
  ]

  /* If Sku is Premium
  storage_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Restore",
    "Update",
    "Recover",
    "RegenerateKey"
  ]*/

  certificate_permissions = [
    "backup", "create", "delete", "deleteissuers", "get", "getissuers", "import", "list", "listissuers", "managecontacts", "manageissuers", "purge", "recover", "restore", "setissuers", "update"
  ]

  #lifecycle {
  #  ignore_changes = [key_vault_id, object_id] # Must have this or else the resource will be replaced
  #}
}


resource "azurerm_role_assignment" "role" {
  depends_on = [azurerm_key_vault.kv]
  count      = var.enable_rbac_authorization ? length(var.rbac_roles) : 0

  scope                = azurerm_key_vault.kv.id
  role_definition_name = var.rbac_roles[count.index].role_definition_name
  principal_id         = var.rbac_roles[count.index].principal_id
}

resource "azurerm_key_vault_secret" "secret" {
  depends_on = [azurerm_key_vault_access_policy.change, azurerm_role_assignment.role]
  count      = length(var.secrets)

  key_vault_id = azurerm_key_vault.kv.id
  name         = var.secrets[count.index].name
  value        = var.secrets[count.index].value
  content_type = var.secrets[count.index].content_type
}

/*

resource "azurerm_key_vault_certificate" "cert_self" {
  depends_on = [azurerm_key_vault_access_policy.change, azurerm_role_assignment.role]
  count      = length(var.certificates)

  name         = var.certificates[count.index].name
  key_vault_id = azurerm_key_vault.kv.id

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = true
    }

    lifetime_action {
      action {
        action_type = "AutoRenew"
      }

      trigger {
        days_before_expiry = 30
      }
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    x509_certificate_properties {
      extended_key_usage = length(local.extended_key_usage) == 0 ? null : local.extended_key_usage 

      key_usage = [
        "cRLSign",
        "dataEncipherment",
        "digitalSignature",
        "keyAgreement",
        "keyCertSign",
        "keyEncipherment",
      ]

      subject_alternative_names {
        dns_names = var.certificates[count.index].dns_names
      }

      subject            = var.certificates[count.index].subject
      validity_in_months = var.certificates[count.index].validity_in_months
    }
  }
}

*/

resource "azurerm_management_lock" "kv_lock" {
  depends_on = [azurerm_key_vault.kv]
  count      = var.lock_resource ? 1 : 0

  name       = "CanNotDelete"
  scope      = azurerm_key_vault.kv.id
  lock_level = "CanNotDelete"
  notes      = "Terraform: This prevents accidental deletion if this resource"
}
