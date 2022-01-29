variable "name" {}
variable "rg_name" {}
variable "sa_name" {}

variable "datastore_type" {
  type        = string
  description = "(Required) Specifies the type of the data store. Possible values are ArchiveStore, SnapshotStore and VaultStore."
  default     = "ArchiveStore"

  validation {
    condition     = contains(["ArchiveStore", "SnapshotStore", "VaultStore"], var.datastore_type)
    error_message = "Variable \"datastore_type\" must either be \"ArchiveStore\" or \"SnapshotStore\" or \"VaultStore\"."
  }
}
variable "redundancy" {
  type        = string
  description = "(Required) Specifies the backup storage redundancy. Possible values are GeoRedundant and LocallyRedundant. Changing this forces a new Backup Vault to be created."
  default     = "LocallyRedundant"

  validation {
    condition     = contains(["GeoRedundant", "LocallyRedundant"], var.redundancy)
    error_message = "Variable \"redundancy\" must either be \"GeoRedundant\" or \"LocallyRedundant\"."
  }
}
variable "retention_duration" {
  type    = string
  default = "P30D"
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
