variable "asvnsc_apps_wa" {
  type = list(object({
    name    = string
    rg_name = string
  }))
  description = "Enables app_service_virtual_network_swift_connection for App Service"
  default     = []
}

variable "asvnsc_apps_fa" {
  type = list(object({
    name    = string
    rg_name = string
  }))
  description = "Enables app_service_virtual_network_swift_connection for Function app"
  default     = []
}

variable "asvnsc_snet_name" {
  type        = string
  description = "The name of the Subnet"
  default     = null
}
variable "asvnsc_snet_rg_name" {
  type    = string
  default = null
}
variable "asvnsc_snet_vnet_name" {
  type    = string
  default = null
}

variable "mssqlvn_rules" {
  type = list(object({
    sql_name  = string
    rule_name = string
    rg_name   = string
  }))
  description = "Enables azurerm_mssql_virtual_network_rule for SQL Server"
  default     = []
}

variable "mssqlvn_snet_name" {
  type    = string
  default = null
}
variable "mssqlvn_snet_rg_name" {
  type    = string
  default = null
}
variable "mssqlvn_snet_vnet_name" {
  type    = string
  default = null
}
