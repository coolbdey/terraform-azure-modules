variable "name" {}
variable "lock_resource" {
  type        = bool
  description = "Adds lock level CanNotDelete to the resource"
  default     = false
}
variable "rg_name" {}
variable "kv_name" {}
variable "nic_name" {}
variable "vmss_name" {
  type        = string
  description = "Virtual Machine Scale Set name"
  default     = null
}
variable "ppg_name" {
  type        = string
  description = "(Optional) The name of the Proximity Placement Group which the Virtual Machine should be assigned to."
  default     = null
}
variable "disk_name" {
  type        = string
  description = "OS disk name"
  default     = "system"
}
variable "sa_type" {
  type        = string
  description = "(Required) The Type of Storage Account which should back this Data Disk. Possible values include Standard_LRS, StandardSSD_LRS, Premium_LRS and UltraSSD_LRS."
  default     = "Standard_LRS"
}
variable "cert_name" {}
variable "vm_size" {
  type        = string
  description = "(Required) Specifies the size of the Virtual Machine. See also Azure VM Naming Conventions. https://docs.microsoft.com/en-us/azure/virtual-machines/dv2-dsv2-series"
  default     = "Standard_DS2_v2"
}
variable "image_sku" {
  type    = string
  default = "2019-Datacenter"
}
variable "image_version" {
  type    = string
  default = "latest"
}
variable "computer_name" {
  type        = string
  description = "(Optional) Specifies the Hostname which should be used for this Virtual Machine. If unspecified this defaults to the value for the name field. If the value of the name field is not a valid computer_name, then you must specify computer_name. Changing this forces a new resource to be created"
  default     = null
}
variable "admin_user" {
  type        = string
  description = "(Required) Specifies the name of the local administrator account."
}
variable "admin_pass" {
  type        = string
  description = "(Required for Windows, Optional for Linux) The password associated with the local administrator account."
}
variable "timezone" {
  # https://jackstromberg.com/2017/01/list-of-time-zones-consumed-by-azure/
  type        = string
  description = "(Optional) Specifies the time zone of the virtual machine"
  default     = "W. Europe Standard Time"
}
variable "zones" {
  type        = list(number)
  description = "(Optional) A list of Availability Zones in which the Virtual Machines in this Scale Set should be created in. Changing this forces a new resource to be created."
  default     = [1, 2, 3]
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
