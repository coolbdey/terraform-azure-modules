
variable "members" {
  type    = list(string)
  default = []
}
variable "aad_group" {}
variable "application" {}
variable "environment" {}
variable "group_type" {}
variable "prevent_duplicate_names" {
  type        = bool
  description = "Prevents duplicate names"
  default     = false

}
variable "ignore_changes" {
  type = list(string)
  default = [members, owners]
}