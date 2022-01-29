variable "rg_name" {}
variable "sa_name" {}
variable "rg_dst_name" {}
variable "sa_dst_name" {}

variable "containers" {
  type = list(object({
    src_container = string
    dst_container = string
  }))
  description = "Storage containers to replicate"
  default     = []
}
