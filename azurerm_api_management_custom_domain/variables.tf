variable "kv_id" {}
variable "apim_id" {}
variable "apim_principal_id" {}

variable "gateway" {
  type = object({
    host_name                    = string # (Required) The Hostname to use for the corresponding endpoint.
    certificate                  = string # (Optional) The Base64 Encoded Certificate. (Mutually exclusive with kv_certificate_secret_id)
    certificate_password         = string # (Optional) The password associated with the certificate provided above.
    kv_certificate_secret_id     = string # (Optional) The ID of the Key Vault Certifcate Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12
    negotiate_client_certificate = bool   # (Optional) Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.
  })
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]+\\.[a-z]{2,}$|^[a-z][a-z0-9-_]+\\.[a-z0-9-]+\\.[a-z]{2,}$", var.gateway.host_name))
    error_message = "The variable 'gateway.host_name' must be a valid domain name, ex name.domain.no or domain.no."
  }
  sensitive = true
}

variable "developer_portal" {
  type = object({
    host_name                    = string # (Required) The Hostname to use for the corresponding endpoint.
    certificate                  = string # (Optional) The Base64 Encoded Certificate. (Mutually exclusive with kv_certificate_secret_id)
    certificate_password         = string # (Optional) The password associated with the certificate provided above.
    kv_certificate_secret_id     = string # (Optional) The ID of the Key Vault Certifcate Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12
    negotiate_client_certificate = bool   # (Optional) Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.
  })
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]+\\.[a-z]{2,}$|^[a-z][a-z0-9-_]+\\.[a-z0-9-]+\\.[a-z]{2,}$", var.developer_portal.host_name))
    error_message = "The variable 'developer_portal.host_name' must be a valid domain name, ex name.domain.no or domain.no."
  }
  sensitive = true
}

variable "management" {
  type = object({
    enabled                      = bool
    host_name                    = string # (Required) The Hostname to use for the corresponding endpoint.
    certificate                  = string # (Optional) The Base64 Encoded Certificate. (Mutually exclusive with kv_certificate_secret_id)
    certificate_password         = string # (Optional) The password associated with the certificate provided above.
    kv_certificate_secret_id     = string # (Optional) The ID of the Key Vault Certifcate Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12
    negotiate_client_certificate = bool   # (Optional) Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.
  })
  default {
    enabled                      = false
    host_name                    = null
    certificate                  = null
    certificate_password         = null
    kv_certificate_secret_id     = null
    negotiate_client_certificate = false
  }
  validation {
    condition     = var.management.host_name == null || can(regex("^[a-z][a-z0-9-]+\\.[a-z]{2,}$|^[a-z][a-z0-9-_]+\\.[a-z0-9-]+\\.[a-z]{2,}$", var.management.host_name))
    error_message = "The variable 'management.host_name' must be a valid domain name, ex name.domain.no or domain.no."
  }
  sensitive = true
}

variable "scm" {
  type = object({
    enabled                      = bool
    host_name                    = string # (Required) The Hostname to use for the corresponding endpoint.
    certificate                  = string # (Optional) The Base64 Encoded Certificate. (Mutually exclusive with kv_certificate_secret_id)
    certificate_password         = string # (Optional) The password associated with the certificate provided above.
    kv_certificate_secret_id     = string # (Optional) The ID of the Key Vault Certifcate Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12
    negotiate_client_certificate = bool   # (Optional) Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.
  })
  default {
    enabled                      = false
    host_name                    = null
    certificate                  = null
    certificate_password         = null
    kv_certificate_secret_id     = null
    negotiate_client_certificate = false
  }
  validation {
    condition     = var.scm.host_name == null || can(regex("^[a-z][a-z0-9-]+\\.[a-z]{2,}$|^[a-z][a-z0-9-_]+\\.[a-z0-9-]+\\.[a-z]{2,}$", var.scm.host_name))
    error_message = "The variable 'scm.host_name' must be a valid domain name, ex name.domain.no or domain.no."
  }
  sensitive = true
}

variable "portal" {
  type = object({
    enabled                      = bool
    host_name                    = string # (Required) The Hostname to use for the corresponding endpoint.
    certificate                  = string # (Optional) The Base64 Encoded Certificate. (Mutually exclusive with kv_certificate_secret_id)
    certificate_password         = string # (Optional) The password associated with the certificate provided above.
    kv_certificate_secret_id     = string # (Optional) The ID of the Key Vault Certifcate Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12
    negotiate_client_certificate = bool   # (Optional) Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.
  })
  default {
    enabled                      = false
    host_name                    = null
    certificate                  = null
    certificate_password         = null
    kv_certificate_secret_id     = null
    negotiate_client_certificate = false
  }
  validation {
    condition     = var.portal.host_name == null || can(regex("^[a-z][a-z0-9-]+\\.[a-z]{2,}$|^[a-z][a-z0-9-_]+\\.[a-z0-9-]+\\.[a-z]{2,}$", var.portal.host_name))
    error_message = "The variable 'portal.host_name' must be a valid domain name, ex name.domain.no or domain.no."
  }
  sensitive = true
}
