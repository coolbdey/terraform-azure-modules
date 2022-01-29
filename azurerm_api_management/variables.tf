variable "name" {}
variable "lock_resource" {
  type        = bool
  description = "Adds lock level CanNotDelete to the resource"
  default     = false
}
variable "publisher_name" {}
variable "publisher_email" {
  type = string
  validation {
    condition     = can(regex("^[0-9a-z_\\-.]+@[a-z0-9\\-_]+\\.[a-z]{2,}$", var.publisher_email))
    error_message = "Variable \"publisher_email\" must be a valid email address."
  }
}
variable "logger_name" {}
variable "diag_identifier" {
  type        = string
  description = "(Required) The diagnostic identifier for the API Management Service. At this time the only supported value is applicationinsights or azuremonitor. Changing this forces a new resource to be created."
  default     = "applicationinsights"
  validation {
    condition     = contains(["applicationinsights", "azuremonitor"], var.diag_identifier)
    error_message = "Variable \"diag_identifier\" must either be \"applicationinsights\" or \"azuremonitor\"."
  }
}
variable "all_apis_policy" {
  type        = string
  description = "All APIs policy"
  default     = <<XML
    <policies>
      <inbound />
      <backend />
      <outbound />
      <on-error />
    </policies>
XML

}
variable "rg_name" {}
variable "appi_rg_name" {}
variable "appi_name" {}
variable "sku_name" {
  type        = string
  description = "(Required) sku_name is a string consisting of two parts separated by an underscore(_). The first part is the name, valid values include: Consumption, Developer, Basic, Standard and Premium. The second part is the capacity (e.g. the number of deployed departments of the sku), which must be a positive integer (e.g. Developer_1)."
  default     = "Standard_1"
}
variable "protocol" {
  type        = string
  description = "(Required) The protocol used by the backend host. Possible values are http or soap."
  default     = "http"
  validation {
    condition     = contains(["http", "soap"], var.protocol)
    error_message = "Variable \"protocol\" must either be \"http\" or \"soap\"."
  }
}
variable "groups" {
  type = list(object({
    name         = string
    display_name = string
    description  = string
  }))
  description = "A list of API Management groups"
  default     = []
}
variable "users" {
  type = list(object({
    firstname = string
    lastname  = string
    email     = string
  }))
  description = "A list of API Management users"
  default     = []
}
variable "products" {
  type = list(object({
    id                    = string
    display_name          = string
    description           = string
    approval_required     = bool
    subscription_required = bool
    published             = bool
  }))
  description = "A list of API Management Products"
  default     = []
}
variable "backends" {
  type = list(object({
    name        = string
    title       = string
    description = string
    url         = string
    protocol    = string
  }))
  description = "A list of API Management backends (App Service, Function App etc)"
  default     = []
}
variable "named_values" {
  type = list(object({
    name         = string
    display_name = string
    value        = string
    secret       = bool
  }))
  description = "A list of API Management Named Values"
  default     = []
}
variable "notifications" {
  type = list(object({
    notification_type = string
    email             = string
  }))
  description = "A list of API Management Notification Receipient emails"
  default     = []
}
variable "apis" {
  type = list(object({
    name                  = string
    display_name          = string
    description           = string
    path                  = string
    policy_xml            = string
    protocols             = list(string)
    revision              = number
    subscription_required = bool
    service_url           = string
  }))
  description = "A list of API Management API and corresonding policies."
  default     = []
}
variable "auth_servers" {
  type = list(object({
    name                         = string
    authorization_methods        = list(string)
    authorization_endpoint       = string
    bearer_token_sending_methods = list(string)
    client_authentication_method = list(string)
    client_id                    = string
    client_secret                = string
    client_registration_endpoint = string
    description                  = string
    display_name                 = string
    grant_types                  = list(string)
    support_state                = bool
    token_endpoint               = string
    token_body_parameter_name    = string
    token_body_parameter_value   = string
  }))
  description = "A list of API Management Authorization Server"
  default     = []
}
variable "import_policy_all" {
  type        = bool
  description = "Import APIM policies using on Operation All level"
  default     = false
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
  description = "Role definition name to give access to, ex: API Management Service Contributor. Note: var.enable_rbac_authorization must be true"
  default     = []
}
variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
