variable "enabled" {
  type        = bool
  description = "Is the App Service Enabled?"
  default     = true
}
variable "dotnetcore" {
  type        = string
  description = "Dotnet Core. "
  default     = "DOTNETCORE|3.1"
}
variable "name" {}
variable "rg_name" {}
variable "asp_name" {}
/*
variable "vnet_enabled" {
  type    = bool
  default = false
}
variable "vnet_rg_name" {}
variable "vnet_name" {}
variable "snet_name" {}
*/
variable "client_affinity_enabled" {
  type        = bool
  description = "Should the App Service send session affinity cookies, which route client requests in the same session to the same instance? Disable for performance"
  default     = false
}
variable "client_cert_enabled" {
  type        = bool
  description = "Does the App Service require client certificates for incoming requests? "
  default     = false
}
variable "https_only" {
  type        = bool
  description = "Can the App Service only be accessed via HTTPS?"
  default     = true
}

variable "app_kind" {
  type        = string
  description = "The App Service operating system type: Windows of Linux"
  default     = "windows"
  validation {
    condition     = contains(["windows", "linux"], var.app_kind)
    error_message = "Variable \"app_kind\" must either be \"windows\" or \"linux\"."
  }
}
variable "use_32_bit_worker_process" {
  type        = bool
  description = "(Optional) Should the Function App run in 32 bit mode, rather than 64 bit mode?. When using an App Service Plan in the Free or Shared Tiers use_32_bit_worker_process must be set to true."
  default     = false
}
variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
