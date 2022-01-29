locals {
  dns_servers = var.use_azure_dns ? null : length(var.dns_servers) == 0 ? null : var.dns_servers
}