
resource "azurerm_role_assignment" "apim_identity_on_kv" {
  depends_on = [azurerm_key_vault_certificate.certapim]

  scope                = var.kv_id
  role_definition_name = "Key Vault Administrator" # Key Vault Secrets User
  principal_id         = var.apim_principal_id
}

resource "null_resource" "nslookup" {

  provisioner "local-exec" {
    command    = "nslookup ${var.gateway.host_name}"
    on_failure = continue
  }

  provisioner "local-exec" {
    command    = "nslookup ${var.developer_portal.host_name}"
    on_failure = continue
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_custom_domain
resource "azurerm_api_management_custom_domain" "amcd" {
  depends_on = [azurerm_role_assignment.apim_identity_on_kv, null_resource.nslookup]

  api_management_id = var.api_management_id

  # Mandatory
  gateway {
    host_name                    = replace(var.gateway.host_name,".","-")
    key_vault_id                 = var.gateway.kv_certificate_secret_id
    certificate                  = var.gateway.kv_certificate_secret_id == null ? var.gateway.certificate : null
    certificate_password         = var.gateway.kv_certificate_secret_id == null ? var.gateway.certificate_password : null
    negotiate_client_certificate = var.gateway.negotiate_client_certificate
  }

  # Mandatory
  developer_portal {
    host_name                    = replace(var.developer_portal.host_name,".","-")
    key_vault_id                 = var.developer_portal.kv_certificate_secret_id
    certificate                  = var.developer_portal.kv_certificate_secret_id == null ? var.developer_portal.certificate : null
    certificate_password         = var.developer_portal.kv_certificate_secret_id == null ? var.developer_portal.certificate_password : null
    negotiate_client_certificate = var.developer_portal.negotiate_client_certificate
  }

  # Optional
  dynamic "portal" {
    for_each = var.portal.enabled ? [1] : []

    contents {
      host_name                    = replace(var.portal.host_name,".","-")
      key_vault_id                 = var.portal.kv_certificate_secret_id
      certificate                  = var.portal.kv_certificate_secret_id == null ? var.portal.certificate : null
      certificate_password         = var.portal.kv_certificate_secret_id == null ? var.portal.certificate_password : null
      negotiate_client_certificate = var.portal.negotiate_client_certificate
    }
  }

  # Optional
  dynamic "management" {
    for_each = var.scm.enabled ? [1] : []

    contents {
      host_name                    = replace(var.management.host_name,".","-")
      key_vault_id                 = var.management.kv_certificate_secret_id
      certificate                  = var.management.kv_certificate_secret_id == null ? var.management.certificate : null
      certificate_password         = var.management.kv_certificate_secret_id == null ? var.management.certificate_password : null
      negotiate_client_certificate = var.management.negotiate_client_certificate
    }
  }

  # Optional
  dynamic "scm" {
    for_each = var.scm.enabled ? [1] : []

    contents {
      host_name                    = replace(var.scm.host_name,".","-")
      key_vault_id                 = var.scm.kv_certificate_secret_id
      certificate                  = var.scm.kv_certificate_secret_id == null ? var.scm.certificate : null
      certificate_password         = var.scm.kv_certificate_secret_id == null ? var.scm.certificate_password : null
      negotiate_client_certificate = var.scm.negotiate_client_certificate
    }
  }
}
