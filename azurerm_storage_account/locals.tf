locals {
  is_selected_networks              = var.network_rules.default_action == "Deny"
  account_tier                      = can(regex("BlockBlobStorage|FileStorage", var.account_kind)) ? "Premium" : var.account_tier
  infrastructure_encryption_enabled = var.account_kind == "StorageV2" || (var.access_tier == "Premium" || var.account_kind == "BlockBlobStorage") ? var.infrastructure_encryption_enabled : false
  identity_ids                      = var.managed_identity_type == "UserAssigned" || var.managed_identity_type == "SystemAssigned, UserAssigned" ? toset(var.managed_identity_ids) : null
}
