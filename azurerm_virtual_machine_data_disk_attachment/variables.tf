variable "create_option" {
  type        = string
  description = "(Optional) The Create Option of the Data Disk, such as Empty or Attach. Defaults to Attach. Changing this forces a new resource to be created."
  default     = "Attach"
  validation {
    condition     = can(regex("^Empty$|^Attach$", var.create_option))
    error_message = "The variable 'create_option' must be Empty or Attach (Default)."
  }
}
variable "managed_disk_id" {
  type        = string
  description = "(Required) The ID of an existing Managed Disk which should be attached. Changing this forces a new resource to be created."
}
variable "virtual_machine_id" {
  type        = string
  description = "(Required) The ID of the Virtual Machine to which the Data Disk should be attached. Changing this forces a new resource to be created."
}
variable "lun" {
  type        = number
  description = "(Required) The Logical Unit Number of the Data Disk, which needs to be unique within the Virtual Machine. Changing this forces a new resource to be created."
  default     = 10
}

variable "caching" {
  type        = string
  description = "(Required) Specifies the caching requirements for this Data Disk. Possible values include None, ReadOnly and ReadWrite."
  default     = "ReadWrite"
  validation {
    condition     = can(regex("^None$|^ReadOnly$|^ReadWrite$", var.caching))
    error_message = "The variable 'caching' must be None, ReadOnly or ReadWrite (default)."
  }
}

variable "write_accelerator_enabled" {
  type        = bool
  description = "(Optional) Specifies if Write Accelerator is enabled on the disk. This can only be enabled on Premium_LRS managed disks with no caching and M-Series VMs. Defaults to false."
  default     = false
}