data "azuread_client_config" "current" {}

data "azuread_service_principal" "sp" {
  depends_on = [azuread_service_principal.sp]

  display_name = var.name
}
