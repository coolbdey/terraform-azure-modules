locals {


  server_authentication = var.auth_server ? ["1.3.6.1.5.5.7.3.1"] : []
  client_authentication = var.auth_client ? ["1.3.6.1.5.5.7.3.2"] : []
  extended_key_usage    = concat(local.server_authentication, local.client_authentication)
}
