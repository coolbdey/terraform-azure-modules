variable "name" {}
variable "rg_name" {}
variable "law_name" {
  type        = string
  description = "The name of Log Analytics Workspace, if enabled"
  default     = "loganalytics"
}
variable "law_workspace_id" {
  type        = string
  description = "Log Analytics Workspace Id. Default is null"
  default     = null
}
variable "law_enabled" {
  type        = bool
  description = "Enable Log Analytics Workspace"
  default     = false
}
variable "law_rg_name" {
  type        = string
  description = "The resource group name of the enabled Log Analytics Workspace."
  default     = "undefined"
}
variable "application_type" {
  type        = string
  description = "(Required) Specifies the type of Application Insights to create. Valid values are ios for iOS, java for Java web, MobileCenter for App Center, Node.JS for Node.js, other for General, phone for Windows Phone, store for Windows Store and web for ASP.NET. Please note these values are case sensitive; unmatched values are treated as ASP.NET by Azure. Changing this forces a new resource to be created."
  default     = "web"
}
variable "daily_data_cap_in_gb" {
  type        = number
  description = "(Optional) Specifies the Application Insights component daily data volume cap in GB."
  default     = 100
}
variable "retention_in_days" {
  type        = number
  description = "Optional) Specifies the retention period in days. Possible values are 30, 60, 90, 120, 180, 270, 365, 550 or 730. Defaults to 90."
  default     = 60
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}