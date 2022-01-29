variable "name" {
  type = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]+$", var.name))
    error_message = "The variable 'name', but must be ex: alphanumericdash."
  }
}
variable "rg_name" {}
variable "kv_name" {}
variable "dns_names" {
  type    = list(string)
  default = []

  validation {
    condition = alltrue([
      for item in var.dns_names : can(regex("^[a-z][a-z0-9-]+\\.[a-z]{2,}$|^[a-z][a-z0-9-]+\\.[a-z0-9-]+\\.[a-z]{2,}$", item))
    ])
    error_message = "The variable 'dns_names' must have valid domain names, ex name.domain.no or domain.no."
  }
}
variable "key_size" {
  type    = number
  default = 2048

  validation {
    condition     = can(regex("^1024|2048|4096$", var.key_size))
    error_message = "The variable 'key_size' must be one of 1024, 2048, or 4096."
  }
}
variable "validity_in_months" {
  type = number

  default = 12
}
variable "days_before_expiry" {
  type        = number
  description = "(Optional) The number of days before the Certificate expires that the action associated with this Trigger should run. Changing this forces a new resource to be created. "
  default     = 30
}
variable "key_usage" {
  type = list(string)
  default = [
    "cRLSign",
    "dataEncipherment",
    "digitalSignature",
    "keyAgreement",
    "keyCertSign",
    "keyEncipherment"
  ]
}
variable "auth_client" {
  type        = bool
  description = "Add Extended key usage for Client Authentication. Defaults to false."
  default     = false
}
variable "auth_server" {
  type        = bool
  description = "Add Extended key usage for Server Authentication. Defaults to true."
  default     = true
}
variable "content_type" {
  type        = string
  description = "The secret format. Default to P12 "
  default     = "application/x-pkcs12"
}

variable "subject" {
  type        = string
  description = "(Required) The x509 certificate subject"

  validation {
    condition     = can(regex("^CN=[a-z][a-z0-9-_]+\\.[a-z0-9]+\\.[a-z]{2,}$|^CN=[a-z][a-z0-9-_]+\\.[a-z.-]+$", var.subject))
    error_message = "The variable 'subject', but must be ex: CN=name.domain.no."
  }
}
