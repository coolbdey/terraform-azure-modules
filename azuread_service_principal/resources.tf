# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal
# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal

resource "azuread_application" "app" {
  display_name = var.name
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "sp" {
  application_id               = azuread_application.app.application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
  description                  = var.description

  feature_tags {
    enterprise = var.enterprise
    gallery    = var.enterprise
  }
}

resource "time_rotating" "days" {
  rotation_days = var.rotation_days
}

resource "azuread_service_principal_password" "pass" {
  service_principal_id = azuread_service_principal.sp.object_id
  rotate_when_changed = {
    rotation = time_rotating.days.id
  }
}
