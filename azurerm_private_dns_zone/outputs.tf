output "id" {
  description = "The Private DNS Zone ID."
  value       = azurerm_private_dns_zone.dns.id
}

output "a_id" {
  description = "The Private DNS A Record ID."
  value       = [for item in azurerm_private_dns_a_record.a : item.id]
}
output "a_fqdn" {
  description = "The FQDN of the DNS A Record."
  value       = [for item in azurerm_private_dns_a_record.a : item.fqdn]
}

output "cname_id" {
  description = "The Private DNS CNAME Record ID."
  value       = [for item in azurerm_private_dns_cname_record.cname : item.id]
}
output "cname_fqdn" {
  description = "The FQDN of the DNS CNAME Record."
  value       = [for item in azurerm_private_dns_cname_record.cname : item.fqdn]
}
