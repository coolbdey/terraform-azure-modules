variable "enabled" {
  type        = bool
  description = "Is the App Service Enabled?"
  default     = true
}
variable "backup_enabled" {
  type        = bool
  description = "Is this Backup enabled?"
  default     = true
}
variable "name" {}
variable "rg_name" {}
variable "asp_name" {}
variable "sa_name" {}
variable "app_insights" {
  type = object({
    enabled             = bool
    instrumentation_key = string
    connection_string   = string
  })
  description = "Aplication insights"
  default = {
    enabled             = false
    instrumentation_key = null
    connection_string   = null
  }
}
variable "connection_strings" {
  type = list(object({
    name = string
    type = string
    conn = string
  }))
  description = "A list of connectionstrings"
  default     = []

  validation {
    condition = alltrue([
      for item in var.connection_strings : can(regex("^SQLAzure$|^SQLServer$|^Custom$|^PIHub$|`^DocDb$|^EventHub$|^MySQL$|^NotificationHub$|^PostgreSQL$|^RedisCache$|^ServiceBus$", item.type))
    ])
    error_message = "The variable 'connection_strings' must have valid type: 'SQLAzure', 'SQLServer', 'Custom', .. ."
  }
}
variable "client_cert_enabled" {
  type        = bool
  description = "Does the App Service require client certificates for incoming requests? "
  default     = false
}
variable "ftps_state" {
  type        = string
  description = "(Optional) State of FTP / FTPS service for this App Service. Possible values include: AllAllowed, FtpsOnly and Disabled. AppService log requires this to be activated."
  default     = "FtpsOnly"
  validation {
    condition     = contains(["Disabled", "FtpsOnly", "AllAllowed"], var.ftps_state)
    error_message = "Variable \"ftps_state\" must either be \"Disabled\", \"FtpsOnly\" or \"AllAllowed\"."
  }
}
variable "https_only" {
  type        = bool
  description = "Can the App Service only be accessed via HTTPS?"
  default     = false
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
variable "dotnetcore" {
  type        = string
  description = "Dotnet Core. "
  default     = "DOTNETCORE|3.1"
}
variable "app_settings" {
  type        = map(string)
  description = "Map of App Settings. This will be merged with default app settings"
  default     = {}
}
variable "os_type" {
  type        = string
  description = "Empty for Windows. (Optional) A string indicating the Operating System type for this function app."
  default     = ""
  validation {
    condition     = contains(["linux", ""], var.os_type)
    error_message = "Variable \"os_type\" must either be \"\" or \"linux\"."
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
