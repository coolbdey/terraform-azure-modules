variable "databases" {
  type = list(object({
    database = string
    username = string
    password = string
    roles    = list(string)
    language = string
    kv_secret = object({
      name  = string
      value = string
    })
  }))
  description = "A list object of database names"
  default     = []
  sensitive   = true
}
variable "rg_name" {}
variable "kv_name" {}
variable "sql_name" {}
variable "sa_name" {}
variable "admin_user" {}
variable "admin_pass" {}
variable "sku_name" {
  type        = string
  description = "Specifies the name of the sku used by the database. Only changing this from tier Hyperscale to another tier will force a new resource to be created"
  default     = "S0" # BC_Gen5_2
}

variable "collation" {
  type        = string
  description = "sSpecifies the collation of the database. Changing this forces a new resource to be created"
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "max_size_gb" {
  type        = number
  description = "The max size of the database in gigabytes."
  default     = 4
}

variable "geo_backup_enabled" {
  type        = bool
  description = "A boolean that specifies if the Geo Backup Policy is enabled."
  default     = true
}

variable "storage_account_type" {
  type        = string
  description = "Specifies the storage account type used to store backups for this database. Changing this forces a new resource to be created."
  default     = "Geo"
  validation {
    condition     = can(regex("Local|Geo|Zone", var.storage_account_type))
    error_message = "Variable 'storage_account_type' must be Local, Geo (Default) or Zone."
  }
}

variable "tdal_retention_days" {
  type        = number
  description = "Specifies the number of days to keep in the Threat Detection audit logs."
  default     = 7
}

variable "log_retension_days" {
  type        = number
  description = "Specifies the number of days to retain logs for in the storage account."
  default     = 14
}

variable "pit_retention_days" {
  type        = number
  description = "Point In Time Restore configuration. Value has to be between 7 and 35"
  default     = 7
}

variable "log_monitoring_enabled" {
  type        = bool
  description = "Enable audit events to Azure Monitor? To enable server audit events to Azure Monitor, please enable its main database audit events to Azure Monitor."
  default     = true
}

variable "tdp_enabled" {
  type        = string
  description = "The State of the Policy. Possible values are Enabled, Disabled or New"
  default     = "Enabled"
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
variable "tenant_id" {}
variable "client_id" {}
variable "client_secret" {}
