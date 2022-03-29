locals {
  interpreter          = ["PowerShell", "-Command"]
  is_selected_networks = var.network_acls.default_action == "Deny"
  key_opts = [
    "decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"
  ]
}
