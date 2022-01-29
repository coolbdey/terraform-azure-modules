variable "name" {
  type    = string
  default = "nginx:latest"
}
variable "keep_locally" {
  type    = bool
  default = false
}
variable "name_container" {
  type = string
}
