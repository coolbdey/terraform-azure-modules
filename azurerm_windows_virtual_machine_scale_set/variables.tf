variable "name" {}
variable "lock_resource" {
  type        = bool
  description = "Adds lock level CanNotDelete to the resource"
  default     = false
}
variable "rg_name" {}
variable "kv_name" {}
variable "cert_name" {}
variable "nic_name" {}
variable "nic_ip_configurations" {
  type = list(object({
    name                         = string
    agw_backend_address_pool_ids = list(string) # (Optional) A list of Backend Address Pools ID's from a Application Gateway which this Virtual Machine Scale Set should be connected to.
    asg_ids                      = list(string) # (Optional) A list of Application Security Group ID's which this Virtual Machine Scale Set should be connected to.
    lb_backend_ids               = list(string) # (Optional) A list of Backend Address Pools ID's from a Load Balancer which this Virtual Machine Scale Set should be connected to.
    lb_onbound_nat_rules_ids     = list(string) # (Optional) A list of NAT Rule ID's from a Load Balancer which this Virtual Machine Scale Set should be connected to.
    primary                      = bool
    public_ip_address = object({
      name                    = string
      domain_name_label       = string
      idle_timeout_in_minutes = number
      public_ip_prefix_id     = string # (Optional) The ID of the Public IP Address Prefix from where Public IP Addresses should be allocated. Changing this forces a new resource to be created
    })
    subnet_id = string # subnet_id is required if version is set to IPv4
    version   = string
  }))
  description = "(Required) One or more ip_configuration blocks as defined below"
  default = [{
    agw_backend_address_pool_ids = []
    asg_ids                      = []
    lb_backend_ids               = []
    lb_onbound_nat_rules_ids     = []
    name                         = null
    primary                      = true
    public_ip_address = {
      domain_name_label       = null
      idle_timeout_in_minutes = 4
      name                    = null
      public_ip_prefix_id     = null
    }
    subnet_id = null
    version   = "IPv4"
  }]
}
variable "nic_dns_servers" {
  type        = list(string)
  description = " (Optional) A list of IP Addresses of DNS Servers which should be assigned to the Network Interface."
  default     = []
}
variable "nic_enable_ip_forwarding" {
  type        = bool
  description = " (Optional) Does this Network Interface support IP Forwarding? Defaults to false."
  default     = false
}
variable "instances" {
  type        = number
  description = "(Required) The number of Virtual Machines in the Scale Set."
  default     = 1
}
variable "disk_name" {
  type        = string
  description = "OS disk name"
  default     = "system"
}
variable "admin_user" {
  type        = string
  description = "(Required) Specifies the name of the local administrator account."
}
variable "admin_pass" {
  type        = string
  description = "(Required for Windows, Optional for Linux) The password associated with the local administrator account."
}
variable "sku" {
  type        = string
  description = " (Required) The Virtual Machine SKU for the Scale Set, such as Standard_F2."
  default     = "Standard_F2"
}
variable "image_sku" {
  type    = string
  default = "2019-Datacenter"
}
variable "image_version" {
  type    = string
  default = "latest"
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
variable "computer_name_prefix" {
  type        = string
  description = " (Optional) The prefix which should be used for the name of the Virtual Machines in this Scale Set. If unspecified this defaults to the value for the name field. If the value of the name field is not a valid computer_name_prefix, then you must specify computer_name_prefix."
  default     = null
}
variable "timezone" {
  # https://jackstromberg.com/2017/01/list-of-time-zones-consumed-by-azure/
  type        = string
  description = "(Optional) Specifies the time zone of the virtual machine"
  default     = "W. Europe Standard Time"
}
variable "zone_balance" {
  type        = bool
  description = "(Optional) Should the Virtual Machines in this Scale Set be strictly evenly distributed across Availability Zones? Defaults to false. Changing this forces a new resource to be created."
  default     = true
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

