variable "name" {}
variable "rg_name" {}
variable "kv_key_id" {
  type        = string
  description = "(Required) Specifies the URL to a Key Vault Key (either from a Key Vault Key, or the Key URL for the Key Vault Secret)."
}
variable "auto_key_rotation_enabled" {
  type        = bool
  description = "(Optional) Boolean flag to specify whether Azure Disk Encryption Set automatically rotates encryption Key to latest version. Defaults to false."
  default     = false
}
variable "encryption_type" {
  type        = string
  description = "(Optional) The type of key used to encrypt the data of the disk. Possible values are EncryptionAtRestWithCustomerKey and EncryptionAtRestWithPlatformAndCustomerKeys. Defaults to EncryptionAtRestWithCustomerKey"
  default     = "EncryptionAtRestWithCustomerKey"
  validation {
    condition     = can(regex("^EncryptionAtRestWithCustomerKey$|^EncryptionAtRestWithPlatformAndCustomerKeys$", var.encryption_type))
    error_message = "Variable 'encryption_type' must be either EncryptionAtRestWithCustomerKey (default) or EncryptionAtRestWithPlatformAndCustomerKeys."
  }
}
variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}