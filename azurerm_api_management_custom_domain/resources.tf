
resource "azurerm_key_vault_certificate" "certapim" {
  depends_on = [data.azurerm_key_vault.kv]

  name         = local.name
  key_vault_id = data.azurerm_key_vault.kv.id

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = local.key_size
      key_type   = "RSA"
      reuse_key  = true
    }

    lifetime_action {
      action {
        action_type = "AutoRenew"
      }

      trigger {
        days_before_expiry = local.days_before_expiry
      }
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    x509_certificate_properties {
      key_usage = [
        "cRLSign",
        "dataEncipherment",
        "digitalSignature",
        "keyAgreement",
        "keyCertSign",
        "keyEncipherment",
      ]

      subject            = local.subject
      validity_in_months = local.validity_in_months

      subject_alternative_names {
        dns_names = [
          var.host_name_proxy,
          var.host_name_portal

        ]
      }
    }
  }

  lifecycle {
    ignore_changes = [key_vault_id]
  }
}

resource "azurerm_role_assignment" "apim_identity_on_kv" {
  depends_on = [data.azurerm_api_management.apim, azurerm_key_vault_certificate.certapim]

  scope                = data.azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Administrator" # Key Vault Secrets User
  principal_id         = data.azurerm_api_management.apim.identity.0.principal_id
}

resource "null_resource" "nslookup" {

  provisioner "local-exec" {
    command    = "nslookup ${var.host_name_proxy}"
    on_failure = continue
  }

  provisioner "local-exec" {
    command    = "nslookup ${var.host_name_portal}"
    on_failure = continue
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_custom_domain
resource "azurerm_api_management_custom_domain" "domain" {
  depends_on = [azurerm_role_assignment.apim_identity_on_kv, null_resource.nslookup]

  api_management_id = data.azurerm_api_management.apim.id

  gateway {
    host_name    = var.host_name_proxy
    key_vault_id = azurerm_key_vault_certificate.certapim.secret_id
  }

  developer_portal {
    host_name                    = var.host_name_portal
    key_vault_id                 = azurerm_key_vault_certificate.certapim.secret_id
    negotiate_client_certificate = false #(Optional) Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false
  }
}
