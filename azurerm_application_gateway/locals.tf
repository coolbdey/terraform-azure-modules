
locals {
  auth_cert_name                 = "${var.name}-auth"
  backend_address_pool_name      = "${var.name}-beap"
  frontend_port_name             = "${var.name}-feport"
  frontend_ip_configuration_name = "${var.name}-feip"
  http_setting_name              = "${var.name}-be-htst"
  listener_name                  = "${var.name}-httplstn"
  request_routing_rule_name      = "${var.name}-rqrt"
  rewrite_rule_set_name          = "${var.name}-rrsn"
  ssl_certificate_name           = "${var.name}-cert"

  uai_name = "${var.name}-uai"
}
