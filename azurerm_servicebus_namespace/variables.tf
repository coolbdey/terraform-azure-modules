variable "name" {}
variable "rg_name" {}

variable "sku" {
  type        = string
  description = "(Required) Defines which tier to use. Options are Basic, Standard or Premium. Changing this forces a new resource to be created."
  default     = "Standard"
}
variable "capacity" {
  type        = number
  description = "(Optional) Specifies the capacity. When sku is Premium, capacity can be 1, 2, 4, 8 or 16. When sku is Basic or Standard, capacity can be 0 only."
  default     = 0
}
variable "topics" {
  type = list(object({
    name = string
    subscriptions = list(object({
      name      = string
      max_count = number
    }))
  }))
  description = "A list of Service bus topics"
  default     = []
}
variable "queues" {
  type = list(object({
    name        = string
    rule_manage = bool
    rule_listen = bool
    rule_send   = bool
  }))
  description = "A list of Service bus queues"
  default     = []
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
  description = "Role definition name to give access to, ex: Azure Service Bus Data Owner. Note: var.enable_rbac_authorization must be true"
  default     = []
}
variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
