variable "name" {}
variable "lock_resource" {
  type        = bool
  description = "Adds lock level CanNotDelete to the resource"
  default     = false
}
variable "sa_name" {
  type        = string
  description = "The linked and insights Storage account used by Log Analytics. Default is null"
  default     = null
}
variable "rg_name" {}
variable "sku" {
  type        = string
  description = "Log analytics workspace sku for this resource"
  default     = "PerGB2018"
}
variable "retention_in_days" {
  type        = number
  description = "Specifies the number of days to retain logs for in the storage account."
  default     = 30
}
variable "daily_quota_gb" {
  type        = number
  description = " (Optional) The workspace daily quota for ingestion in GB. Defaults to -1 (unlimited) if omitted."
  default     = 100
}
variable "data_source_type" {
  type        = string
  description = "(Required) The data source type which should be used for this Log Analytics Linked Storage Account. Possible values are \"customlogs\", \"azurewatson\", \"query\", \"ingestion\" and \"alerts\". Changing this forces a new Log Analytics Linked Storage Account to be created."
  default     = "customlogs"
}

variable "enable_rbac_authorization" {
  type        = bool
  description = "Activates RBAC on the resource"
  default     = false
}
variable "rbac_roles" {
  type = list(object({
    role_definition_name = string
    principal_id         = string
  }))
  description = "Role definition name to give access to, ex: Storage Blob Data Contributor. Note: var.enable_rbac_authorization must be true"
  default     = []
}
variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
