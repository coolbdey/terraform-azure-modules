
variable "members_owner" {
  type    = list(string)
  default = []
}
variable "members_contr" {
  type    = list(string)
  description = "User Principal Names members that will be added to the "
  default = []
}
variable "members_readr" {
  type    = list(string)
  default = []
}
variable "aad_group" {}
variable "desc_owner" {
  type = string
  description = "Description for owner group"
  default = "Terraform: Owner group"
}
variable "description_contr" {
  type = string
  description = "Description for contributor group"
  default = "Terraform: Contributor group"
}
variable "description_owner" {
  type = string
  description = "Description for owner group"
  default = "Terraform: Owner group"
}
variable "description_readr" {
  type = string
  description = "Description for reader group"
  default = "Terraform: Reader group"
}
variable "prevent_duplicate_names" {
  type        = bool
  description = "Prevents duplicate names"
  default     = false

}