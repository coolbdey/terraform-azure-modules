locals {
  infrastructure_encryption_enabled = var.account_kind != "StorageV2" ? false : var.infrastructure_encryption_enabled
  is_selected_networks              = var.network_rules.default_action == "Deny"
}
