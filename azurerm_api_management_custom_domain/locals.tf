locals {
  name               = join("", [replace(var.host_name_proxy, ".", "-"), "-self"])
  key_size           = 2048
  days_before_expiry = 30
  validity_in_months = 24
  subject            = "CN=${var.host_name_proxy}"
}
