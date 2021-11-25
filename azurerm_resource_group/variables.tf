
variable "name" {}
variable "location" {}
variable "lock_resource" {
  type        = bool
  description = "Adds lock level CanNotDelete to the resource"
  default     = false
}
variable "delete_all_locks" {
  type        = bool
  description = "Deletes all locks the resource"
  default     = false
}
variable "rbac_roles" {
  type = list(object({
    role_definition_name = string
    principal_id         = string
  }))
  description = "Role definition name to give access to, ex: Key Vault Administrator. Note: var.enable_rbac_authorization must be true"
  default     = []
}
variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
