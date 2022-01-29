variable "host_name_proxy" {
  type = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]+\\.[a-z]{2,}$|^[a-z][a-z0-9-_]+\\.[a-z0-9-]+\\.[a-z]{2,}$", var.host_name_proxy))
    error_message = "The variable 'host_name_proxy' must a valid domain name, ex name.domain.no or domain.no."
  }
}
variable "host_name_portal" {
  type = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]+\\.[a-z]{2,}$|^[a-z][a-z0-9-_]+\\.[a-z0-9-]+\\.[a-z]{2,}$", var.host_name_portal))
    error_message = "The variable 'host_name_portal' must a valid domain name, ex name.domain.no or domain.no."
  }
}
variable "rg_name" {}
variable "apim_name" {}
variable "kv_name" {}


