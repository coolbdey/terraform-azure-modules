variable "name" {}
variable "rg_name" {}
variable "storage_account_type" {
  type        = string
  description = "(Required) The type of storage to use for the managed disk. Possible values are Standard_LRS, StandardSSD_ZRS, Premium_LRS, Premium_ZRS, StandardSSD_LRS or UltraSSD_LRS."
  default     = "Standard_LRS"
  validation {
    condition     = can(regex("^Standard_LRS$|^StandardSSD_LRS$|^Premium_LRS$|^StandardSSD_ZRS$|^Premium_ZRS$|UltraSSD_LRS$", var.storage_account_type))
    error_message = "The variable 'storage_account_type' must have value storage_account_type: Standard_LRS (default), StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS, Premium_ZRS or UltraSSD_LRS."
  }
}

variable "disk_size_gb" {
  type        = number
  description = "(Optional, Required for a new managed disk) Specifies the size of the managed disk to create in gigabytes. If create_option is Copy or FromImage, then the value must be equal to or greater than the source's size. The size can only be increased."
  default     = 20
}

variable "create_option" {
  type        = string
  description = " (Required) The method to use when creating the managed disk. Changing this forces a new resource to be created. Possible values include:"
  default     = "Empty"
  validation {
    condition     = can(regex("^Import$|^Empty$|^Copy$|^FromImage$|^Restore$", var.create_option))
    error_message = "The variable 'create_option' must be: Import, Empty (default), Copy, FromImage, or Restore."
  }
}

variable "encryption_settings" {
  type = object({
    enabled         = bool
    key_url         = string # (Required) The URL to the Key Vault Key used as the Key Encryption Key. This can be found as id on the azurerm_key_vault_key resource.
    secret_url      = string # (Required) The URL to the Key Vault Secret used as the Disk Encryption Key. This can be found as id on the azurerm_key_vault_secret resource.
    source_vault_id = string # (Required) The URL of the Key Vault. This can be found as vault_uri on the azurerm_key_vault resource.
  })
  description = "Encryption settings"
  default = {
    enabled         = false
    key_url         = null
    secret_url      = null
    source_vault_id = null
  }
}

variable "disk_encryption_set_id" {
  type        = string
  description = "(Optional) The ID of a Disk Encryption Set which should be used to encrypt this Managed Disk."
  default     = null
}

variable "disk_access_id" {
  type        = string
  description = "The ID of the disk access resource for using private endpoints on disks."
  default     = null
}

variable "hyper_v_generation" {
  type        = string
  description = "(Optional) The HyperV Generation of the Disk when the source of an Import or Copy operation targets a source that contains an operating system. Possible values are V1 and V2. Changing this forces a new resource to be created."
  default     = "v2"
  validation {
    condition     = can(regex("^v1$|^v2$", var.hyper_v_generation))
    error_message = "The variable 'hyper_v_generation' must be: v1, or v2 (default)."
  }
}
variable "image_reference_id" {
  type        = string
  description = "(Optional) ID of an existing platform/marketplace disk image to copy when create_option is FromImage. This field cannot be specified if gallery_image_reference_id is specified."
  default     = null
}

variable "logical_sector_size" {
  type        = number
  description = "(Optional) Logical Sector Size. Possible values are: 512 and 4096. Defaults to 4096. Only with UltraSSD_LRS disks. Changing this forces a new resource to be created."
  default     = 4096
  validation {
    condition     = can(regex("^512$|^4096$", var.logical_sector_size))
    error_message = "The variable 'logical_sector_size' must be: 512, or 4096 (default)."
  }
}

variable "os_type" {
  type        = string
  description = "(Optional) Specify a value when the source of an Import or Copy operation targets a source that contains an operating system. Valid values are Linux or Windows"
  default     = "Windows"
  validation {
    condition     = can(regex("^Linux$|^Windows$", var.os_type))
    error_message = "The variable 'os_type' must be: Linux, or Windows (default)."
  }
}

variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Whether it is allowed to access the disk via public network. Defaults to true."
  default     = true
}

variable "source_resource_id" {
  type        = string
  description = "(Optional) The ID of an existing Managed Disk to copy create_option is Copy or the recovery point to restore when create_option is Restore"
  default     = null
}

variable "source_uri" {
  type        = string
  description = "(Optional) URI to a valid VHD file to be used when create_option is Import."
  default     = null
}

variable "storage_account_id" {
  type        = string
  description = "(Optional) The ID of the Storage Account where the source_uri is located. Required when create_option is set to Import. Changing this forces a new resource to be created."
  default     = null
}

variable "tier" {
  type        = string
  description = "(Optional) The disk performance tier to use. Possible values are documented here. This feature is currently supported only for premium SSDs."
  default     = null
}

variable "max_shares" {
  type        = number
  description = "(Optional) The maximum number of VMs that can attach to the disk at the same time. Value greater than one indicates a disk that can be mounted on multiple VMs at the same time. https://docs.microsoft.com/en-us/azure/virtual-machines/disks-shared"
  default     = 1
  validation {
    condition     = can(regex("^1$|^3$|^5$|^10$", var.max_shares))
    error_message = "The variable 'max_shares' must be: 1 (Default), 3, 5 or 10 depending on the 'storage_account_type'."
  }
}

variable "network_access_policy" {
  type        = string
  description = "Policy for accessing the disk via network. Allowed values are AllowAll, AllowPrivate, and DenyAll."
  default     = "AllowAll"
  validation {
    condition     = can(regex("^AllowAll$|^AllowPrivate$|^DenyAll$", var.network_access_policy))
    error_message = "The variable 'network_access_policy' must be: AllowAll (Default), AllowPrivate, or DenyAll."
  }
}
variable "edge_zone" {
  type        = string
  description = "(Optional) Specifies the Edge Zone within the Azure Region where this Public IP should exist. Changing this forces a new Public IP to be created."
  default     = null
}

variable "zone" {
  type        = string
  description = "(Optional) Specifies the Availability Zone in which this Managed Disk should be located. Changing this property forces a new resource to be created. https://docs.microsoft.com/en-us/azure/availability-zones/az-overview"
  default     = null
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}