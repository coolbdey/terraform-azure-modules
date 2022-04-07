variable "rg_name" {}
variable "kv_name" {}
variable "sqlserver" {
  type = object({
    name             = string
    login_name       = string # (Required) The name of the server login. Changing this forces a new resource to be created.
    password         = string #  (Required) The password of the server login.
    default_database = string # (Optional) The default database of this server login. Defaults to master. This argument does not apply to Azure SQL Database.
    default_language = string # (Optional) The default language of this server login. Defaults to us_english. This argument does not apply to Azure SQL Database.
  })
  description = "The SQL server"
}
variable "databases" {
  type = list(object({
    database         = string
    username         = string       # Required) The name of the database user. Changing this forces a new resource to be created
    login_name       = string       # (Optional) The login name of the database user. This must refer to an existing SQL Server login name. Conflicts with the password argument. Changing this forces a new resource to be created.
    password         = string       # (Optional) The password of the database user. Conflicts with the login_name argument. Changing this forces a new resource to be created.
    roles            = list(string) # (Optional) List of database roles the user has. Defaults to none
    default_language = string       # (Optional) Specifies the default language for the user. If no default language is specified, the default language for the user will bed the default language of the database. This argument does not apply to Azure SQL Database or if the user is not a contained database user.
    default_schema   = string       # (Optional) Specifies the first schema that will be searched by the server when it resolves the names of objects for this database user. Defaults to dbo.
    kv_secret = object({
      name  = string # Name og the KV secret
      value = string # Database user Connection String
    })
  }))
  description = "A list object of database names"
  default     = []
  sensitive   = true
}
variable "sa_name" {}
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

variable "elastic_pool_id" {
  type = string
  description = "(Optional) Specifies the ID of the elastic pool containing this database."
  default = null
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

variable "auditing_enabled" {
  type        = bool
  description = "(Required) Whether to enable the extended auditing policy. Possible values are true and false. Defaults to true."
  default     = true
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
