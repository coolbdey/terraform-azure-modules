locals {
  interpreter          = ["PowerShell", "-Command"]
  is_selected_networks = var.network_rules.default_action == "Deny"
}
