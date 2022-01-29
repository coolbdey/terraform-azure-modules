# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_certificate
resource "azurerm_key_vault_certificate" "cert" {
  depends_on = [data.azurerm_key_vault.kv]

  name         = var.name
  key_vault_id = data.azurerm_key_vault.kv.id

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = var.key_size
      key_type   = "RSA"
      reuse_key  = true
    }

    lifetime_action {
      action {
        action_type = "AutoRenew"
      }

      trigger {
        days_before_expiry = var.days_before_expiry
      }
    }

    secret_properties {
      content_type = var.content_type
    }

    x509_certificate_properties {
      extended_key_usage = length(local.extended_key_usage) == 0 ? null : local.extended_key_usage
      key_usage          = var.key_usage
      subject            = var.subject
      validity_in_months = var.validity_in_months

      subject_alternative_names {
        dns_names = var.dns_names
      }
    }
  }

  lifecycle {
    ignore_changes = [key_vault_id]
  }
}
